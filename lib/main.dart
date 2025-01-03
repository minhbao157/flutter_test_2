import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/color_picker_cubit.dart';
import 'provider/color_picker_provider.dart';

import 'cubit/counter_cubit.dart';
import 'pages/page1.dart';
import 'pages/page2.dart';
import 'pages/page3.dart';
import 'pages/page4.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (_) => CounterCubit()),
        ChangeNotifierProvider(create: (_) => ColorPickerProvider()),
        BlocProvider(create: (_) => ColorPickerCubit()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.blue),
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

  static const List<String> _tabs = ['/page1', '/page3', '/page4'];

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
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens),
            label: 'Pick color',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens),
            label: 'Pick Color 2',
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
  initialLocation: '/page1',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
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
  ],
);
