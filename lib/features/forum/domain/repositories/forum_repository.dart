import 'package:fit_tracker/features/forum/domain/entities/comment.dart';
import 'package:fit_tracker/features/forum/domain/entities/forum_post.dart';

abstract class ForumRepository {
  Future<List<ForumPost>> getPosts();
  Future<ForumPost> getPostById(String id);
  Future<List<Comment>> getComments(String postId);
  Future<void> likePost(String postId);
  Future<void> addComment(String postId, Comment comment);
}
