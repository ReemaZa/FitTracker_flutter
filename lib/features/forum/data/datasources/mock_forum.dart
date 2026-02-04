import 'package:fit_tracker/features/forum/data/models/category.dart';
import 'package:fit_tracker/features/forum/domain/entities/comment.dart';
import 'package:fit_tracker/features/forum/domain/entities/forum_post.dart';
import 'package:fit_tracker/features/forum/domain/entities/forum_user.dart';
//import 'package:fit_tracker/features/forum/domain/entities/post_//stats.dart';

class MockForum {
  // List of categories
  static final List<Category> categories = [
    Category(name: 'fitness-tips'),
    Category(name: 'nutrition'),
    Category(name: 'motivation'),
    Category(name: 'qna'),
    Category(name: 'workout'),
    Category(name: 'progress'),
    Category(name: 'gear'),
  ];

  // Current logged-in user
  static final ForumUser currentUser = ForumUser(
    id: 0,
    name: 'You',
    avatarUrl: 'https://i.pravatar.cc/150?img=10',
    level: 5,
    badges: ['starter', 'contributor'],
  );

  // Mock posts
  static final List<ForumPost> _posts = [
    ForumPost(
      id: 1,
      title: 'Morning workout tips',
      content: 'Here are some tips to stay consistent with morning workouts...',
      author: ForumUser(
        id: 1,
        name: 'Alex',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
      ),
      category: 'Fitness',
      tags: ['morning', 'workout'],
      //stats: Post//stats(likes: 12, comments: 3, saves: 2, views: 100),
      isPinned: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ForumPost(
      id: 2,
      title: 'Healthy recipes for beginners',
      content: 'Check out these easy healthy recipes to start your journey...',
      author: ForumUser(
        id: 2,
        name: 'Taylor',
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      category: 'Nutrition',
      tags: ['recipes', 'healthy'],
      //stats: Post//stats(likes: 8, comments: 1, saves: 5, views: 70),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ForumPost(
      id: 3,
      title: 'Managing stress and anxiety',
      content:
          'Here are some strategies to manage stress and improve mental wellness...',
      author: ForumUser(
        id: 5,
        name: 'Casey',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
      ),
      category: 'Mental Health',
      tags: ['stress', 'wellness', 'meditation'],
      //stats: Post//stats(likes: 15, comments: 5, saves: 8, views: 120),
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ForumPost(
      id: 4,
      title: 'Welcome to the forum!',
      content:
          'This is a space for everyone to share experiences, ask questions, and support each other...',
      author: ForumUser(
        id: 6,
        name: 'Morgan',
        avatarUrl: 'https://i.pravatar.cc/150?img=6',
      ),
      category: 'General',
      tags: ['welcome', 'community'],
      //stats: Post//stats(likes: 20, comments: 8, saves: 10, views: 150),
      isPinned: true,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  // Mock comments
  static final List<Comment> _comments = [
    Comment(
      id: 1,
      content: 'Great tips!',
      author: ForumUser(
        id: 2,
        name: 'Taylor',
        avatarUrl: 'https://i.pravatar.cc/150?img=2',
      ),
      postId: 1,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      likes: 5,
    ),
    Comment(
      id: 2,
      content: 'Thanks for sharing!',
      author: ForumUser(
        id: 3,
        name: 'Jordan',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
      ),
      postId: 1,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 2,
    ),
    Comment(
      id: 3,
      content: 'Can you share more exercises?',
      author: ForumUser(
        id: 4,
        name: 'Sam',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
      ),
      postId: 1,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      likes: 1,
    ),
  ];

  // Methods
  static ForumPost? getPost(int id) {
    return _posts.firstWhere((p) => p.id == id, orElse: () => _posts.first);
  }

  static List<Comment> getCommentsForPost(int postId) {
    return _comments.where((c) => c.postId == postId).toList();
  }

  static List<ForumPost> getAllPosts() => _posts;
}
