import 'package:flutter/material.dart';

class CustomInkwell extends StatefulWidget {
  final BorderRadius borderRadius;
  final void Function()? onTap;
  final AnimationController? animationController;
  final Widget Function(bool hover) builder;

  const CustomInkwell({
    super.key,
    this.onTap,
    required this.builder,
    this.borderRadius = BorderRadius.zero,
    this.animationController,
  });

  @override
  State<CustomInkwell> createState() => _CustomInkwellState();
}

class _CustomInkwellState extends State<CustomInkwell> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        if (mounted) {
          setState(() {
            hover = true;
          });
        }
        widget.animationController?.forward();
      },
      onExit: (event) {
        if (mounted) {
          setState(() {
            hover = false;
          });
        }
        widget.animationController?.reverse();
      },
      child: InkWell(
        borderRadius: widget.borderRadius,
        onTap: widget.onTap,
        child: widget.builder(hover),
      ),
    );
  }
}
