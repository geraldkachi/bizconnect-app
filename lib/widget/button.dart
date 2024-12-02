// import 'package:bizconnect/app/theme/colors.dart';
// import 'package:flutter/material.dart';

// class Button extends StatelessWidget {
//   final String text;
//   final bool isLoading;
//   final VoidCallback? onPressed;
//   final Color backgroundColor;
//   final Color borderColor;
//   final double borderWidth;
//   final double borderRadius;
//   final double height;
//   final double width;
//   final TextStyle textStyle;

//   const Button({
//     super.key,
//     required this.text,
//     required this.isLoading,
//     required this.onPressed,
//     this.backgroundColor = red,
//     this.borderColor = Colors.transparent,
//     this.borderWidth = 0.0,
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
//         onPressed: isLoading ? null : onPressed,
//         style: TextButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//             side: BorderSide(
//               color: borderColor,
//               width: borderWidth,
//             ),
//           ),
//           backgroundColor: backgroundColor,
//         ),
//         child: isLoading
//             ? const SizedBox(
//                 width: 24,
//                 height: 24,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2.0,
//                 ),
//               )
//             : Text(
//                 text,
//                 style: textStyle,
//               ),
//       ),
//     );
//   }
// }

 



import 'package:flutter/material.dart';
import 'package:bizconnect/app/theme/colors.dart';

class Button extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color borderColor;
  final double borderWidth;
  final Color? buttonColor;
  final Color textColor;
  final double height;
  final double width;
  final double borderRadius;
  final Color backgroundColor;
  final TextStyle textStyle;

  const Button({
    super.key,
    required this.text,
    required this.isLoading,
    required this.onPressed,
    this.buttonColor = red,
    this.textColor = Colors.white,
    this.backgroundColor = red,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0.0,
    this.borderRadius = 12.0,
    this.height = 48.0,
    this.width = double.infinity,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    // ), required this.buttonColor, required this.textColor,
    ), 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: borderColor,
              width: borderWidth,
            ),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.0,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
