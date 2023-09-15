import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/linkapi.dart';
import '../model/notes_model.dart';
import '../responsive.dart';

class CardNotes extends StatelessWidget {
  CardNotes(
      {super.key,
      this.ontap,
      required this.notesModel,
      required this.onDelete});

  NotesModel notesModel;
  final void Function()? ontap;
  void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Container(
          padding: EdgeInsets.only(bottom: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  // "assets/images/task.svg",
                  "$linkImageRoot/${notesModel.notesImage}",
                  // width: 80.w,
                  // width: Responsive.isDesktop(context) ? 20.h : 80.h,
                  // height: Responsive.isDesktop(context) ? 100.h : 80.h,
                  width: Responsive.isMobile(context) ? 20.h : 100.h,
                  height: Responsive.isMobile(context) ? 80.h : 150.h,
                  // height: 80.h,
                  fit: Responsive.isDesktop(context) ? BoxFit.cover : BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 2,
                child: ListTile(
                  title: Text("${notesModel.notesTitle}"),
                  subtitle: Text("${notesModel.notesContent}"),
                  trailing:
                      IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
