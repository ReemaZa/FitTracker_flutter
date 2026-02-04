import 'package:flutter/material.dart';
import 'package:fit_tracker/features/forum/presentation/screens/forum_page.dart';
import 'package:fit_tracker/features/forum/presentation/screens/post_detail_page.dart';

class AppRouter {
  static const String forum = '/forum';
  static const String postDetail = '/post-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case forum:
        return MaterialPageRoute(
          builder: (_) => const ForumPage(),
          settings: settings,
        );
      case postDetail:
        final postId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => PostDetailPage(postId: postId),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const ForumPage(),
          settings: settings,
        );
    }
  }
}
