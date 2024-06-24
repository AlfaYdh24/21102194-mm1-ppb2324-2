import 'package:flutter/material.dart';
// import 'package:tubes_sehatyuk/chat_page.dart';
import 'package:tubes_sehatyuk/location_page.dart';
import 'package:tubes_sehatyuk/news_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'profile_page.dart';
import 'checkup_questions_page.dart';
import 'result_page.dart';
import 'search_page.dart';
import 'chat_page.dart';
import 'detail_article_page.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/home': (context) => HomePage(),
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/profile': (context) => ProfilePage(),
    '/checkup': (context) => LocationPage(),
    '/result': (context) => ResultPage(diseaseName: '', percentage: 0),
    '/search': (context) => SearchPage(),
    '/chat': (context) => ChatPage(),
    '/detail': (context) => DetailArticlePage(
      title: '',
      imagePath: '',
      content: '',
    ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/checkup_questions') {
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) {
          return CheckupQuestionsPage(
            title: args['title'],
            questions: args['questions'],
          );
        },
      );
    }
    return null;
  }

  static List<Widget> widgetOptions = <Widget>[
    HomePage(),
    NewsPage(), // Placeholder for the Search page
    LocationPage(),
    ChatPage(),
    ProfilePage(),
  ];
}
