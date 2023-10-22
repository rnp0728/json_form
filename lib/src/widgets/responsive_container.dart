import 'package:flutter/material.dart';
import 'package:form_kit/form_kit.dart';

class MyResponsiveContainer extends StatefulWidget {
  final LayoutType layout;
  final double? widthX5;
  final double? widthX4;
  final double? widthX3;
  final double? widthX2;
  final double? widthX1;
  final double? widthByPercentage;
  final double? height;
  final double? heightByWidth;
  final EdgeInsets padding;
  final Widget? child;

  const MyResponsiveContainer({
    super.key,
    required this.layout,
    this.widthX5,
    this.widthX4,
    this.widthX3,
    this.widthX2,
    this.widthX1,
    this.widthByPercentage,
    this.height,
    this.heightByWidth,
    this.padding = EdgeInsets.zero,
    this.child,
  });

  @override
  State<MyResponsiveContainer> createState() => _MyResponsiveContainerState();
}

class _MyResponsiveContainerState extends State<MyResponsiveContainer> {
  @override
  Widget build(BuildContext context) {
    double width = 0;
    double? height = widget.height;
    if (widget.layout == LayoutType.x5) {
      width = widget.widthX5 ?? 1156;
    } else if (widget.layout == LayoutType.x4) {
      width = widget.widthX4 ?? 936;
    } else if (widget.layout == LayoutType.x3) {
      width = widget.widthX3 ?? 696;
    } else if (widget.layout == LayoutType.x2) {
      width = widget.widthX2 ?? 516;
    } else if (widget.layout == LayoutType.x1) {
      width = widget.widthX1 ?? MediaQuery.of(context).size.width;
    }
    if (widget.widthByPercentage != null) {
      width = width * (widget.widthByPercentage ?? 1);
    }
    if (widget.heightByWidth != null) {
      height = width * (widget.heightByWidth ?? 1);
    }
    return Container(
      height: height,
      width: width,
      padding: widget.padding,
      child: widget.child ?? Container(),
    );
  }
}
