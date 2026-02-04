import 'package:flutter/foundation.dart';
import '../../domain/entities/forum_post.dart';
import '../../domain/entities/forum_user.dart';
import '../../domain/entities/post_stats.dart';
import '../../data/datasources/mock_forum.dart';
import '../../data/datasources/forum_api_service.dart';

class ForumController extends ChangeNotifier {
  List<ForumPost> _posts = [];
  bool _isLoading = true;
  String _selectedCategory = 'all';
  bool _showCreateModal = false;
  String? _errorMessage;

  final ForumApiService _apiService = ForumApiService();
  bool useApiServer = true; // Set to true to use API, false for mock data

  // GETTERS
  List<ForumPost> get posts => _posts;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  bool get showCreateModal => _showCreateModal;
  String? get errorMessage => _errorMessage;

  List<ForumPost>? get mockForumPosts =>
      MockForum.getAllPosts() as List<ForumPost>?;

  // SETTERS
  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void togglePin(int postId) {
    _posts = _posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(isPinned: !post.isPinned);
      }
      return post;
    }).toList();

    notifyListeners();
  }

  void setShowCreateModal(bool value) {
    _showCreateModal = value;
    notifyListeners();
  }

  // ACTIONS
  Future<void> loadPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (useApiServer) {
        // Call real API
        _posts = await _apiService.fetchPosts();
      } else {
        // Use mock data
        await Future.delayed(const Duration(milliseconds: 500));
        _posts = mockForumPosts ?? [];
      }
      _errorMessage = null;
    } on ForumApiException catch (e) {
      _errorMessage = e.message;
      _posts = mockForumPosts ?? []; // Fallback to mock on error
      debugPrint('Forum API Error: ${e.message}');
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _posts = mockForumPosts ?? [];
      debugPrint('Forum Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleShare(int postId) {
    _posts = _posts.map((post) {
      if (post.id == postId) {
        final bool newIsShared = !post.isShared;

        return post.copyWith(
          isShared: newIsShared,
        );
      }
      return post;
    }).toList();

    notifyListeners();
  }

  void toggleLike(int postId) {
    _posts = _posts.map((post) {
      if (post.id == postId) {
        final bool newIsLiked = !post.isLiked;

        return post.copyWith(
          isLiked: newIsLiked,
          likes: newIsLiked
              ? post.likes + 1
              : (post.likes > 0 ? post.likes - 1 : 0),
        );
      }
      return post;
    }).toList();

    notifyListeners();

    // Optional API call later
    if (useApiServer) {
      _apiService.toggleLikePost(postId).catchError((e) {
        _errorMessage = e.toString();
        debugPrint('Like post error: $e');
      });
    }
  }

  Future<void> createPost(
      String title, String content, String category, List<String> tags) async {
    try {
      if (useApiServer) {
        // Call real API
        final newPost = await _apiService.createPost(
          title: title,
          content: content,
          category: category,
          tags: tags,
        );
        _posts.insert(0, newPost);
      } else {
        // Local creation with mock data
        final newPost = ForumPost(
          id: DateTime.now().millisecondsSinceEpoch.toInt(),
          title: title,
          content: content,

          author: MockForum.currentUser,
          category: category,
          tags: tags,
          //stats: PostStats(likes: 0, comments: 0, saves: 0, views: 0),
          createdAt: DateTime.now(),
        );
        _posts.insert(0, newPost);
      }
      _errorMessage = null;
    } on ForumApiException catch (e) {
      _errorMessage = e.message;
      debugPrint('Create post API error: ${e.message}');
    } catch (e) {
      _errorMessage = 'Failed to create post: $e';
      debugPrint('Create post error: $e');
    }
    notifyListeners();
  }

  List<ForumPost> get filteredPosts {
    List<ForumPost> result = _selectedCategory == 'all'
        ? List.from(_posts)
        : _posts.where((p) => p.category == _selectedCategory).toList();

    // 🔥 PINNED POSTS FIRST
    result.sort((a, b) {
      if (a.isPinned == b.isPinned) return 0;
      return a.isPinned ? -1 : 1;
    });

    return result;
  }
}
