import 'package:flutter/widgets.dart';
import 'package:story_app/routes/page_configuration.dart';

class AppRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    debugPrint('Parsing route information: ${routeInformation.uri}');
    // if (routeInformation.uri.path.isEmpty || routeInformation.uri.path == '/') {
    //   return SplashPageConfiguration();
    // }
    return PageConfiguration.fromRoute(routeInformation.uri);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    final uri = Uri.parse(configuration.path);
    debugPrint('Restoring route information: $uri');
    return RouteInformation(uri: uri);
  }
}
