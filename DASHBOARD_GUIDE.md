# FitTracker Dashboard - Quick Start Guide

## 🚀 Getting Started

The dashboard is now fully integrated into the FitTracker app!

### Access the Dashboard

1. **Run the app**: The dashboard is the first screen (Home tab) in the bottom navigation
2. **Navigate**: Tap on the "Dashboard" icon in the bottom navigation bar

## 🎯 Features

### 1. Statistics Overview
Four key metrics displayed as cards:
- 🏋️ **Total Workouts**: Number of completed workouts
- 🔥 **Calories Burned**: Total calories burned
- 📍 **Distance**: Total distance covered (km)
- ⏱️ **Duration**: Total workout time (minutes)

### 2. Interactive Charts
- 📈 **Calories Line Chart**: Track calorie trends over time
- 📊 **Workouts Bar Chart**: Visualize workout frequency
- 🥧 **Activity Breakdown**: See distribution of activity types

### 3. View Toggle
- **Weekly**: Last 7 days of detailed data
- **Monthly**: Last 30 days grouped by week

### 4. Data Source Options
- ☁️ **Cloud Icon** (top right): Toggle between API and mock data
  - Cloud icon = Using API data
  - Cloud-off icon = Using mock data (default)
- 🔄 **Refresh Icon**: Reload data

## 📱 Usage

### Testing Without Backend
By default, the app uses **mock data**, so you can test immediately without setting up the backend:

1. Open the app
2. Navigate to Dashboard (first tab)
3. Explore the charts and statistics
4. Toggle between Weekly and Monthly views

### Connecting to Backend API

When your NestJS backend is ready:

1. **Update API URL** (if needed):
   - Open: `lib/features/dashboard/data/dashboard_api_service.dart`
   - Change the `baseUrl` parameter:
   ```dart
   DashboardApiService({this.baseUrl = 'http://YOUR_API_URL/api/dashboard'});
   ```

2. **Switch to API mode**:
   - Tap the cloud icon in the dashboard
   - It will change from cloud-off to cloud
   - Data will now load from your API

### Pull to Refresh
Swipe down on the dashboard to refresh all data.

## 🔧 Backend API Requirements

Your NestJS backend should implement these endpoints:

### 1. GET /api/dashboard/stats
Returns overall statistics:
```json
{
  "totalWorkouts": 24,
  "totalCalories": 12450,
  "totalDistance": 48.5,
  "totalDuration": 1820
}
```

### 2. GET /api/dashboard/weekly
Returns array of daily data for last 7 days:
```json
[
  {
    "date": "2026-01-23",
    "workouts": 2,
    "calories": 850,
    "distance": 5.2,
    "duration": 120
  },
  // ... more days
]
```

### 3. GET /api/dashboard/monthly
Returns array of weekly data for last 30 days:
```json
[
  {
    "week": "Week 1",
    "workouts": 12,
    "calories": 5240,
    "distance": 22.5,
    "duration": 680
  },
  // ... more weeks
]
```

### 4. GET /api/dashboard/activity-breakdown
Returns activity distribution:
```json
[
  {
    "activityType": "Running",
    "count": 8,
    "percentage": 35
  },
  // ... more activities
]
```

### 5. GET /api/dashboard/summary/weekly
Returns weekly averages:
```json
{
  "averageWorkoutsPerDay": 2.4,
  "averageCaloriesPerDay": 1035,
  "averageDistancePerDay": 7.2,
  "averageDurationPerDay": 148.5,
  "totalDays": 7
}
```

### 6. GET /api/dashboard/summary/monthly
Returns monthly averages (same structure as weekly).

## 🎨 Customization

### Change Colors
Each widget has customizable colors. For example, in stat cards:
- Green (0xFF4CAF50) - Workouts
- Orange-Red (0xFFFF5722) - Calories
- Blue (0xFF2196F3) - Distance
- Purple (0xFF9C27B0) - Duration

Edit these in: `lib/features/dashboard/presentation/screens/dashboard_screen.dart`

### Modify Mock Data
Edit: `lib/features/dashboard/mocks/mock_dashboard_data.dart`

### Change Default Mode
To use API by default instead of mock data:
- Open: `lib/features/dashboard/presentation/screens/dashboard_screen.dart`
- Find: `bool _useMockData = true;`
- Change to: `bool _useMockData = false;`

## 📂 File Structure

```
lib/features/dashboard/
├── README.md                       # Detailed documentation
├── dashboard_module.dart           # Exports
├── domain/entities/                # Data models
├── data/dashboard_api_service.dart # API service
├── mocks/mock_dashboard_data.dart  # Test data
└── presentation/
    ├── screens/dashboard_screen.dart
    └── widgets/                    # Reusable UI components
```

## 🐛 Troubleshooting

### "No data available"
- Make sure you're in the right view (Weekly/Monthly)
- Check if mock data is enabled
- If using API, verify backend is running

### Connection Error
- Ensure backend URL is correct
- Check if backend server is running on localhost:3001
- Try switching to mock data mode

### Charts not displaying
- Verify data is loaded (check loading spinner)
- Make sure data arrays are not empty
- Check console for errors

## 📊 Dependencies

Required packages (already added):
```yaml
dependencies:
  fl_chart: ^0.66.0    # Charts
  http: ^1.2.0         # API calls
  intl: ^0.19.0        # Date formatting
```

## 🎯 Next Steps

1. ✅ Dashboard is ready to use with mock data
2. 🔨 Build your NestJS backend with the required endpoints
3. 🔗 Update the API URL in the service
4. 🔄 Switch from mock to API mode
5. 🎉 Enjoy your fitness dashboard!

## 💡 Tips

- Use mock data during development and testing
- Pull down to refresh data
- Toggle views to see different time periods
- Monitor the cloud icon to know which data source is active
- Charts are interactive - tap data points for details

---

**Happy tracking! 🏃‍♂️💪**
