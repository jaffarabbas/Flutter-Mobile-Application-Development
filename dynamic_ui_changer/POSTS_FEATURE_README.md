# Posts Feature - JSONPlaceholder API Integration

## Overview
This document describes the complete **Posts** feature that demonstrates the MVVM + Riverpod architecture by fetching data from the JSONPlaceholder API.

---

## What Was Built

### API Integration
- **Base URL Updated**: Changed from `https://api.example.com` to `https://jsonplaceholder.typicode.com`
- **Endpoint**: `/posts` - Fetches list of posts from JSONPlaceholder

### Complete Feature Structure

```
lib/features/posts/
├── domain/                         # Business Logic Layer
│   ├── entities/
│   │   ├── post_entity.dart        # Business entity (immutable)
│   │   ├── post_entity.freezed.dart (generated)
│   │   └── post_entity.g.dart      (generated)
│   └── repositories/
│       └── posts_repository.dart   # Repository interface
│
├── data/                           # Data Access Layer
│   ├── models/
│   │   ├── post_model.dart         # Data model with JSON serialization
│   │   ├── post_model.freezed.dart (generated)
│   │   └── post_model.g.dart       (generated)
│   ├── datasources/
│   │   └── posts_remote_datasource.dart  # API calls
│   └── repositories/
│       └── posts_repository_impl.dart    # Repository implementation
│
└── presentation/                   # UI Layer
    ├── viewmodels/
    │   ├── posts_state.dart        # Immutable state
    │   ├── posts_state.freezed.dart (generated)
    │   ├── posts_viewmodel.dart    # Business logic & state management
    │   └── providers.dart          # Riverpod providers for DI
    ├── views/
    │   └── posts_view.dart         # Main screen
    └── widgets/
        └── post_card.dart          # Reusable post card widget
```

---

## Architecture Flow

```
┌─────────────────────────────────────────────────────┐
│                   User Interaction                   │
│              (Tap button on Home screen)             │
└───────────────────┬─────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────┐
│                  Navigation (GoRouter)               │
│              Routes to /posts (PostsView)            │
└───────────────────┬─────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────┐
│                   PostsView (UI)                     │
│  - Watches postsViewModelProvider                    │
│  - Calls viewModel.fetchPosts() on init             │
│  - Displays loading/error/success states            │
└───────────────────┬─────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────┐
│             PostsViewModel (StateNotifier)           │
│  - Updates state (isLoading, posts, error)          │
│  - Calls repository.getPosts()                      │
└───────────────────┬─────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────┐
│          PostsRepositoryImpl (Data Layer)           │
│  - Handles error conversion (Exceptions → Failures) │
│  - Converts Models → Entities                       │
│  - Returns Either<Failure, List<PostEntity>>        │
└───────────────────┬─────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────┐
│      PostsRemoteDataSource (API Client)             │
│  - Makes GET request to /posts                      │
│  - Deserializes JSON to PostModel                   │
│  - Throws exceptions on error                       │
└───────────────────┬─────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────┐
│              JSONPlaceholder API                     │
│     https://jsonplaceholder.typicode.com/posts      │
└─────────────────────────────────────────────────────┘
```

---

## Key Features

### 1. **State Management**
- Uses Riverpod's `StateNotifier` pattern
- Immutable state with Freezed
- Reactive UI updates when state changes

### 2. **Error Handling**
- Network errors caught and displayed to user
- Server errors handled gracefully
- Retry functionality on error

### 3. **Loading States**
- Initial load: Shows spinner with "Loading posts..."
- Refresh: Shows linear progress indicator at top
- Pull to refresh gesture supported

### 4. **UI States**
✅ **Loading**: Circular progress indicator
✅ **Error**: Error icon, message, and retry button
✅ **Empty**: "No posts found" message
✅ **Success**: Scrollable list of post cards

### 5. **Post Card Widget**
- Displays user ID in circle avatar
- Shows post title (bold, max 2 lines)
- Shows post body (gray text, max 3 lines)
- Shows post ID at bottom right

---

## How to Use

### 1. Run the App
```bash
flutter run
```

### 2. Navigate to Posts
- On the home screen, you'll see a button: **"View Posts (JSONPlaceholder API)"**
- Tap it to navigate to the Posts screen

### 3. View Posts
- Posts automatically load when the screen opens
- Pull down to refresh
- Tap the refresh icon in app bar to reload

