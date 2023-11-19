import 'package:app_store/src/modules/main/widgets/menu.dart';
import 'package:flutter/material.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Row(
        children: [
          // Menu side
          const Expanded(
            child: MenuWidget(),
          ),

          // Content side
          Expanded(
            flex: 4,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
