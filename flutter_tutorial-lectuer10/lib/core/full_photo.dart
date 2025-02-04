import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'Helper/AppConstant/AppColorConstant.dart';

class FullPhoto extends StatelessWidget {
  final String url;

  const FullPhoto({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Full Photo',
          style: TextStyle(
              color: AppColor.primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.primaryColor),
      ),
      body: FullPhotoScreen(url: url),
    );
  }
}

class FullPhotoScreen extends StatefulWidget {
  final String url;

  const FullPhotoScreen({Key? key, required this.url}) : super(key: key);

  @override
  State createState() => FullPhotoScreenState();
}

class FullPhotoScreenState extends State<FullPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider: widget.url.isNotEmpty
            ? NetworkImage(widget.url)
            : const AssetImage("assets/images/placeholder.png") as ImageProvider,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
          );
        },
      ),
    );
  }
}
