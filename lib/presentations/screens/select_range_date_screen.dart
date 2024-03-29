import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travel_app/core/constants/dismension_constants.dart';
import 'package:travel_app/presentations/widgets/button_widget.dart';

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
        // backgroundColor: ColorPalette.primaryColor,
        title: Text("Chọn thời gian nghỉ"),
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
                isCancel: true,
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
                isCancel: false,
                title: "Xác nhận",
                ontap: () {
                  rangeEndDate ??= rangeStartDate;
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
