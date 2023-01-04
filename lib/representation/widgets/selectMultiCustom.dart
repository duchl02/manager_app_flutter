import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SelectMultiCustom extends StatefulWidget {
  const SelectMultiCustom(
      {super.key, required this.title, required this.listValues, this.onTap,  this.defaultListValues});

  final String title;
  final List listValues;
  final List? defaultListValues;
  final Function? onTap;
  

  @override
  State<SelectMultiCustom> createState() => _SelectMultiCustomState();
}

class _SelectMultiCustomState extends State<SelectMultiCustom> {
  //List<Animal> _selectedAnimals = [];
  List _selectedValue1 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _items = widget.listValues
        .map((value) => MultiSelectItem(value, value.name))
        .toList();
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              child: Column(
                children: <Widget>[
                  MultiSelectBottomSheetField(
                    initialChildSize: 0.4,
                    listType: MultiSelectListType.CHIP,
                    initialValue: widget.defaultListValues!,
                    searchable: true,
                    buttonText: Text("Chọn " + widget.title),
                    title: Text(widget.title),
                    items: _items,
                    onConfirm: (values) {
                      widget.onTap!(values);
                      _selectedValue1 = values;
                    },
                    chipDisplay: MultiSelectChipDisplay(
                      onTap: (value) {
                        setState(() {
                          _selectedValue1.remove(value);
                        });
                        widget.onTap!(_selectedValue1);

                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
