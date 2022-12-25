import 'package:flutter/material.dart';
import 'package:travel_app/representation/screens/task_screen/task_screen.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/text_style.dart';

class SelectOption extends StatefulWidget {
  const SelectOption({super.key, required this.list});

  final List<String> list;

  @override
  State<SelectOption> createState() => _SelectOptionState();
}

class _SelectOptionState extends State<SelectOption> {
  String dropdownValue = list[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorPalette.primaryColor, width: 2)),
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyleCustom.normalSizePrimary,
            ),
          );
        }).toList(),
      ),
    );
  }
}
