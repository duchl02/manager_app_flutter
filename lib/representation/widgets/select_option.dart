import 'package:flutter/material.dart';
import 'package:travel_app/Data/models/option_modal.dart';
import 'package:travel_app/representation/screens/task_screen/task_screen.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/text_style.dart';

class SelectOption<T> extends StatefulWidget {
  SelectOption(
      {super.key,
      required this.list,
      required this.dropdownValue,
      required this.onChanged,
      this.searchOption,
      this.label});

  List<OptionModal> list;
  double? searchOption;
  String? label;

  @override
  State<SelectOption> createState() => _SelectOptionState();

  String dropdownValue;
  final void Function(T?) onChanged;
}

class _SelectOptionState extends State<SelectOption> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Column(children: [
                SizedBox(height: 14),
                Text(widget.label!, style: TextStyleCustom.normalSizePrimary)
              ])
            : SizedBox(),
        SizedBox(
          height: 6,
        ),
        Container(
          padding: EdgeInsets.only(right: 10, left: 10, top: 4, bottom:4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1)),
          child: Column(
            children: [
              DropdownButton<String>(
                
                value: widget.dropdownValue.isNotEmpty
                    ? widget.dropdownValue
                    : null,
                underline: SizedBox(),
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: ColorPalette.primaryColor),
                onChanged: (String? value) {
                  widget.onChanged(value);

                  // This is called when the user selects an item.
                  setState(() {
                    widget.dropdownValue = value!;
                  });
                },
                // onChanged: widget.onChanged,
                items: widget.list
                    .map<DropdownMenuItem<String>>((OptionModal value) {
                  return DropdownMenuItem(
                    value: value.value,
                    child: Text(
                      value.display.toString(),
                      style: TextStyleCustom.normalText,
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        )
      ],
    );
  }
}
