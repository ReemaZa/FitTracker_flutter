import '../../domain/entities/forum_post.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/forum_user.dart';
import '../../domain/entities/post_stats.dart';

final mockPosts = [
  ForumPost(
    id: 1,
    title: 'Morning workout tips',
    content: 'Here are some tips to stay consistent with morning workouts...',
    author: ForumUser(
        id: 1, name: 'Alex', avatarUrl: 'https://i.pravatar.cc/150?img=1'),
    category: 'fitness-tips',
    tags: ['morning', 'workout'],
    //stats: PostStats(likes: 12, comments: 3, saves: 2, views: 100),
    isPinned: true,
    createdAt: DateTime.now().subtract(Duration(days: 1)),
  ),
];

final mockComments = [
  Comment(
    id: 1,
    content: 'Great tips!',
    author: ForumUser(
        id: 2, name: 'Taylor', avatarUrl: 'https://i.pravatar.cc/150?img=2'),
    postId: 1,
    createdAt: DateTime.now().subtract(Duration(hours: 3)),
    likes: 5,
    replies: [],
  ),
];

class ForumRemoteDataSource {
  Future<List<ForumPost>> fetchPosts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockPosts;
  }

  Future<List<Comment>> fetchComments(String postId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockComments.where((c) => c.postId == postId).toList();
  }
}
