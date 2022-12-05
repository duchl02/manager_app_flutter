import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:travel_app/routes.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key, required RoomModel roomModel});

  static const String routeName = "check_out_screen";

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
