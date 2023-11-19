import 'package:app_store/src/widgets/input_text.dart';
import 'package:flutter/material.dart';

class SearchPackageWidget extends StatelessWidget {
  final void Function(String)? onPressed;
  SearchPackageWidget({super.key, this.onPressed});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        SizedBox(
          height: 38,
          width: 480,
          child: InputTextWidget(
            onPressed: onPressed,
            controller: _controller,
            suffixIcon: IconButton(
                isSelected: false,
                iconSize: 16,
                onPressed: () {
                  _controller.clear();
                },
                icon: const Icon(Icons.clear)),
            labelText: "Pesquisar por aplicação, pressione enter.",
            iconData: Icons.search,
          ),
        )
      ],
    );
  }
}
