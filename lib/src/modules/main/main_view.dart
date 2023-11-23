import 'package:app_store/src/modules/applications/applications_view.dart';
import 'package:app_store/src/modules/discovery/discovery_view.dart';
import 'package:app_store/src/modules/installed/installed_view.dart';
import 'package:app_store/src/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: HeaderWidget(
          windowManager: windowManager,
          context: context,
        ),

        //Content
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: const TabBarView(children: [
            DiscoveryView(),
            ApplicationsMainView(),
            InstalledView(),
          ]),
        ),
      ),
    );
  }
}
