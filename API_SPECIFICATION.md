# Dashboard API Specification

## Base URL
```
http://localhost:3001/api/dashboard
```

## Endpoints

### 1. Get Overall Statistics

**Endpoint:** `GET /api/dashboard/stats`

**Description:** Returns overall fitness statistics

**Response:**
```json
{
  "totalWorkouts": 24,
  "totalCalories": 12450,
  "totalDistance": 48.5,
  "totalDuration": 1820
}
```

**Response Fields:**
- `totalWorkouts` (integer): Total number of workouts completed
- `totalCalories` (number): Total calories burned
- `totalDistance` (number): Total distance in kilometers
- `totalDuration` (number): Total duration in minutes

---

### 2. Get Weekly Data

**Endpoint:** `GET /api/dashboard/weekly`

**Description:** Returns daily workout data for the last 7 days

**Response:**
```json
[
  {
    "date": "2026-01-23",
    "workouts": 2,
    "calories": 850,
    "distance": 5.2,
    "duration": 120
  },
  {
    "date": "2026-01-24",
    "workouts": 3,
    "calories": 1200,
    "distance": 8.5,
    "duration": 180
  }
  // ... 5 more days
]
```

**Response Fields:**
- `date` (string): Date in YYYY-MM-DD format
- `workouts` (integer): Number of workouts on that day
- `calories` (number): Calories burned on that day
- `distance` (number): Distance covered in kilometers
- `duration` (number): Total duration in minutes

**Note:** Should return exactly 7 days of data

---

### 3. Get Monthly Data

**Endpoint:** `GET /api/dashboard/monthly`

**Description:** Returns weekly aggregated data for the last 30 days

**Response:**
```json
[
  {
    "week": "Week 1",
    "workouts": 12,
    "calories": 5240,
    "distance": 22.5,
    "duration": 680
  },
  {
    "week": "Week 2",
    "workouts": 15,
    "calories": 6820,
    "distance": 28.3,
    "duration": 825
  }
  // ... 2 more weeks
]
```

**Response Fields:**
- `week` (string): Week label (e.g., "Week 1", "Week 2")
- `workouts` (integer): Total workouts in that week
- `calories` (number): Total calories burned in that week
- `distance` (number): Total distance in kilometers
- `duration` (number): Total duration in minutes

**Note:** Should return 4 weeks of data

---

### 4. Get Activity Breakdown

**Endpoint:** `GET /api/dashboard/activity-breakdown`

**Description:** Returns distribution of different activity types

**Response:**
```json
[
  {
    "activityType": "Running",
    "count": 8,
    "percentage": 35
  },
  {
    "activityType": "Cycling",
    "count": 6,
    "percentage": 25
  },
  {
    "activityType": "Swimming",
    "count": 4,
    "percentage": 18
  }
  // ... more activity types
]
```

**Response Fields:**
- `activityType` (string): Name of the activity
- `count` (integer): Number of times this activity was performed
- `percentage` (number): Percentage of total activities

**Note:** Percentages should add up to 100

---

### 5. Get Weekly Summary

**Endpoint:** `GET /api/dashboard/summary/weekly`

**Description:** Returns average daily statistics for the past week

**Response:**
```json
{
  "averageWorkoutsPerDay": 2.4,
  "averageCaloriesPerDay": 1035,
  "averageDistancePerDay": 7.2,
  "averageDurationPerDay": 148.5,
  "totalDays": 7
}
```

**Response Fields:**
- `averageWorkoutsPerDay` (number): Average workouts per day
- `averageCaloriesPerDay` (number): Average calories per day
- `averageDistancePerDay` (number): Average distance per day (km)
- `averageDurationPerDay` (number): Average duration per day (minutes)
- `totalDays` (integer): Number of days included in calculation

---

### 6. Get Monthly Summary

**Endpoint:** `GET /api/dashboard/summary/monthly`

**Description:** Returns average daily statistics for the past month

**Response:**
```json
{
  "averageWorkoutsPerDay": 1.8,
  "averageCaloriesPerDay": 812,
  "averageDistancePerDay": 6.1,
  "averageDurationPerDay": 125,
  "totalDays": 30
}
```

**Response Fields:** Same as weekly summary

**Note:** `totalDays` should be 30 for monthly summary

---

## Error Responses

All endpoints should return appropriate HTTP status codes and error messages:

### 500 Internal Server Error
```json
{
  "statusCode": 500,
  "message": "Internal server error",
  "error": "Error details"
}
```

### 404 Not Found
```json
{
  "statusCode": 404,
  "message": "Resource not found"
}
```

---

## NestJS Implementation Example

```typescript
// dashboard.controller.ts
import { Controller, Get } from '@nestjs/common';
import { DashboardService } from './dashboard.service';

@Controller('api/dashboard')
export class DashboardController {
  constructor(private readonly dashboardService: DashboardService) {}

  @Get('stats')
  getStats() {
    return this.dashboardService.getStats();
  }

  @Get('weekly')
  getWeeklyData() {
    return this.dashboardService.getWeeklyData();
  }

  @Get('monthly')
  getMonthlyData() {
    return this.dashboardService.getMonthlyData();
  }

  @Get('activity-breakdown')
  getActivityBreakdown() {
    return this.dashboardService.getActivityBreakdown();
  }

  @Get('summary/weekly')
  getWeeklySummary() {
    return this.dashboardService.getWeeklySummary();
  }

  @Get('summary/monthly')
  getMonthlySummary() {
    return this.dashboardService.getMonthlySummary();
  }
}
```

---

## CORS Configuration

Make sure to enable CORS in your NestJS app:

```typescript
// main.ts
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  app.enableCors({
    origin: '*', // In production, specify your app's origin
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    credentials: true,
  });
  
  await app.listen(3001);
}
bootstrap();
```

---

## Testing the API

Use curl or Postman to test:

```bash
# Test stats endpoint
curl http://localhost:3001/api/dashboard/stats

# Test weekly data
curl http://localhost:3001/api/dashboard/weekly

# Test monthly data
curl http://localhost:3001/api/dashboard/monthly

# Test activity breakdown
curl http://localhost:3001/api/dashboard/activity-breakdown

# Test weekly summary
curl http://localhost:3001/api/dashboard/summary/weekly

# Test monthly summary
curl http://localhost:3001/api/dashboard/summary/monthly
```

---

## Notes for Backend Developers

1. **Date Format:** Use ISO 8601 format (YYYY-MM-DD) for dates
2. **Number Precision:** Round numbers to 1-2 decimal places where appropriate
3. **Data Consistency:** Ensure stats match the sum of weekly/monthly data
4. **Performance:** Consider caching frequently accessed statistics
5. **Authentication:** Add JWT authentication if needed
6. **Validation:** Validate date ranges and request parameters
7. **Database:** Store workout data with timestamps for flexible querying

---

## Database Schema Example

```sql
CREATE TABLE workouts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  activity_type VARCHAR(50) NOT NULL,
  date DATE NOT NULL,
  calories DECIMAL(10, 2),
  distance DECIMAL(10, 2),
  duration INTEGER,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster queries
CREATE INDEX idx_workouts_user_date ON workouts(user_id, date);
CREATE INDEX idx_workouts_activity ON workouts(activity_type);
```
