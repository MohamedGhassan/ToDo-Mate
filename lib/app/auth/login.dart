import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteapp_php/components/crud.dart';
import 'package:noteapp_php/constant/linkapi.dart';
import 'package:noteapp_php/main.dart';
import '../../components/valid.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  GlobalKey<FormState> myKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Crud crud = Crud();

  login() async {
    if (myKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(
          linkLogin, {"email": email.text, "password": password.text});
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        sharedPref.setString('id', response['data']['id'].toString());
        sharedPref.setString('username', response['data']['username']);
        sharedPref.setString('email', response['data']['email']);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
            context: context,
            title: "تنبيه",
            // btnCancel: Text("Cansel"),
            body: Text("ألبريد او كلمة المرور خطأ او الحساب غير موجود"))
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20),
          child: isLoading == true
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : ListView(
            children: [
              Form(
                key: myKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: SvgPicture.asset(
                        'assets/images/task.svg',
                        width: 200.w,
                        height: 200.h,
                      ),
                    ),
                    // CustTextFormSign(
                    //   hint: "email", myController: email, valid: (val) {
                    //   return validInput(val!, 3, 20);
                    // },),
                    // CustTextFormSign(
                    //   hint: "password", myController: password, valid:(val)
                    // {
                    //   return validInput(val!, 5, 40);
                    // }),
                    TextFormField(
                      controller: email,
                      validator: (val) {
                        return validInput(val!, 5, 40);
                      },
                      decoration: InputDecoration(
                          hintText: 'email',

                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 10.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    TextFormField(
                      controller: password,
                      validator: (val) {
                        return validInput(val!, 5, 20);
                      },
                      decoration: InputDecoration(
                          hintText: 'password',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 10.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 10.h),
                      onPressed: () async {
                        await login();
                      },
                      child: Text("Login"),
                    ),
                    Container(height: 5.h),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('signup');
                        },
                        child: Text("Sign up"))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
