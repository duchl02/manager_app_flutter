import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/representation/widgets/button_widget.dart';

import '../../core/constants/color_constants.dart';

class SelectRangeDateScreen extends StatefulWidget {
  SelectRangeDateScreen({
    super.key,
  });

  static const String routeName = "/select_range_date_screen";

  @override
  State<SelectRangeDateScreen> createState() => _SelectRangeDateScreenState();
}

class _SelectRangeDateScreenState extends State<SelectRangeDateScreen> {
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
        backgroundColor: ColorPalette.primaryColor,
        title: Text("Danh sách ngày check in"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
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
