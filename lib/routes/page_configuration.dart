import 'package:flutter/foundation.dart';

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

sealed class PageConfiguration {
  final PageName? pageName;

  String get path;

  const PageConfiguration({this.pageName});

  static PageConfiguration fromRoute(Uri uri) {
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
}

final class MainPageConfiguration extends PageConfiguration {
  MainPageConfiguration() : super(pageName: PageName.main);
  bool get isMain => pageName == PageName.main;

  @override
  String get path => '/';
}

final class SplashPageConfiguration extends PageConfiguration {
  SplashPageConfiguration() : super(pageName: PageName.splash);
  bool get isSplash => pageName == PageName.splash;

  @override
  String get path => '/splash';
}

final class LoginPageConfiguration extends PageConfiguration {
  LoginPageConfiguration() : super(pageName: PageName.login);
  bool get isLogin => pageName == PageName.login;

  @override
  String get path => '/login';
}

final class RegisterPageConfiguration extends PageConfiguration {
  RegisterPageConfiguration() : super(pageName: PageName.register);
  bool get isRegister => pageName == PageName.register;

  @override
  String get path => '/register';
}

final class HomePageConfiguration extends PageConfiguration {
  HomePageConfiguration() : super(pageName: PageName.home);
  bool get isHome => pageName == PageName.home;

  @override
  String get path => '/home';
}

final class DetailStoryPageConfiguration extends PageConfiguration {
  DetailStoryPageConfiguration(this.storyId)
    : super(pageName: PageName.detailStory);
  bool get isDetailStory => pageName == PageName.detailStory;

  final String storyId;

  @override
  String get path => '/story/$storyId';
}

final class AddNewStoryPageConfiguration extends PageConfiguration {
  AddNewStoryPageConfiguration() : super(pageName: PageName.addNewStory);
  bool get isAddNewStory => pageName == PageName.addNewStory;

  @override
  String get path => '/add-new-story';
}

final class ProfilePageConfiguration extends PageConfiguration {
  ProfilePageConfiguration() : super(pageName: PageName.profile);

  bool get isProfile => pageName == PageName.profile;

  @override
  String get path => '/profile';
}

final class UnknownPageConfiguration extends PageConfiguration {
  UnknownPageConfiguration() : super(pageName: null);

  bool get isUnknown => pageName == null;

  @override
  String get path => '/unknown';
}
