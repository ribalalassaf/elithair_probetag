import 'package:elithair_probetag/config/injectable.dart';
import 'package:elithair_probetag/config/router/router.dart';
import 'package:elithair_probetag/utils/hive_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  configureDependencies();

  final appRouter = AppRouter();
  await HiveHelper.init();
  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: appRouter.config(),
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.blueAccent)),
    );
  }
}
