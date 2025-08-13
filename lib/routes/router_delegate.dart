import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/screens/auth_view.dart';
import 'package:story_app/screens/splash_view.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  PageConfiguration? _currentConfiguration;
  final List<PageConfiguration> _pageStack = [];
  // final AuthRepository _authRepository;

  // bool? _isLoggedIn;

  // AppRouterDelegate({required AuthRepository authRepository})
  //   : _authRepository = authRepository {
  AppRouterDelegate() {
    debugPrint('AppRouterDelegate initialized');
    _pageStack.add(SplashPageConfiguration());
    // _init();
  }

  // void _init() async {
  // clearAndPush(SplashPageConfiguration());
  //   _isLoggedIn = await _authRepository.isLoggedIn();
  //   notifyListeners();
  // }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  PageConfiguration? get currentConfiguration => _currentConfiguration;

  void push(PageConfiguration configuration) {
    _pageStack.add(configuration);
    _currentConfiguration = configuration;
    notifyListeners();
  }

  void replace(PageConfiguration configuration) {
    if (_pageStack.isNotEmpty) {
      _pageStack.removeLast();
    }
    _pageStack.add(configuration);
    _currentConfiguration = configuration;
    notifyListeners();
  }

  void pop() {
    if (_pageStack.isNotEmpty) {
      _pageStack.removeLast();
    }
    _currentConfiguration = _pageStack.isNotEmpty ? _pageStack.last : null;
    notifyListeners();
  }

  void clearAndPush(PageConfiguration configuration) {
    _pageStack.clear();
    push(configuration);
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    // debugPrint('Setting new route path: ${configuration.pageName}');
    debugPrint('Setting new route path: ${configuration.path}');

    clearAndPush(configuration);
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'Building AppRouterDelegate with current configuration: ${_currentConfiguration?.pageName}',
    );
    return Navigator(
      key: navigatorKey,
      pages: _pageStack.map((config) => _buildPage(config)).toList(),
      // pages: _pageStack.map((config) {
      //   debugPrint('Building page stack: ${config.pageName}');
      //   return _buildPage(config);
      // }).toList(),
      onDidRemovePage: (page) {
        debugPrint('Page removed: ${page.key}');
      },
    );
  }

  Page _buildPage(PageConfiguration config) {
    return MaterialPage(
      child: _pageForConfiguration(config),
      key: ValueKey(config.path),
    );
  }

  Widget _pageForConfiguration(PageConfiguration config) {
    debugPrint('Building page for configuration: ${config.pageName}');
    switch (config.pageName) {
      case PageName.splash:
        return SplashScreen(
          onAuthCheckComplete: (isLoggedIn) {
            // _isLoggedIn = isLoggedIn;
            if (isLoggedIn) {
              replace(HomePageConfiguration());
            } else {
              replace(LoginPageConfiguration());
            }
          },
        );
      case PageName.login:
        return AuthScreen();
      case PageName.register:
        return AuthScreen();
      // case PageName.home:
      // return HomeScreen();
      // case PageName.detailStory:
      //   final detailConfig = config as DetailStoryPageConfiguration;
      // return StoryDetailScreen(storyId: detailConfig.storyId);
      // case PageName.addNewStory:
      // return AddNewStoryScreen();
      default:
        return const Scaffold(body: Center(child: Text('Unknown Page')));
      // return UnknownScreen();
    }
  }
}
