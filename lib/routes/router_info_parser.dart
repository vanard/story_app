import 'package:flutter/widgets.dart';
import 'package:story_app/routes/page_configuration.dart';

class AppRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return PageConfiguration.fromRoute(routeInformation.uri);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    final uri = Uri.parse(configuration.path);
    return RouteInformation(uri: uri);
  }
}
