import 'package:flutter/material.dart';
import 'package:travel_app/representation/screens/task_screen/task_screen.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/text_style.dart';

class SelectOption<T> extends StatefulWidget {
  SelectOption(
      {super.key,
      required this.list,
      required this.dropdownValue,
      required this.onChanged});

  List<String> list;

  @override
  State<SelectOption> createState() => _SelectOptionState();

  String dropdownValue;
  final void Function(T?) onChanged;
}

class _SelectOptionState extends State<SelectOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2)),
      child: DropdownButton<String>(
        value: widget.dropdownValue.isNotEmpty ? widget.dropdownValue : null,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        onChanged: (String? value) {
            widget.onChanged(value);

          // This is called when the user selects an item.
          setState(() {
            widget.dropdownValue = value!;
          });
        },
        // onChanged: widget.onChanged,
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
