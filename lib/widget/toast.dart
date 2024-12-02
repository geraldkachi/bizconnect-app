import 'package:flutter/material.dart';
import 'package:bizconnect/app/theme/colors.dart';
import 'package:bizconnect/service/toast_service.dart';

class Toast extends StatelessWidget {
  final String title;
  final String subTitle;
  final ToastType? type;

  const Toast(
      {Key? key, required this.title, required this.subTitle, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: type == ToastType.success ? green : red,
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(color: Colors.white, fontSize: 14.0)),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: 200.0,
                child: Text(subTitle,
                    style: const TextStyle(color: Colors.white, fontSize: 12.0)),
              ),
            ],
          ),
          InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
