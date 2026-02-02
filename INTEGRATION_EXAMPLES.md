# Code Integration Examples

## Import Dashboard Components

```dart
// Import the entire module
import 'package:fit_tracker/features/dashboard/dashboard_module.dart';

// Or import specific components
import 'package:fit_tracker/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:fit_tracker/features/dashboard/presentation/widgets/stat_card.dart';
import 'package:fit_tracker/features/dashboard/data/dashboard_api_service.dart';
```

## Navigation Examples

### 1. Navigate from Any Screen

```dart
// Using named route
Navigator.pushNamed(context, AppRouter.dashboard);

// Using MaterialPageRoute
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DashboardScreen()),
);

// Replace current screen
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => const DashboardScreen()),
);
```

### 2. Add to Bottom Navigation

```dart
// Already integrated in app.dart
class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  final _pages = const [
    DashboardScreen(), // First tab
    GoalsPage(),
    TodayPage(),
    // ... other pages
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          // ... other items
        ],
      ),
    );
  }
}
```

### 3. Add Button to Navigate

```dart
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, AppRouter.dashboard);
  },
  child: const Text('View Dashboard'),
)
```

## Using Individual Widgets

### Stat Card Widget

```dart
import 'package:fit_tracker/features/dashboard/presentation/widgets/stat_card.dart';

// In your widget build method
StatCard(
  title: 'Total Steps',
  value: '10,000',
  icon: Icons.directions_walk,
  color: Colors.blue,
  unit: 'steps',
)
```

### Line Chart Widget

```dart
import 'package:fit_tracker/features/dashboard/presentation/widgets/calories_line_chart.dart';

// In your widget build method
CaloriesLineChart(
  data: [450, 680, 920, 550, 1200, 850, 1100], // List of values
  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'], // X-axis labels
  lineColor: const Color(0xFF6C63FF), // Optional custom color
)
```

### Bar Chart Widget

```dart
import 'package:fit_tracker/features/dashboard/presentation/widgets/workouts_bar_chart.dart';

// In your widget build method
WorkoutsBarChart(
  data: [2, 3, 1, 4, 2, 3, 2], // List of workout counts
  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
  barColor: const Color(0xFF4CAF50), // Optional custom color
)
```

### Activity Chart Widget

```dart
import 'package:fit_tracker/features/dashboard/presentation/widgets/activity_doughnut_chart.dart';
import 'package:fit_tracker/features/dashboard/domain/entities/activity_breakdown.dart';

// Create activity data
final activities = [
  ActivityBreakdown(activityType: 'Running', count: 8, percentage: 35),
  ActivityBreakdown(activityType: 'Cycling', count: 6, percentage: 25),
  ActivityBreakdown(activityType: 'Yoga', count: 4, percentage: 18),
];

// In your widget build method
ActivityDoughnutChart(
  activities: activities,
)
```

## Using the API Service

### Basic Usage

```dart
import 'package:fit_tracker/features/dashboard/data/dashboard_api_service.dart';

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final DashboardApiService _apiService = DashboardApiService();
  DashboardStats? _stats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final stats = await _apiService.getStats();
      setState(() {
        _stats = stats;
      });
    } catch (e) {
      print('Error loading stats: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_stats == null) {
      return CircularProgressIndicator();
    }
    
    return Text('Total Workouts: ${_stats!.totalWorkouts}');
  }
}
```

### Custom API URL

```dart
// Create service with custom URL
final apiService = DashboardApiService(
  baseUrl: 'https://api.myapp.com/dashboard',
);

// Use it
final stats = await apiService.getStats();
```

### Load All Data

```dart
Future<void> loadAllDashboardData() async {
  try {
    final stats = await _apiService.getStats();
    final weeklyData = await _apiService.getWeeklyData();
    final monthlyData = await _apiService.getMonthlyData();
    final activities = await _apiService.getActivityBreakdown();
    final weeklySummary = await _apiService.getWeeklySummary();
    final monthlySummary = await _apiService.getMonthlySummary();
    
    setState(() {
      _stats = stats;
      _weeklyData = weeklyData;
      // ... etc
    });
  } catch (e) {
    print('Error: $e');
  }
}
```

## Using Mock Data

### Direct Usage

```dart
import 'package:fit_tracker/features/dashboard/mocks/mock_dashboard_data.dart';

class MyWidget extends StatelessWidget {
  final MockDashboardData mockData = MockDashboardData();

  @override
  Widget build(BuildContext context) {
    final stats = mockData.getStats();
    final weeklyData = mockData.getWeeklyData();
    
    return Column(
      children: [
        Text('Total Workouts: ${stats.totalWorkouts}'),
        Text('Days of data: ${weeklyData.length}'),
      ],
    );
  }
}
```

### For Testing

