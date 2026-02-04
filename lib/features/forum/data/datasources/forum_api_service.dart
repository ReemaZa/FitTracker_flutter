import 'package:fit_tracker/features/forum/data/models/forum_post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/forum_post.dart';
import '../../domain/entities/comment.dart';
import '../models/comment_model.dart';

/// Forum API Service - handles all API calls with error handling
class ForumApiService {
  // SWAP THIS URL TO CONNECT TO YOUR ACTUAL API
  static const String baseUrl = 'http://172.18.184.236:3001';
  final currentuserId = 1;
  final http.Client client;

  /// Submit a reaction (LIKE or SHARE) for a post
  Future<void> submitReaction({
    required int postId,
    required int userId,
    required String type, // "LIKE" or "SHARE"
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('$baseUrl/reactions'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'postId': postId,
              'userId': userId,
              'type': type.toUpperCase(), // ensure uppercase
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        // Reaction created successfully
        print('Reaction $type submitted for post $postId by user $userId');
      } else if (response.statusCode == 400) {
        throw ForumApiException('Invalid reaction data - check inputs');
      } else if (response.statusCode == 401) {
        throw ForumApiException('Unauthorized - Please log in again');
      } else {
        throw ForumApiException(
            'Failed to submit reaction (${response.statusCode})');
      }
    } on http.ClientException {
      throw ForumApiException(
          'Network error - Please check your internet connection');
    } catch (e) {
      throw ForumApiException('Failed to submit reaction: ${e.toString()}');
    }
  }

  /// Shortcut to submit a LIKE reaction
  Future<void> likePost(int postId, int userId) async {
    return submitReaction(postId: postId, userId: userId, type: 'LIKE');
  }

  /// Shortcut to submit a SHARE reaction
  Future<void> sharePost(int postId, int userId) async {
    return submitReaction(postId: postId, userId: userId, type: 'SHARE');
  }

  ForumApiService({http.Client? client}) : client = client ?? http.Client();

  /// Fetch all forum posts
  Future<List<ForumPostModel>> fetchPosts() async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/posts/$currentuserId'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // LOG THE RESPONSE DATA
        print('=== FORUM API RESPONSE (fetchPosts) ===');
        print('Full response: ${jsonEncode(data)}');
        if (data.isNotEmpty) {
          print('First post sample: ${jsonEncode(data.first)}');
          print('First post keys: ${(data.first as Map).keys.toList()}');
        }
        print('=====================================');

        return data
            .map(
                (post) => ForumPostModel.fromJson(post as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 401) {
        throw ForumApiException('Unauthorized - Please log in again');
      } else if (response.statusCode == 404) {
        throw ForumApiException('Posts not found');
      } else {
        throw ForumApiException(
            'Failed to load posts (${response.statusCode}): ${response.reasonPhrase}');
      }
    } catch (e) {
      throw ForumApiException('Unexpected error: ${e.toString()}');
    }
  }

  /// Fetch a single forum post by ID
  Future<ForumPostModel> fetchPostById(int postId) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/posts/$postId/$currentuserId'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // LOG FOR DEBUGGING
        print('=== FORUM API RESPONSE (fetchPostById) ===');
        print(jsonEncode(data));
        print('========================================');

        return ForumPostModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw ForumApiException('Post not found');
      } else if (response.statusCode == 401) {
        throw ForumApiException('Unauthorized - Please log in again');
      } else {
        throw ForumApiException(
            'Failed to load post (${response.statusCode}): ${response.reasonPhrase}');
      }
    } on http.ClientException {
      throw ForumApiException(
          'Network error - Please check your internet connection');
    } catch (e) {
      throw ForumApiException('Failed to load post: ${e.toString()}');
    }
  }

  /// Fetch comments for a specific post
  Future<List<CommentModel>> fetchComments(int postId) async {
    try {
      final response = await client
          .get(Uri.parse('$baseUrl/comments/post/$postId'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((comment) =>
                CommentModel.fromJson(comment as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        throw ForumApiException('Post or comments not found');
      } else {
        throw ForumApiException(
            'Failed to load comments (${response.statusCode})');
      }
    } on http.ClientException {
      throw ForumApiException(
          'Network error - Please check your internet connection');
    } catch (e) {
      throw ForumApiException('Failed to load comments: ${e.toString()}');
    }
  }

  /// Create a new forum post
  Future<ForumPost> createPost({
    required String title,
    required String content,
    required String category,
    required List<String> tags,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('$baseUrl/posts'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'title': title,
              'content': content,
              'category': category,
              'tags': tags,
              'userId': this.currentuserId
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return ForumPostModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw ForumApiException('Invalid post data - Please check your inputs');
      } else if (response.statusCode == 401) {
        throw ForumApiException('Unauthorized - Please log in again');
      } else {
        throw ForumApiException(
            'Failed to create post (${response.statusCode})');
      }
    } on http.ClientException {
      throw ForumApiException(
          'Network error - Please check your internet connection');
    } catch (e) {
      throw ForumApiException('Failed to create post: ${e.toString()}');
    }
  }

  /// Like/Unlike a post
  Future<void> toggleLikePost(int postId) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/posts/$postId/like'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ForumApiException('Failed to like post (${response.statusCode})');
      }
    } on http.ClientException {
      throw ForumApiException(
          'Network error - Please check your internet connection');
    } catch (e) {
      throw ForumApiException('Failed to like post: ${e.toString()}');
    }
  }

  /// Submit a comment on a post
  Future<Comment> submitComment({
    required int postId,
    required String content,
    required int userId,
    int? parentCommentId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse('$baseUrl/comments'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'content': content,
              if (parentCommentId != null) 'parentCommentId': parentCommentId,
              'postId': postId,
              'userId': userId
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        print(jsonDecode(response.body));
        return CommentModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw ForumApiException('Invalid comment - Please check your input');
      } else if (response.statusCode == 401) {
        throw ForumApiException('Unauthorized - Please log in again');
      } else {
        throw ForumApiException(
            'Failed to submit comment (${response.statusCode})');
      }
    } on http.ClientException {
      throw ForumApiException(
          'Network error - Please check your internet connection');
    } catch (e) {
      throw ForumApiException('Failed to submit comment: ${e.toString()}');
    }
  }

  /// Like a comment
  Future<void> toggleLikeComment(String commentId) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/comments/$commentId/like'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ForumApiException(
            'Failed to like comment (${response.statusCode})');
      }
    } on http.ClientException {
      throw ForumApiException(
          'Network error - Please check your internet connection');
    } catch (e) {
      throw ForumApiException('Failed to like comment: ${e.toString()}');
    }
  }
}

/// Custom exception for forum API errors
class ForumApiException implements Exception {
  final String message;
  ForumApiException(this.message);

  @override
  String toString() => message;
}
