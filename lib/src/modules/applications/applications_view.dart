// ignore_for_file: must_be_immutable

import 'package:app_store/src/modules/main/widgets/menu.dart';
import 'package:app_store/src/modules/main/widgets/search_package.dart';
import 'package:flutter/material.dart';

class ApplicationsView extends StatefulWidget {
  String? searchAplication;
  ApplicationsView({
    super.key,
    this.searchAplication,
  });

  @override
  State<ApplicationsView> createState() => _ApplicationsViewState();
}

final isSearch = ValueNotifier(false);

class _ApplicationsViewState extends State<ApplicationsView> {
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
            child: Column(
              children: [
                Center(
                  child: SearchPackageWidget(
                    onPressed: (value) {
                      setState(() {
                        widget.searchAplication = value;
                        isSearch.value = true;
                      });
                    },
                  ),
                ),
                _switch(isSearch.value, widget.searchAplication ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _switch(bool isSearch, String searchAplication) {
  try {
    if (isSearch) {
      return Center(child: Text(searchAplication));
    }

    return const Center(child: Text("Applications page"));
  } catch (e) {
    rethrow;
  }
}
