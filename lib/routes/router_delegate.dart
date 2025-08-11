import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:story_app/routes/page_configuration.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  PageConfiguration? _currentConfiguration;
  final List<PageConfiguration> _pageStack = [];

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
    clearAndPush(configuration);
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _pageStack.map((config) => _buildPage(config)).toList(),
      // onDidRemovePage: (page) {
      //   if (_pageStack.isNotEmpty) {
      //     _pageStack.removeLast();
      //     _currentConfiguration = _pageStack.isNotEmpty ? _pageStack.last : null;
      //     notifyListeners();
      //   }
      // },
    );
  }

  Page _buildPage(PageConfiguration config) {
    return MaterialPage(
      child: _pageForConfiguration(config),
      key: ValueKey(config.path),
    );
  }

  Widget _pageForConfiguration(PageConfiguration config) {
    return Placeholder();
    switch (config.pageName) {
      case PageName.splash:
      // return SplashScreen();
      case PageName.login:
      // return LoginScreen();
      case PageName.register:
      // return RegisterScreen();
      case PageName.home:
      // return HomeScreen();
      case PageName.detailStory:
        final detailConfig = config as DetailStoryPageConfiguration;
      // return StoryDetailScreen(storyId: detailConfig.storyId);
      case PageName.addNewStory:
      // return AddNewStoryScreen();
      default:
      // return UnknownScreen();
    }
  }
}
