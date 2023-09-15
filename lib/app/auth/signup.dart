import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:noteapp_php/components/crud.dart';
import 'package:noteapp_php/components/valid.dart';
import '../../constant/linkapi.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isLoading = false;

  GlobalKey<FormState> myKey = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

   Crud crud = Crud();
  // signUp() async {
  //   var response = await _crud.postRequest(linkServerName,
  //       {
  //         "username": usernameController.text,
  //         "email": emailController.text,
  //         "password": passwordController.text,
  //       });
  //   if(response['status'] == "success"){
  //     Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
  //   }else{
  //     print("SignUp Fail");
  //   }
  //   }

  signUp() async {
    if(myKey.currentState!.validate())
    {
      isLoading = true;
      setState(() { });
      var response = await crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      isLoading = false;
      setState(() { });
      if (response != null && response is Map && response.containsKey("status")) {
        if (response["status"] == "success") {
          print("SignUp Success");
          Navigator.of(context).pushNamedAndRemoveUntil("success", (route) => false);
        } else {
          print("SignUp Fail");
        }
      } else {
        print("Invalid or missing response format");
      }
    }

  }
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
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
                    TextFormField(
                      controller: username,
                      validator: (val)
                      {
                        return validInput(val!, 3, 20);
                      },
                      decoration: InputDecoration(
                          hintText: 'username',
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                      ),
                    ),
                    TextFormField(
                      controller: email,
                      validator: (val)
                      {
                        return validInput(val!, 5, 40);
                      },
                      decoration: InputDecoration(
                          hintText: 'email',
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                      ),
                    ),
                    TextFormField(
                      controller: password,
                      validator: (val)
                      {
                        return validInput(val!, 5, 20);
                      },
                      decoration: InputDecoration(
                          hintText: 'password',
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                      ),
                    ),
                    MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          horizontal: 70.w, vertical: 10.h),
                      onPressed: () async {
                        print(username.text);
                        print(email.text);
                        print(password.text);
                        await signUp();
                      },
                      child: const Text("Login"),
                    ),
                    Container(height: 5.h),
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('login');
                        },
                        child: Text("Login"))
                  ],
                ),
              )
            ],
          ),
        ));
    // ? const Center(
    //     child: CircularProgressIndicator(),
    //   )
    // : Container(
    //     padding: EdgeInsets.all(20),
    //     child: ListView(
    //       children: [
    //         Form(
    //           key: myKey,
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: EdgeInsets.only(bottom: 15.h),
    //                 child: SvgPicture.asset(
    //                   'assets/images/task.svg',
    //                   width: 200.w,
    //                   height: 200.h,
    //                 ),
    //               ),
    //               CustTextFormSign(
    //                 hint: "username",
    //                 myController: usernameController,
    //               ),
    //               CustTextFormSign(
    //                 hint: "email",
    //                 myController: emailController,
    //               ),
    //               CustTextFormSign(
    //                 hint: "password",
    //                 myController: passwordController,
    //               ),
    //               MaterialButton(
    //                 color: Colors.blue,
    //                 textColor: Colors.white,
    //                 padding: EdgeInsets.symmetric(
    //                     horizontal: 70.w, vertical: 10.h),
    //                 onPressed: () async {
    //                   await signUp();
    //                 },
    //                 child: Text("Login"),
    //               ),
    //               Container(height: 5.h),
    //               TextButton(
    //                   onPressed: () {
    //                     Navigator.of(context).pushNamed('login');
    //                   },
    //                   child: Text("Login"))
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   ));
  }
}

