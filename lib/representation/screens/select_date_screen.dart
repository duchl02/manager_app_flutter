import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';

import '../../core/constants/color_constants.dart';

class SelectDateScreen extends StatefulWidget {
  SelectDateScreen({
    super.key,
    this.initialDates,
  });

  static const String routeName = "/select_date_screen";

  List<DateTime>? initialDates;

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  DateTime? rangeStartDate;

  DateTime? rangeEndDate;

  bool selectionSingle = true;

  void handlePropertyChange(String f) => {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ColorPalette.primaryColor,
        title: Text("Danh sách ngày điểm danh"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          SizedBox(
            height: kMediumPadding,
          ),
          SfDateRangePicker(
            initialSelectedDates: widget.initialDates,
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.multiple,
            monthViewSettings:
                DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
          ),

        ]),
      ),
    );
  }
}
