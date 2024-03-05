// ignore_for_file: use_build_context_synchronously, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_types_as_parameter_names, non_constant_identifier_names, unnecessary_brace_in_string_interps, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/authentaction/alert_dialog.dart';
import 'package:untitled/authentaction/custom_text_form_filed.dart';
import 'package:untitled/authentaction/register/register_screen.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/home/home_screen.dart';
import 'package:untitled/mytheme.dart';
import 'package:untitled/provider/app_config_provider.dart';

import '../../provider/authprovider.dart';

class Login extends StatefulWidget {
  static String routeName = "Login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController PasswordController = TextEditingController();

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Stack(
      children: [
        Container(
          color: provider.isDark()
              ? MyTheme.backgrounddark
              : MyTheme.backgroundlight,
          child: Image.asset(
            "assets/images/background.png",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Login",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: MyTheme.whiteColor),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * .23,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Welcome Back !",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomTextFormField(
                        labelText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (Text) {
                          if (Text!.trim().isEmpty) {
                            return "Please Enter Email";
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);
                          if (!emailValid) {
                            return "Please enter Vaild email";
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        obscuretext: true,
                        labelText: "Password",
                        keyboardType: TextInputType.number,
                        controller: PasswordController,
                        validator: (Text) {
                          if (Text!.trim().isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Forget Password ?",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(15)),
                            ),
                            onPressed: () {
                              login();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.arrow_right)
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(Register.routeName);
                            },
                            child: Text(
                              "Or Create Account",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontSize: 20),
                            )),
                      ),
                    ],
                  )),
            ]),
          ),
        ),
      ],
    );
  }

  void login() async {
    if (formkey.currentState!.validate() == true) {
      // show loading
      DialogUlits.showLoading(context: context, message: "Loading");
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: PasswordController.text,
        );
        var user = await Firebaseutils.readUserFromFirestore(credential.user?.uid ??"");
        if(user == null){
          return;
        }
         var authuser = Provider.of<AuthUsers>(context,listen: false);
        authuser.updateUsers(user);
        // hide loading
        DialogUlits.hideLoading(context);
        // show message
        DialogUlits.showMessage(
            context: context,
            message: "Login Successfully",
            posAction: "OK",
            posFunction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
// hide loading
          DialogUlits.hideLoading(context);
          // show message
          DialogUlits.showMessage(
              context: context,
              message:
                  "The supplied auth credential is incorrect, malformed or has expired.",
              posAction: "Ok",
              title: "Error");
        }
      } catch (e) {
        // hide loading
        DialogUlits.hideLoading(context);
        // show message
        DialogUlits.showMessage(
            context: context, message: "${e}", posAction: "Ok");
      }
    }
  }
}
