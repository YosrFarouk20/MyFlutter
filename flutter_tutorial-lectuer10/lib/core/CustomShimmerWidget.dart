import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const CustomShimmerWidget.rectangular({
    Key? key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder(), super(key: key);

  const CustomShimmerWidget.circular({
    Key? key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const CircleBorder(), super(key: key);

  const CustomShimmerWidget.general({
    Key? key,
    this.width = double.infinity,
    required this.height,
    required this.shapeBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    period: const Duration(seconds: 2),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[400]!,
        shape: shapeBorder,
      ),
    ),
  );
}
