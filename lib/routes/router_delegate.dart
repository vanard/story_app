import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/providers/overlay_provider.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/routes/pages/bottom_sheet_page.dart';
import 'package:story_app/routes/pages/dialog_page.dart';
import 'package:story_app/screens/add_story_view.dart';
import 'package:story_app/screens/auth_view.dart';
import 'package:story_app/screens/detail_story_view.dart';
import 'package:story_app/screens/home_view.dart';
import 'package:story_app/screens/main_app.dart';
import 'package:story_app/screens/overlay.dart/confirm_logout_dialog.dart';
import 'package:story_app/screens/overlay.dart/image_picker_sheet.dart';
import 'package:story_app/screens/profile_view.dart';
import 'package:story_app/screens/splash_view.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  PageConfiguration? _currentConfiguration;
  final List<PageConfiguration> _pageStack = [];

  AppRouterDelegate() {
    debugPrint('AppRouterDelegate initialized');
    _pageStack.add(SplashPageConfiguration());
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  PageConfiguration? get currentConfiguration => _currentConfiguration;

  void push(PageConfiguration configuration) {
    if (configuration.bottomNavIndex != null &&
        _pageStack.last.pageName == PageName.main) {
      _pageStack.removeLast();
    }
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

  void navigateToTab(int index) {
    // _mainProvider.setNavigationIndex(index);
    if (_pageStack.isNotEmpty && _pageStack.last.pageName == PageName.main) {
      final currentMainCofig = _pageStack.last as MainPageConfiguration;

      if (currentMainCofig.bottomNavIndex != index) {
        replace(MainPageConfiguration(bottomNavIndex: index));
      }
    } else {
      clearAndPush(MainPageConfiguration(bottomNavIndex: index));
    }
    // final newConfig = PageConfiguration.mainWithTab(index);
    // push(newConfig);
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    debugPrint('Setting new route path: ${configuration.path}');

    clearAndPush(configuration);
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
      'Building AppRouterDelegate with current configuration: ${_currentConfiguration?.pageName}',
    );

    final overlayProvider = Provider.of<OverlayProvider>(context);

    return Navigator(
      key: navigatorKey,
      pages: [
        ..._pageStack.map((config) => _buildPage(config)),
        if (overlayProvider.activeOverlay != null)
          _buildOverlayPage(overlayProvider.activeOverlay!),
      ],
      // pages: _buildPages(context),
      onDidRemovePage: (page) {
        debugPrint('Page removed: ${page.key} ${_pageStack.length}');
      },
      onPopPage: (route, result) {
        // debugPrint('Pop ${route.settings.name}');
        debugPrint('Pop ${route.runtimeType}');
        if (!route.didPop(result)) return false;
        // debugPrint('cek pop 2: ${route.runtimeType == ModalBottomSheetRoute}');
        if(route.runtimeType == ModalBottomSheetRoute || route.runtimeType == DialogRoute) {
          overlayProvider.clearOverlay();
          return true;
        }
        pop();
        return true;
      },
    );
  }

  List<Page> _buildPages(BuildContext context) {
    // final pages = _pageStack.map((config) => _buildPage(config)).toList();

    final overlayProvider = context.watch<OverlayProvider>();
    // if (overlayProvider.activeOverlay != null) {
    //   pages.add(_buildOverlayPage(overlayProvider.activeOverlay!));
    // }

    // return pages;

    return [
      ..._pageStack.map((config) => _buildPage(config)),
      if (overlayProvider.activeOverlay != null)
        _buildOverlayPage(overlayProvider.activeOverlay!),
    ];
  }

  Page _buildPage(PageConfiguration config) {
    return MaterialPage(
      child: _pageForConfiguration(config),
      key: ValueKey(config.path),
    );
  }

  Page _buildOverlayPage(OverlayConfiguration config) {
    debugPrint(
      'Building overlay page for task: ${config.taskId} in ${config.overlayType} path ${config.path}',
    );
    switch (config.overlayType) {
      case OverlayType.dialog:
        return DialogPage(
          key: ValueKey(config.path),
          child: ConfirmLogoutDialog(),
        );
      case OverlayType.bottomSheet:
        return BottomSheetPage(
          key: ValueKey(config.path),
          child: ImagePickerSheet(),
        );
    }
  }

  Widget _pageForConfiguration(PageConfiguration config) {
    debugPrint(
      'Building page for configuration: ${config.pageName} ${config.bottomNavIndex}',
    );
    switch (config.pageName) {
      case PageName.main:
        return MainScreen(
          initialNavIndex: config.bottomNavIndex ?? 0,
          onNavTap: navigateToTab,
        );
      case PageName.splash:
        return SplashScreen(
          onAuthCheckComplete: (isLoggedIn) {
            if (isLoggedIn) {
              replace(MainPageConfiguration(bottomNavIndex: 0));
            } else {
              replace(LoginPageConfiguration());
            }
          },
        );
      case PageName.login:
        return AuthScreen(initialRoute: config.path);
      case PageName.register:
        return AuthScreen(initialRoute: config.path);
      case PageName.home:
        return HomeScreen();
      case PageName.detailStory:
        final detailConfig = config as DetailStoryPageConfiguration;
        return DetailStoryScreen(storyId: detailConfig.storyId);
      case PageName.addNewStory:
        return AddStoryScreen();
      case PageName.profile:
        return const ProfileScreen();
      default:
        return const Scaffold(body: Center(child: Text('Unknown Page')));
      // return UnknownScreen();
    }
  }
}
