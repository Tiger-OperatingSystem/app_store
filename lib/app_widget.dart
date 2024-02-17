import 'package:app_store/src/core/scrolladapter.dart';
import 'package:app_store/src/modules/main/main_view.dart';
import 'package:app_store/src/themes/themes.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: ScrollAdapter(),
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      darkTheme: darkTheme,
      home: const MainView(),
    );
  }
}
