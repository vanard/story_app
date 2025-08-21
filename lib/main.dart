import 'package:flutter/material.dart';
import 'package:story_app/data/api_service.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/l10n/app_localizations.dart';
import 'package:story_app/providers/auth_provider.dart';
import 'package:story_app/providers/main_provider.dart';
import 'package:story_app/providers/stories_provider.dart';
import 'package:story_app/routes/router_delegate.dart';
import 'package:story_app/routes/router_info_parser.dart';
import 'package:story_app/util/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localization/flutter_localization.dart';

final FlutterLocalization localization = FlutterLocalization.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouterDelegate _appRouterDelegate;
  late final AppRouteInformationParser _appRouteInformationParser;
  late final AuthProvider _authProvider;
  late final StoriesProvider _storiesProvider;
  late final MainProvider _mainProvider;

  @override
  void initState() {
    super.initState();
    final apiService = ApiService();
    final authRepository = AuthRepository(service: apiService);
    _authProvider = AuthProvider(authRepository: authRepository);
    _storiesProvider = StoriesProvider(service: apiService);
    _mainProvider = MainProvider();

    _appRouterDelegate = AppRouterDelegate(mainProvider: _mainProvider);
    _appRouteInformationParser = AppRouteInformationParser();
  }

  @override
  void dispose() {
    _authProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _authProvider,
        ),
        ChangeNotifierProvider(create: (context) => _storiesProvider),
        ChangeNotifierProvider(create: (context) => _mainProvider),
      ],
      child: MaterialApp.router(
        theme: lightTheme.copyWith(
          textTheme: baseTextTheme(context, lightTheme),
        ),
        darkTheme: darkTheme.copyWith(
          textTheme: baseTextTheme(context, darkTheme),
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        // supportedLocales: localization.supportedLocales,
        // localizationsDelegates: localization.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        title: 'Story App',
        routerDelegate: _appRouterDelegate,
        routeInformationParser: _appRouteInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
