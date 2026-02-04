import '../../domain/entities/forum_post.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/forum_repository.dart';
import '../datasources/forum_remote_datasource.dart';

class ForumRepositoryImpl implements ForumRepository {
  final ForumRemoteDataSource remoteDataSource;

  ForumRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ForumPost>> getPosts() => remoteDataSource.fetchPosts();

  @override
  Future<ForumPost> getPostById(String id) async {
    final posts = await remoteDataSource.fetchPosts();
    return posts.firstWhere((p) => p.id == id);
  }

  @override
  Future<List<Comment>> getComments(String postId) =>
      remoteDataSource.fetchComments(postId);

  @override
  Future<void> likePost(String postId) async {
    // In mock, do nothing
  }

  @override
  Future<void> addComment(String postId, Comment comment) async {
    // In mock, do nothing
  }
}
