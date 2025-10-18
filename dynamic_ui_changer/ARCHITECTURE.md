# Scalable Flutter Architecture - MVVM + Riverpod

This project implements a **production-ready, scalable architecture** using **MVVM (Model-View-ViewModel)** pattern with **Riverpod** for state management.

## Table of Contents
- [Architecture Overview](#architecture-overview)
- [Project Structure](#project-structure)
- [Tech Stack](#tech-stack)
- [Layer Responsibilities](#layer-responsibilities)
- [How to Add a New Feature](#how-to-add-a-new-feature)
- [Code Generation](#code-generation)
- [Best Practices](#best-practices)

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                    Presentation                      │
│  ┌──────────┐      ┌──────────┐      ┌──────────┐  │
│  │  View    │ ───> │ ViewModel│ <─── │ Provider │  │
│  │ (Widget) │      │ (Notifier)│      │ (Riverpod)│ │
│  └──────────┘      └──────────┘      └──────────┘  │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│                     Domain                           │
│  ┌──────────────┐    ┌──────────────┐              │
│  │  Repository  │    │   Entities   │              │
│  │ (Interface)  │    │  (Business)  │              │
│  └──────────────┘    └──────────────┘              │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│                      Data                            │
│  ┌──────────────┐    ┌──────────────┐              │
│  │ Repository   │    │    Models    │              │
│  │    Impl      │    │ DataSources  │              │
│  └──────────────┘    └──────────────┘              │
└─────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────┐
│                      Core                            │
│  Network, DI, Utils, Errors, Constants, Router      │
└─────────────────────────────────────────────────────┘
```

---

## Project Structure

```
lib/
├── core/                           # Core functionality (shared across features)
│   ├── constants/                  # App-wide constants
│   │   └── app_constants.dart
│   ├── di/                         # Dependency Injection
│   │   └── service_locator.dart    # GetIt setup
│   ├── errors/                     # Error handling
│   │   ├── exceptions.dart         # Custom exceptions
│   │   └── failures.dart           # Failure types (freezed)
│   ├── network/                    # Network layer
│   │   └── api_client.dart         # Dio wrapper
│   ├── router/                     # App routing
│   │   └── app_router.dart         # GoRouter setup
│   └── utils/                      # Utilities
│       └── extensions.dart         # Dart/Flutter extensions
│
├── features/                       # Feature modules (Clean Architecture)
│   └── home/                       # Example feature
│       ├── data/                   # Data layer
│       │   ├── datasources/        # Remote/Local data sources
│       │   │   └── home_remote_datasource.dart
│       │   ├── models/             # Data models (JSON)
│       │   │   ├── user_model.dart
│       │   │   ├── user_model.freezed.dart (generated)
│       │   │   └── user_model.g.dart (generated)
│       │   └── repositories/       # Repository implementations
│       │       └── home_repository_impl.dart
│       │
│       ├── domain/                 # Business logic layer
│       │   ├── entities/           # Business entities
│       │   │   ├── user_entity.dart
│       │   │   ├── user_entity.freezed.dart (generated)
│       │   │   └── user_entity.g.dart (generated)
│       │   └── repositories/       # Repository contracts
│       │       └── home_repository.dart
│       │
│       └── presentation/           # UI layer
│           ├── viewmodels/         # State management
│           │   ├── home_state.dart
│           │   ├── home_state.freezed.dart (generated)
│           │   ├── home_viewmodel.dart
│           │   └── providers.dart   # Riverpod providers
│           ├── views/              # Screens/Pages
│           │   └── home_view.dart
│           └── widgets/            # Reusable widgets
│               └── user_card.dart
│
├── shared/                         # Shared widgets/components
│   └── widgets/
│
└── main.dart                       # App entry point
```

---

## Tech Stack

### State Management
- **Riverpod 2.6+**: Compile-safe, testable, and scalable state management
- **StateNotifier**: For complex state management in ViewModels

### Code Generation
- **Freezed**: Immutable models with `copyWith`, equality, and unions
- **JSON Serializable**: JSON serialization/deserialization
- **Riverpod Generator**: Auto-generated providers (optional)

### Navigation
- **GoRouter**: Declarative routing with type safety

### Network
- **Dio**: HTTP client with interceptors and error handling

### Dependency Injection
- **GetIt**: Service locator for core services
- **Riverpod Providers**: For feature-level DI

### Utilities
- **Dartz**: Functional programming (Either for error handling)
- **Logger**: Structured logging

---

## Layer Responsibilities

### 1. Presentation Layer
**Responsibility**: UI and user interaction

- **View (Widget)**: Displays UI, listens to ViewModel state
- **ViewModel**: Manages UI state, handles user actions
- **State**: Immutable state classes (Freezed)
- **Providers**: Riverpod providers for DI and state access

**Example Flow**:
```dart
// User taps button → View calls ViewModel method
ElevatedButton(
  onPressed: () => viewModel.fetchUsers(),
)

// ViewModel updates state → View rebuilds
final state = ref.watch(homeViewModelProvider);
```

### 2. Domain Layer
**Responsibility**: Business logic and entities

- **Entities**: Pure business objects (no JSON, no UI)
- **Repository Interfaces**: Contracts for data access
- **Use Cases** (optional): Single-purpose business operations

**Why separate from Data?**
- Business logic doesn't depend on implementation details
- Easy to swap data sources without changing business logic

### 3. Data Layer
**Responsibility**: Data fetching and caching

- **Models**: JSON-serializable data structures
- **DataSources**: API calls, database queries, cache
- **Repository Implementations**: Implements domain contracts

**Model vs Entity**:
- **Model**: Has `fromJson`, `toJson`, knows about API structure
- **Entity**: Pure business object, UI-focused

### 4. Core Layer
**Responsibility**: Shared infrastructure

- Constants, utilities, error handling
- Network client, DI setup
- Routing configuration

---

## How to Add a New Feature

### Step 1: Create Folder Structure
```bash
lib/features/profile/
  ├── data/
  │   ├── datasources/
  │   ├── models/
  │   └── repositories/
  ├── domain/
  │   ├── entities/
  │   └── repositories/
  └── presentation/
      ├── viewmodels/
      ├── views/
      └── widgets/
```

### Step 2: Create Entity
```dart
// domain/entities/profile_entity.dart
@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String id,
    required String name,
  }) = _ProfileEntity;
}
```

### Step 3: Create Model
```dart
// data/models/profile_model.dart
@freezed
class ProfileModel with _$ProfileModel {
  const ProfileModel._();

  const factory ProfileModel({
    required String id,
    required String name,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileEntity toEntity() => ProfileEntity(id: id, name: name);
}
```

### Step 4: Create Repository
```dart
// domain/repositories/profile_repository.dart
abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
}

// data/repositories/profile_repository_impl.dart
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource dataSource;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      final model = await dataSource.getProfile();
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    }
  }
}
```

### Step 5: Create ViewModel & State
```dart
// presentation/viewmodels/profile_state.dart
@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    ProfileEntity? profile,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ProfileState;
}

// presentation/viewmodels/profile_viewmodel.dart
class ProfileViewModel extends StateNotifier<ProfileState> {
  final ProfileRepository repository;

  ProfileViewModel({required this.repository}) : super(const ProfileState());

  Future<void> loadProfile() async {
    state = state.copyWith(isLoading: true);
    final result = await repository.getProfile();

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error loading profile',
      ),
      (profile) => state = state.copyWith(
        isLoading: false,
        profile: profile,
      ),
    );
  }
}
```

### Step 6: Create Providers
```dart
// presentation/viewmodels/providers.dart
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(dataSource: ref.watch(profileDataSourceProvider));
});

