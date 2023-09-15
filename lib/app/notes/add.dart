import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp_php/components/crud.dart';
import 'package:noteapp_php/components/custom_text_form.dart';
import 'package:noteapp_php/main.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/valid.dart';
import '../../constant/linkapi.dart';

class AddNotes extends StatefulWidget {
  AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  File? myfile;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  addNotes() async {
    if (myfile == null)
      return AwesomeDialog(
          context: context,
          title: "Warning",
          body: Text("Please Add Image to Note"))
        ..show();
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestWithFile(
          linkAddNotes,
          {
            "title": title.text,
            "content": content.text,
            "id": sharedPref.getString("id"),
          },
          myfile!);
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        print("'''''''''''''''''${title.text}");
        Navigator.of(context).pushReplacementNamed("home");
      } else {
        print("'''''''''''''''''ERRORRRRRRRRRRRRRR");
      }
      // return response;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Notes"),
        ),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formState,
                  child: ListView(
                    children: [
                      // CustTextFormSign(hint: 'title', myController: title,),
                      TextFormField(
                        controller: title,
                        validator: (val) {
                          return validInput(val!, 1, 40);
                        },
                        decoration: InputDecoration(
                            hintText: 'title',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 10.w),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      TextFormField(
                        controller: content,
                        validator: (val) {
                          return validInput(val!, 10, 100);
                        },
                        decoration: InputDecoration(
                            hintText: 'content',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 10.w),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                      ),
                      // CustTextFormSign(hint: 'content', myController: content),
                      SizedBox(
                        height: 20.h,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 250.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Please Choose Image",
                                          style: TextStyle(fontSize: 22.sp),
                                        ),
                                      ),
                                      InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "From Gallery",
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                        ),
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          Navigator.of(context).pop();
                                          myfile = File(xfile!.path);
                                          setState(() {});
                                        },
                                      ),
                                      InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "From Camera",
                                            style: TextStyle(fontSize: 16.sp),
                                          ),
                                        ),
                                        onTap: () async {
                                          XFile? xfile = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          Navigator.of(context).pop();
                                          myfile = File(xfile!.path);
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Text(
                          "Choose Image",
                        ),
                        color: myfile == null ? Colors.blue : Colors.green,
                        textColor: Colors.white,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          await addNotes();
                        },
                        child: Text(
                          "Add",
                        ),
                        color: Colors.blue,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
