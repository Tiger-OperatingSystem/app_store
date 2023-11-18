import 'package:app_store/src/widgets/input_text.dart';
import 'package:flutter/material.dart';

class SearchPackageWidget extends StatelessWidget {
  SearchPackageWidget({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 38,
          width: 380,
          child: InputTextWidget(
            controller: _controller,
            suffixIcon: IconButton(
              isSelected: false,
              iconSize: 16,
              onPressed: (){
                _controller.clear();
              }, 
              icon: const Icon(Icons.clear)
              ),
              labelText: "Pesquisar", 
              iconData: Icons.search,
            ),
        )
      ],
    );
  }
}