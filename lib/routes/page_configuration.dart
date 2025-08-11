enum PageName { splash, home, login, register, detailStory, addNewStory }

// sealed class PageConfiguration {
//   final PageName? pageName;

//   PageConfiguration.home() : pageName = PageName.home;

//   PageConfiguration.login() : pageName = PageName.login;

//   PageConfiguration.register() : pageName = PageName.register;

//   PageConfiguration.detailStory(String id) : pageName = PageName.detailStory, storyId = id;

//   PageConfiguration.addNewStory() : pageName = PageName.addNewStory;

//   const PageConfiguration({this.pageName});
// }

sealed class PageConfiguration {
  final PageName? pageName;

  String get path;

  const PageConfiguration({this.pageName});

  // Helper method to parse route information
  static PageConfiguration fromRoute(Uri uri) {
    switch (uri.path) {
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
      default:
        return UnknownPageConfiguration();
    }
  }
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

final class UnknownPageConfiguration extends PageConfiguration {
  UnknownPageConfiguration() : super(pageName: null);

  bool get isUnknown => pageName == null;

  @override
  String get path => '/unknown';
}
