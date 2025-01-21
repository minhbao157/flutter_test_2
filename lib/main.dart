//Flutter Core Packages
import 'package:flutter/material.dart';
import 'package:namer_app/features/Home/presentation/pages/add_new_pond_page.dart';
import 'package:namer_app/features/Home/presentation/pages/pond_viewer_page.dart';
import 'package:namer_app/features/Home/presentation/pond/pond_bloc.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Initialization Dependencies
import 'features/Home/domain/entities/pond.dart';
import 'init_independencies.dart';

//Core Theme
import 'core/theme/theme.dart';

//Pages
import 'features/auth/presentation/pages/page_not_found.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/Home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/page1.dart';
import 'features/auth/presentation/pages/page2.dart';
import 'features/auth/presentation/pages/page3.dart';
import 'features/auth/presentation/pages/page4.dart';

//Providers
import 'features/auth/presentation/provider/color_picker_provider.dart';

//Bloc
import 'features/auth/presentation/bloc/auth_bloc.dart';

//Cubit
import 'features/auth/presentation/cubits/counter_cubit.dart';
import 'features/auth/presentation/cubits/color_picker_cubit.dart';
import 'features/auth/presentation/cubits/app_user/app_user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInDependencies();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit()),
        ChangeNotifierProvider(create: (_) => ColorPickerProvider()),
        BlocProvider(create: (_) => ColorPickerCubit()),
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<PondBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: AppTheme.lightThemeMode,
    );
  }
}

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({required this.child, Key? key}) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  static const List<String> _tabs = ['/homepage','/page1', '/page3', '/page4'];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    context.go(_tabs[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens),
            label: 'Provider',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens),
            label: 'Cubit',
          ),
        ],
      ),
    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/homepage',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/homepage',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/add-new-pond',
          builder: (context, state) => const AddNewPondPage(),
        ),
        GoRoute(
          path: '/page1',
          builder: (context, state) => const Page1(),
        ),
        GoRoute(
          path: '/page2',
          builder: (context, state) => const Page2(),
        ),
        GoRoute(
          path: '/page3',
          builder: (context, state) => const Page3(),
        ),
        GoRoute(
          path: '/page4',
          builder: (context, state) => const Page4(),
        ),
      ],
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, state) => BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    ),
    GoRoute(
      path: '/pond-page',
      builder: (context , state) {
        final pond = state.extra as Pond; // Assuming 'Pond' is the type of the required argument
        return PondViewerPage(pond: pond);
      },
    ),
    GoRoute(
      path: '/404',
      builder: (context, state) => const PageNotFound(),
    ),
  ],
  errorBuilder: (context, state) => const PageNotFound(),
);

