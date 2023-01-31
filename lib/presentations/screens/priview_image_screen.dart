import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PreviewImageScreen extends StatefulWidget {
  PreviewImageScreen({super.key, this.img});
  var img;

  static const String routeName = "/preview_image_screen";

  @override
  State<PreviewImageScreen> createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: widget.img,
        child: PhotoView(
          imageProvider: NetworkImage(widget.img),
        ),
      ),
    );
  }
}
