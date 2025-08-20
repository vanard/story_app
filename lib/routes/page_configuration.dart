import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum PageName {
  main,
  splash,
  home,
  login,
  register,
  detailStory,
  addNewStory,
  profile,
}

class PageConfiguration {
  final PageName? pageName;
  final String path;
  final int? bottomNavIndex;

  const PageConfiguration({
    required this.pageName,
    required this.path,
    this.bottomNavIndex,
  });

  factory PageConfiguration.fromRoute(Uri uri) {
    debugPrint('Parsing route from URI: $uri');
    switch (uri.path) {
      case '/':
        return MainPageConfiguration();
      case '/splash':
        return SplashPageConfiguration();
      case '/login':
        return LoginPageConfiguration();
      case '/register':
        return RegisterPageConfiguration();
      case '/home':
        return HomePageConfiguration();
      case var path when path.startsWith('/story/'):
        final storyId = path.replaceFirst('/story/', '');
        return DetailStoryPageConfiguration(storyId);
      case '/add-new-story':
        return AddNewStoryPageConfiguration();
      case '/profile':
        return ProfilePageConfiguration();
      default:
        return UnknownPageConfiguration();
    }
  }

  static PageConfiguration mainWithTab(int bottomNavIndex) {
    return PageConfiguration(
      pageName: PageName.main,
      path: '/',
      bottomNavIndex: bottomNavIndex,
    );
  }
}

class MainPageConfiguration extends PageConfiguration {
  MainPageConfiguration({int? bottomNavIndex})
    : super(pageName: PageName.main, path: '/', bottomNavIndex: bottomNavIndex ?? 0);
}

final class SplashPageConfiguration extends PageConfiguration {
  SplashPageConfiguration() : super(pageName: PageName.splash, path: '/splash');
}

final class LoginPageConfiguration extends PageConfiguration {
  LoginPageConfiguration() : super(pageName: PageName.login, path: '/login');
}

final class RegisterPageConfiguration extends PageConfiguration {
  RegisterPageConfiguration()
    : super(pageName: PageName.register, path: '/register');
}

final class HomePageConfiguration extends PageConfiguration {
  HomePageConfiguration() : super(pageName: PageName.home, path: '/home', bottomNavIndex: 0);
}

final class DetailStoryPageConfiguration extends PageConfiguration {
  DetailStoryPageConfiguration(this.storyId)
    : super(pageName: PageName.detailStory, path: '/story/$storyId');

  final String storyId;
}

final class AddNewStoryPageConfiguration extends PageConfiguration {
  AddNewStoryPageConfiguration() : super(pageName: PageName.addNewStory, path: '/add-new-story', bottomNavIndex: 1);
}

final class ProfilePageConfiguration extends PageConfiguration {
  ProfilePageConfiguration() : super(pageName: PageName.profile, path: '/profile', bottomNavIndex: 2);
}

final class UnknownPageConfiguration extends PageConfiguration {
  UnknownPageConfiguration() : super(pageName: null, path: '/unknown');
}
