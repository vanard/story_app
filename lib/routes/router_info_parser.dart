import 'package:flutter/widgets.dart';
import 'package:story_app/routes/page_configuration.dart';

class AppRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    final uri = routeInformation.uri;
    final path = uri.path;

    debugPrint('Parsing route information: $uri');

    // if (uri.path.isEmpty || uri.path == '/') {
    //   return SplashPageConfiguration();
    // }

    if (path == '/') {
      final navIndex = int.tryParse(uri.queryParameters['tab'] ?? '0') ?? 0;
      return PageConfiguration.mainWithTab(navIndex);
    }

    return PageConfiguration.fromRoute(uri);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    final uri = Uri.parse(configuration.path);
    debugPrint('Restoring route information: $uri');
    return RouteInformation(uri: uri);
  }
}
