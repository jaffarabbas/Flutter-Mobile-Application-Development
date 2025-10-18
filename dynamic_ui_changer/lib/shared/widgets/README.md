# Shared Widgets

This folder contains reusable UI components that can be used across the entire application.

## CustomAppBar

A reusable AppBar widget with consistent styling and built-in back button functionality.

### Features
- ✅ Consistent amber color across the app
- ✅ Automatic back button with GoRouter integration
- ✅ Optional custom back button behavior
- ✅ Support for action buttons
- ✅ Centered title
- ✅ Customizable background color

### Usage

#### Basic Usage (with back button)
```dart
Scaffold(
  appBar: CustomAppBar(
    title: 'My Page Title',
  ),
  body: YourWidget(),
)
```

#### Without Back Button (Home Screen)
```dart
Scaffold(
  appBar: CustomAppBar(
    title: 'Home',
    showBackButton: false,
  ),
  body: YourWidget(),
)
```

#### With Actions
```dart
Scaffold(
  appBar: CustomAppBar(
    title: 'My Page',
    actions: [
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () => doSomething(),
      ),
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () => openSettings(),
      ),
    ],
  ),
  body: YourWidget(),
)
```

#### Custom Background Color
```dart
Scaffold(
  appBar: CustomAppBar(
    title: 'My Page',
    backgroundColor: Colors.blue,
  ),
  body: YourWidget(),
)
```

#### Custom Back Button Behavior
```dart
Scaffold(
  appBar: CustomAppBar(
    title: 'My Page',
    onBackPressed: () {
      // Custom logic before going back
      showDialog(...);
      // or
      context.go('/custom-route');
    },
  ),
  body: YourWidget(),
)
```

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `title` | `String` | required | The title text to display |
| `showBackButton` | `bool` | `true` | Whether to show the back button |
| `actions` | `List<Widget>?` | `null` | Action buttons to display on the right |
| `backgroundColor` | `Color?` | `Colors.amber` | AppBar background color |
| `onBackPressed` | `VoidCallback?` | `null` | Custom back button callback. If null, uses GoRouter's `context.pop()` |

### Examples in the Codebase

**Home View** (no back button):
```dart
// lib/features/home/presentation/views/home_view.dart
appBar: CustomAppBar(
  title: 'Dynamic Layout Changer',
  showBackButton: false,
  actions: [
    IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: () => viewModel.fetchUsers(),
    ),
  ],
),
```

**Posts View** (with back button):
```dart
// lib/features/posts/presentation/views/posts_view.dart
appBar: CustomAppBar(
  title: 'Posts from JSONPlaceholder',
  showBackButton: true,
  actions: [
    IconButton(
      icon: const Icon(Icons.refresh),
      onPressed: () => viewModel.fetchPosts(),
    ),
  ],
),
```

### Navigation Behavior

The back button automatically integrates with GoRouter:
- Uses `context.canPop()` to check if navigation is possible
- Uses `context.pop()` to navigate back
- Falls back to custom `onBackPressed` callback if provided

### Best Practices

1. **Consistency**: Use `CustomAppBar` for all screens to maintain consistent UI
2. **Home Screen**: Set `showBackButton: false` for root/home screens
3. **Detail Screens**: Keep `showBackButton: true` (default) for detail/child screens
4. **Actions**: Add relevant actions (refresh, search, etc.) via the `actions` parameter
5. **Custom Behavior**: Use `onBackPressed` only when you need special handling (e.g., unsaved changes confirmation)

---

**Created as part of MVVM + Riverpod Architecture**
