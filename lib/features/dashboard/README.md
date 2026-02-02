# Dashboard Feature - FitTracker

## Overview
The Dashboard feature provides comprehensive fitness statistics and visualizations for the FitTracker app.

## Features

### 1. **Statistics Cards**
- Total Workouts
- Total Calories Burned
- Total Distance (km)
- Total Duration (minutes)

### 2. **Charts & Visualizations**
- **Calories Line Chart**: Shows calorie trends over time
- **Workouts Bar Chart**: Displays workout frequency
- **Activity Breakdown Pie Chart**: Visual distribution of activity types

### 3. **View Toggle**
- **Weekly View**: Last 7 days of data
- **Monthly View**: Last 30 days grouped by week

### 4. **Data Source Toggle**
- **Mock Data Mode**: Uses local mock data for testing (default)
- **API Mode**: Connects to NestJS backend

## API Endpoints

The dashboard connects to the following NestJS API endpoints:

```
Base URL: http://localhost:3001/api/dashboard
```

### Endpoints:
1. `GET /api/dashboard/stats` - Overall statistics
2. `GET /api/dashboard/weekly` - Last 7 days data
3. `GET /api/dashboard/monthly` - Last 30 days by week
4. `GET /api/dashboard/activity-breakdown` - Activity types
5. `GET /api/dashboard/summary/weekly` - Weekly summary
6. `GET /api/dashboard/summary/monthly` - Monthly summary

## File Structure

```
lib/features/dashboard/
├── dashboard_module.dart           # Module exports
├── domain/
│   └── entities/
│       ├── dashboard_stats.dart
│       ├── weekly_data.dart
│       ├── monthly_data.dart
│       ├── activity_breakdown.dart
│       └── dashboard_summary.dart
├── data/
│   └── dashboard_api_service.dart  # API service
├── mocks/
│   └── mock_dashboard_data.dart    # Mock data
└── presentation/
    ├── screens/
    │   └── dashboard_screen.dart   # Main screen
    └── widgets/
        ├── stat_card.dart
        ├── calories_line_chart.dart
        ├── workouts_bar_chart.dart
        └── activity_doughnut_chart.dart
```

## Usage

### Navigate to Dashboard

```dart
// Using named route
Navigator.pushNamed(context, AppRouter.dashboard);

// Or direct navigation
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const DashboardScreen()),
);
```

### Toggle Data Source

1. Tap the cloud icon in the app bar to switch between mock and API data
2. Tap the refresh icon to reload data

### Switch Views

Use the Weekly/Monthly toggle buttons to switch between time periods.

## Configuration

### Change API Base URL

Edit `lib/features/dashboard/data/dashboard_api_service.dart`:

```dart
DashboardApiService({this.baseUrl = 'http://YOUR_API_URL/api/dashboard'});
```

### Customize Mock Data

Edit `lib/features/dashboard/mocks/mock_dashboard_data.dart` to modify sample data.

### Change Default Data Source

In `lib/features/dashboard/presentation/screens/dashboard_screen.dart`:

```dart
bool _useMockData = true; // Change to false to use API by default
```

## Dependencies

The dashboard uses the following packages:

- `fl_chart: ^0.66.0` - For charts and graphs
- `http: ^1.2.0` - For API calls
- `intl: ^0.19.0` - For date formatting

## Testing Without Backend

The dashboard includes comprehensive mock data that simulates a realistic fitness tracking scenario:

- 24 total workouts
- 12,450 total calories
- 48.5 km total distance
- 1,820 minutes total duration
- 5 different activity types

You can test all features without running the backend server by keeping the cloud icon in "offline" mode (cloud_off).

## Customization

### Change Colors

Edit the color constants in each widget file:

```dart
// Example: Stat cards
StatCard(
  color: const Color(0xFF4CAF50), // Change this
)
```

### Modify Chart Styles

Edit the chart widgets in `lib/features/dashboard/presentation/widgets/`.

### Add More Statistics

1. Add fields to `DashboardStats` model
2. Update API service
3. Add new `StatCard` in `dashboard_screen.dart`

## Error Handling

The dashboard includes:
- Loading states
- Error messages with retry button
- Pull-to-refresh functionality
- Graceful fallback to mock data

## Responsive Design

The dashboard is optimized for mobile devices with:
- Scrollable content
- Grid layout for stat cards
- Responsive chart sizing
- Pull-to-refresh gesture