---

## Code Highlights

### Domain Layer (Business Logic)

**PostEntity** - Pure business object:
```dart
@freezed
class PostEntity with _$PostEntity {
  const factory PostEntity({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostEntity;
}
```

### Data Layer (API Integration)

**PostsRemoteDataSource** - API calls:
```dart
Future<List<PostModel>> getPosts() async {
  final response = await apiClient.get<List<dynamic>>('/posts');
  return response.map((json) => PostModel.fromJson(json)).toList();
}
```

**PostsRepositoryImpl** - Error handling:
```dart
Future<Either<Failure, List<PostEntity>>> getPosts() async {
  try {
    final posts = await remoteDataSource.getPosts();
    return Right(posts.map((model) => model.toEntity()).toList());
  } on NetworkException catch (e) {
    return Left(Failure.network(message: e.message));
  }
}
```

### Presentation Layer (UI)

**PostsViewModel** - State management:
```dart
Future<void> fetchPosts() async {
  state = state.copyWith(isLoading: true);

  final result = await repository.getPosts();

  result.fold(
    (failure) => state = state.copyWith(isLoading: false, errorMessage: '...'),
    (posts) => state = state.copyWith(isLoading: false, posts: posts),
  );
}
```

**PostsView** - Reactive UI:
```dart
final state = ref.watch(postsViewModelProvider);

if (state.isLoading) return CircularProgressIndicator();
if (state.errorMessage != null) return ErrorWidget();
return ListView.builder(...);
```

---

## Testing the API

### Sample API Response
```json
[
  {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident...",
    "body": "quia et suscipit\nsuscipit recusandae..."
  },
  ...
]
```

### Expected Behavior
1. **On Load**: Fetches 100 posts from JSONPlaceholder
2. **Display**: Shows all posts in scrollable list
3. **Each Card**: Shows userId, title, body, and post ID
4. **Pull to Refresh**: Reloads data from API

---

## Architecture Benefits Demonstrated

### ✅ Separation of Concerns
- **Domain**: Business entities (no dependencies)
- **Data**: API integration, JSON parsing
- **Presentation**: UI and state management

### ✅ Testability
- Each layer can be tested independently
- Easy to mock repositories for testing ViewModels
- Easy to mock data sources for testing repositories

### ✅ Scalability
- Adding new features follows the same pattern
- New endpoints just need new datasources
- New screens just need new ViewModels and Views

### ✅ Maintainability
- Clear file structure
- Single responsibility for each class
- Easy to find and fix bugs

### ✅ Type Safety
- Freezed ensures immutability
- Either pattern prevents unhandled errors
- Riverpod provides compile-time safety

---

## Next Steps - How to Extend

### Add Post Details Screen
1. Create `post_detail_entity.dart`
2. Add `getPostById(id)` to repository
3. Create `PostDetailViewModel` and `PostDetailView`
4. Add route in `app_router.dart`
5. Navigate from `PostCard` on tap

### Add Create Post Feature
1. Create `CreatePostViewModel`
2. Add `createPost()` method to repository
3. Create form in `CreatePostView`
4. Update state after successful creation

### Add Local Caching
1. Create `posts_local_datasource.dart`
2. Use shared_preferences or sqflite
3. Implement cache-first strategy in repository
4. Return cached data if network fails

---

## Files Modified

### Core Files
- [app_constants.dart](lib/core/constants/app_constants.dart#L5) - Updated base URL
- [app_router.dart](lib/core/router/app_router.dart#L8) - Added `/posts` route
- [home_view.dart](lib/features/home/presentation/views/home_view.dart#L103) - Added navigation button

### New Files Created
- All files in `lib/features/posts/` (15 files total)
- Generated files: `.freezed.dart` and `.g.dart`

---

## Summary

You now have a **fully functional Posts page** that:
- ✅ Fetches real data from JSONPlaceholder API
- ✅ Follows MVVM + Riverpod architecture
- ✅ Demonstrates complete data flow (API → Repository → ViewModel → View)
- ✅ Handles loading, error, and success states
- ✅ Uses Freezed for immutable models
- ✅ Uses Either pattern for error handling
- ✅ Implements pull-to-refresh
- ✅ Shows proper UI/UX feedback

**This is a production-ready example** that you can use as a template for all future features!

---

**Happy Coding!** 🚀
