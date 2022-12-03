

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAlertDialog({required BuildContext context, required Function() confirm}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        buttonPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          "title,",
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
        content: Container(
          constraints: BoxConstraints(minWidth: 100.w, maxHeight: 250.h),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Text(
             " body",
              style: TextStyle(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        actions: [
          MaterialButton(onPressed: (){},color: Colors.blue,)
        ],
      );
    },
  );
}
