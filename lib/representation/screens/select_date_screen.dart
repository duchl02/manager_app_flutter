import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/representation/widgets/app_bar_container.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';

import '../../core/constants/color_constants.dart';

class SelectDateScreen extends StatelessWidget {
  // const SelectDateScreen({super.key});

  static const String routeName = "/select_date_screen";

  DateTime? rangeStartDate;
  DateTime? rangeEndDate;
  bool selectionSingle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primaryColor,
        title: Text("Chọn ngày tháng"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          SizedBox(
            height: kMediumPadding,
          ),
          SfDateRangePicker(
            view: DateRangePickerView.month,
            selectionMode: selectionSingle ? DateRangePickerSelectionMode.single : DateRangePickerSelectionMode.range,
            monthViewSettings:
                DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
            selectionColor: ColorPalette.yellowColor,
            startRangeSelectionColor: ColorPalette.yellowColor,
            endRangeSelectionColor: ColorPalette.yellowColor,
            rangeSelectionColor: ColorPalette.yellowColor.withOpacity(0.25),
            todayHighlightColor: ColorPalette.yellowColor,
            toggleDaySelection: true,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is PickerDateRange) {
                rangeStartDate = args.value.startDate;
                rangeEndDate = args.value.endDate;
              }
            },
          ),
          Row(children: [
            Flexible(
              flex: 1,
              child: ButtonWidget(
                title: "Hủy",
                ontap: () {
                  Navigator.of(context).pop([]);
                },
              ),
            ),

            SizedBox(
              width: kDefaultPadding,
            ),
            Flexible(
              flex: 1,
              child: ButtonWidget(
                title: "Xác nhận",
                ontap: () {
                  // print(rangeEndDate);
                  Navigator.of(context).pop([rangeStartDate, rangeEndDate]);
                },
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
