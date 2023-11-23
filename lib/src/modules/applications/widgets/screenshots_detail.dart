import 'package:app_store/src/modules/applications/applications_model.dart';
import 'package:flutter/material.dart';

class ScrenshootApplicationDetailWidget extends StatefulWidget {
  final ApplicationsModel applicationModel;
  const ScrenshootApplicationDetailWidget(
      {super.key, required this.applicationModel});

  @override
  State<ScrenshootApplicationDetailWidget> createState() =>
      _ScrenshootApplicationDetailWidgetState();
}

class _ScrenshootApplicationDetailWidgetState
    extends State<ScrenshootApplicationDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.horizontal,
        itemCount: widget.applicationModel.screenshots!.length,
        itemBuilder: (context, index) {
          return Image.network(
            widget.applicationModel.screenshots![index]['imgDesktopUrl'],
          );
        },
      ),
    );
  }
}
