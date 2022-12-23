import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
import '../../core/constants/text_style.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late TextEditingController valueController;
  @override
  void initState() {
    super.initState();
    valueController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          enabled: true,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.white,
                size: 16,
              ),
            ),
            filled: true,
            fillColor: ColorPalette.subTitleColor,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  kItemPadding,
                ),
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: kItemPadding),
          ),
          style: TextStyleCustom.normalSize,
          onChanged: (value) {
            setState(() {
              valueController.text = value;
            });
          },
          onSubmitted: (String submitValue) {},
        ),
      ],
    );
  }
}
