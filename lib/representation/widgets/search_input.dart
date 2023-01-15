import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/dismension_constants.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: _focusNode,
          // controller: controller,
          enabled: true,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                // color: ColorPalette.textWhite,
                size: 16,
              ),
            ),
            filled: true,
            // fillColor: ColorPalette.subTitleColor,
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
          // style: TextStyleCustom.normalSize,
          onChanged: widget.onChanged,
          onSubmitted: (String submitValue) {},
        ),
      ],
    );
  }
}