```dart
// In test files
import 'package:fit_tracker/features/dashboard/mocks/mock_dashboard_data.dart';

void main() {
  test('Dashboard displays correct stats', () {
    final mockData = MockDashboardData();
    final stats = mockData.getStats();
    
    expect(stats.totalWorkouts, 24);
    expect(stats.totalCalories, 12450);
  });
}
```

## Custom Dashboard Screen

### Create a Simplified Version

```dart
import 'package:flutter/material.dart';
import 'package:fit_tracker/features/dashboard/dashboard_module.dart';

class SimpleDashboard extends StatefulWidget {
  const SimpleDashboard({super.key});

  @override
  State<SimpleDashboard> createState() => _SimpleDashboardState();
}

class _SimpleDashboardState extends State<SimpleDashboard> {
  final MockDashboardData _mockData = MockDashboardData();

  @override
  Widget build(BuildContext context) {
    final stats = _mockData.getStats();
    
    return Scaffold(
      appBar: AppBar(title: const Text('My Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            StatCard(
              title: 'Workouts',
              value: stats.totalWorkouts.toString(),
              icon: Icons.fitness_center,
              color: Colors.green,
            ),
            StatCard(
              title: 'Calories',
              value: stats.totalCalories.toStringAsFixed(0),
              icon: Icons.local_fire_department,
              color: Colors.orange,
              unit: 'cal',
            ),
          ],
        ),
      ),
    );
  }
}
```

## Riverpod Integration (Optional)

### Create Providers

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_tracker/features/dashboard/dashboard_module.dart';

// API Service Provider
final dashboardApiProvider = Provider((ref) {
  return DashboardApiService();
});

// Stats Provider
final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final apiService = ref.watch(dashboardApiProvider);
  return apiService.getStats();
});

// Weekly Data Provider
final weeklyDataProvider = FutureProvider<List<WeeklyData>>((ref) async {
  final apiService = ref.watch(dashboardApiProvider);
  return apiService.getWeeklyData();
});
```

### Use in Widget

```dart
class DashboardWithRiverpod extends ConsumerWidget {
  const DashboardWithRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    
    return statsAsync.when(
      data: (stats) => Text('Workouts: ${stats.totalWorkouts}'),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

## Add to Drawer Menu

```dart
Drawer(
  child: ListView(
    children: [
      DrawerHeader(
        child: Text('FitTracker'),
      ),
      ListTile(
        leading: Icon(Icons.dashboard),
        title: Text('Dashboard'),
        onTap: () {
          Navigator.pop(context); // Close drawer
          Navigator.pushNamed(context, AppRouter.dashboard);
        },
      ),
      // ... other menu items
    ],
  ),
)
```

## Add to TabBar

```dart
DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
          Tab(icon: Icon(Icons.flag), text: 'Goals'),
          Tab(icon: Icon(Icons.calendar_today), text: 'Today'),
        ],
      ),
    ),
    body: TabBarView(
      children: [
        DashboardScreen(),
        GoalsPage(),
        TodayPage(),
      ],
    ),
  ),
)
```

## Conditional Navigation

```dart
// Navigate based on user preference
void navigateToHome(BuildContext context, bool showDashboard) {
  if (showDashboard) {
    Navigator.pushNamed(context, AppRouter.dashboard);
  } else {
    Navigator.pushNamed(context, AppRouter.today);
  }
}

// Or use ternary
MaterialPageRoute(
  builder: (_) => userPrefersDashboard 
    ? const DashboardScreen() 
    : const TodayPage(),
)
```

## Error Handling Example

```dart
Future<void> loadDataWithErrorHandling() async {
  try {
    final stats = await _apiService.getStats();
    setState(() {
      _stats = stats;
      _error = null;
    });
  } on SocketException {
    setState(() {
      _error = 'No internet connection';
    });
  } on HttpException {
    setState(() {
      _error = 'Server error';
    });
  } catch (e) {
    setState(() {
      _error = 'An error occurred: $e';
    });
  }
}
```

## Loading State Management

```dart
enum LoadingState { idle, loading, success, error }

class DashboardManager {
  LoadingState _state = LoadingState.idle;
  
  Future<void> loadData() async {
    _state = LoadingState.loading;
    notifyListeners();
    
    try {
      final stats = await apiService.getStats();
      _state = LoadingState.success;
      notifyListeners();
    } catch (e) {
      _state = LoadingState.error;
      notifyListeners();
    }
  }
}
```

---

## Quick Reference

### Navigate to Dashboard
```dart
Navigator.pushNamed(context, AppRouter.dashboard);
```

### Use a Stat Card
```dart
StatCard(title: 'Steps', value: '10000', icon: Icons.walk, color: Colors.blue)
```

### Load API Data
```dart
final stats = await DashboardApiService().getStats();
```

### Use Mock Data
```dart
final stats = MockDashboardData().getStats();
```

---

**Happy coding! 🎉**