final profileViewModelProvider = StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
  return ProfileViewModel(repository: ref.watch(profileRepositoryProvider));
});
```

### Step 7: Create View
```dart
// presentation/views/profile_view.dart
class ProfileView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileViewModelProvider);
    final viewModel = ref.read(profileViewModelProvider.notifier);

    return Scaffold(
      body: state.isLoading
          ? CircularProgressIndicator()
          : Text(state.profile?.name ?? 'No profile'),
    );
  }
}
```

### Step 8: Run Code Generation
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## Code Generation

### When to Run
- After creating/modifying Freezed models
- After adding JSON serialization
- After creating Riverpod generators

### Commands
```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on file changes)
dart run build_runner watch --delete-conflicting-outputs

# Clean and rebuild
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

---

## Best Practices

### 1. State Management
✅ **DO**: Use `StateNotifier` for complex state
✅ **DO**: Keep state immutable (Freezed)
✅ **DO**: Use providers for dependency injection
❌ **DON'T**: Mutate state directly
❌ **DON'T**: Put business logic in views

### 2. Error Handling
✅ **DO**: Use `Either<Failure, Success>` pattern
✅ **DO**: Catch specific exceptions
✅ **DO**: Map exceptions to failures in repositories
❌ **DON'T**: Let exceptions propagate to UI

### 3. Models vs Entities
✅ **DO**: Use models in data layer (JSON)
✅ **DO**: Use entities in domain/presentation
✅ **DO**: Convert models to entities in repositories
❌ **DON'T**: Use models directly in UI

### 4. Dependency Injection
✅ **DO**: Use GetIt for core services (Dio, Logger)
✅ **DO**: Use Riverpod providers for feature dependencies
✅ **DO**: Inject dependencies via constructors
❌ **DON'T**: Create dependencies inside classes

### 5. Code Organization
✅ **DO**: One feature per folder
✅ **DO**: Keep views simple (delegate to ViewModel)
✅ **DO**: Reuse widgets in `shared/widgets`
❌ **DON'T**: Mix features in same files

---

## Testing Strategy

### Unit Tests
- ViewModels (business logic)
- Repositories (data transformation)
- Utils and extensions

### Widget Tests
- Individual widgets
- Views (with mocked providers)

### Integration Tests
- Full user flows
- API integration

**Example ViewModel Test**:
```dart
test('fetchUsers should update state with users', () async {
  final mockRepo = MockHomeRepository();
  when(mockRepo.getUsers()).thenAnswer((_) async => Right([user]));

  final viewModel = HomeViewModel(repository: mockRepo);
  await viewModel.fetchUsers();

  expect(viewModel.state.users, [user]);
  expect(viewModel.state.isLoading, false);
});
```

---

## Key Benefits of This Architecture

1. **Scalability**: Easy to add features without affecting others
2. **Testability**: Every layer is independently testable
3. **Maintainability**: Clear separation of concerns
4. **Type Safety**: Freezed + Riverpod = compile-time safety
5. **Reusability**: Shared core and widgets
6. **Error Handling**: Consistent error propagation
7. **State Management**: Predictable state updates
8. **Code Generation**: Less boilerplate, more productivity

---

## Additional Resources

- [Riverpod Documentation](https://riverpod.dev)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

**Happy Coding!** 🚀
