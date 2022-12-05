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

  @override
  Widget build(BuildContext context) {
    return AppBarContainerWidget(
      titleString: "Select Date",
      child: Column(children: [
        SizedBox(
          height: kMediumPadding,
        ),
        SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,
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
        ButtonWidget(
          title: "Select",
          ontap: () {
            // print(rangeEndDate);
            Navigator.of(context).pop([rangeStartDate, rangeEndDate]);
          },
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        ButtonWidget(
          title: "Cancel",
          ontap: () {
            Navigator.of(context).pop([]);
          },
          opacity: ColorPalette.primaryColor.withOpacity(0.3),
        )
      ]),
    );
  }
}
