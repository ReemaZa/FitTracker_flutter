## Forum API Integration Setup

All API calls are now wired throughout the forum feature with complete error handling.

### How to Switch from Mock Data to Real API

1. **Update the API URL** in `forum_api_service.dart`:
   ```dart
   static const String baseUrl = 'https://your-api-domain.com/v1/forum';
   ```

2. **Enable API mode** in your controllers:
   - In `ForumController`: Set `useApiServer = true;`
   - In `PostDetailController`: Set `useApiServer = true;`

### API Endpoints Required

The service expects the following endpoints:

- `GET /posts` - Fetch all forum posts
- `POST /posts` - Create a new forum post
- `POST /posts/{postId}/like` - Like/Unlike a post
- `GET /posts/{postId}/comments` - Fetch comments for a post
- `POST /posts/{postId}/comments` - Submit a new comment
- `POST /comments/{commentId}/like` - Like/Unlike a comment

### Error Handling

All API calls automatically:
- Catch network errors and show user-friendly messages
- Display server errors (401, 404, 400, etc.)
- Fall back to mock data when using mock mode
- Store error messages in `errorMessage` ValueNotifier for UI display

### JSON Response Format

Your API should return:
- Posts: `ForumPost` entity JSON
- Comments: `Comment` entity JSON

Both entities have `fromJson` factory constructors defined.

### Current Status

- ✅ ForumController API integration
- ✅ PostDetailController API integration
- ✅ Error handling throughout
- ✅ Network timeout handling (10 second timeout)
- ✅ Mock data fallback

Just update the URL and set `useApiServer = true` when ready!
