// import 'package:bizconnect/app/theme/colors.dart';
// import 'package:flutter/material.dart';

// class StaticCustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed;
//   final Color backgroundColor;
//   final double borderRadius;
//   final double height;
//   final double width;
//   final TextStyle textStyle;

//   const StaticCustomButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.backgroundColor = red,
//     this.borderRadius = 12.0,
//     this.height = 48.0,
//     this.width = double.infinity,
//     this.textStyle = const TextStyle(
//       color: Colors.white,
//       fontSize: 16,
//       fontWeight: FontWeight.w700,
//     ),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: TextButton(
//         onPressed: onPressed,
//         style: TextButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           backgroundColor: backgroundColor,
//         ),
//         child: Text(
//           text,
//           style: textStyle,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:bizconnect/app/theme/colors.dart';

class StaticCustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final double height;
  final double width;
  final TextStyle textStyle;

  const StaticCustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = red,
    this.borderRadius = 12.0,
    this.height = 48.0,
    this.width = double.infinity,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
  }) : super(key: key);

  @override
  State<StaticCustomButton> createState() => _StaticCustomButtonState();
}

class _StaticCustomButtonState extends State<StaticCustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        // widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: TextButton(
            onPressed: widget.onPressed,
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              backgroundColor: widget.backgroundColor,
            ),
            child: Text(
              widget.text,
              style: widget.textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
