import 'package:flutter/widgets.dart';
import 'package:story_app/routes/page_configuration.dart';
import 'package:story_app/routes/router_delegate.dart';

extension AppRouter on BuildContext {
  AppRouterDelegate get appRouter =>
      Router.of(this).routerDelegate as AppRouterDelegate;

  void pushTo(PageConfiguration config) => appRouter.push(config);
  void replaceWith(PageConfiguration config) => appRouter.replace(config);
  void popRoute() => appRouter.pop();
  void clearAndPushTo(PageConfiguration config) =>
      appRouter.clearAndPush(config);

  void navigateToTab(int navIndex) => appRouter.navigateToTab(navIndex);
}
