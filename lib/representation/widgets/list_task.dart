import 'package:flutter/material.dart';

import '../../core/constants/text_style.dart';

class listTask extends StatelessWidget {
  const listTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Text("FixBug", style: TextStyleCustom.nomalTextPrimary),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text("Người tạo: "),
              Text("Nguyễn Văn Đức "),
              Spacer(),
              Text("Độ ưu tiên: ", style: TextStyleCustom.smallText),
              Text("1", style: TextStyleCustom.smallText),
              // Text("Ngày tạo: ", style: TextStyleCustom.smallText),
              // Text("23/12/2022", style: TextStyleCustom.smallText),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Text("Trạng thái : ", style: TextStyleCustom.smallText),
              Text("Coding", style: TextStyleCustom.smallText),
              Spacer(),
              // Text("Hoàn thành: "),
              // Text("25/12/2022 "),
              Text("Ngày tạo: ", style: TextStyleCustom.smallText),
              Text("23/12/2022", style: TextStyleCustom.smallText),
            ],
          )
        ]),
      ),
    );
  }
}
