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


    if (path == '/main') {
      final navIndex = int.tryParse(uri.queryParameters['tab'] ?? '0') ?? 0;
      return MainPageConfiguration(bottomNavIndex: navIndex);
    }

    return PageConfiguration.fromRoute(uri);
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    if (configuration.pageName == PageName.main) {
      final uri = Uri.parse('/main').replace(
        queryParameters: {
          'tab': configuration.bottomNavIndex?.toString() ?? '0',
        },
      );
      return RouteInformation(uri: uri);
    }

    final uri = Uri.parse(configuration.path);
    debugPrint('Restoring route information: $uri');
    return RouteInformation(uri: uri);
  }
}
