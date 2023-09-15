import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp_php/components/valid.dart';

class CustTextFormSign extends StatelessWidget {
  final String? hint;
  final TextEditingController? myController;
  final String? Function(String?) valid;
  const CustTextFormSign({super.key, required this.hint, required this.myController, required this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: TextFormField(
          validator: valid,
        decoration: InputDecoration(
          hintText: hint,
            //   validator: (val) {
            //     return validInput(val!, 5, 20);
            //   },
          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10))
            )
        ),
      ),
    );
  }
}
