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
      this.label,
      this.validator});

  List<OptionModal> list;
  double? searchOption;
  String? label;
  final String? Function(String?)? validator;

  @override
  State<SelectOption> createState() => _SelectOptionState();

  String dropdownValue;
  final void Function(T?) onChanged;
}

class _SelectOptionState extends State<SelectOption> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            DropdownButtonFormField<String>(
              value:
                  widget.dropdownValue.isNotEmpty ? widget.dropdownValue : null,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              validator: widget.validator,
              decoration: InputDecoration(
                labelText: widget.label,
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: theme.primaryColor, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onChanged: (String? value) {
                widget.onChanged(value);
                setState(() {
                  widget.dropdownValue = value!;
                });
              },
              items: widget.list
                  .map<DropdownMenuItem<String>>((OptionModal value) {
                return DropdownMenuItem(
                  value: value.value,
                  child: Text(
                    value.display.toString(),
                    style: theme.textTheme.subtitle1!
                        .copyWith(color: Colors.black),
                  ),
                );
              }).toList(),
            )
          ],
        ),
        SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
