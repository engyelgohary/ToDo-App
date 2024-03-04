import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/authentaction/custom_text_form_filed.dart';
import 'package:untitled/mytheme.dart';
import 'package:untitled/provider/app_config_provider.dart';

class Register extends StatelessWidget {
  static String routeName = "Register";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController confimPasswordController = TextEditingController();
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
              "Create Account",
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
                  CustomTextFormField(
                    labelText: "User Name",
                    controller: nameController,
                    validator: (Text) {
                      if(Text!.isEmpty){
                        return "Please Enter Name";
                      }
                      return null;
                    },),
                  CustomTextFormField(
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                     validator: (Text) {
                      if(Text!.isEmpty){
                        return "Please Enter Email";
                      }
                          bool emailValid = 
                         RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                         .hasMatch(emailController.text);
                         if(!emailValid){
                          return "Please enter Vaild email";
                         }
                      return null;
                    },),
                  
                  CustomTextFormField(
                    labelText: "Password",
                    keyboardType: TextInputType.number,
                    controller: PasswordController,
                     validator: (Text) {
                      if(Text!.isEmpty){
                        return "Please Enter Password";
                      }
                      if(Text.length < 7){
                        return "Enter at least 6 numbers";
                      }
                      return null;
                    },),
                  CustomTextFormField(
                    labelText: "Confrim Password",
                    keyboardType: TextInputType.number,
                    controller: confimPasswordController,
                    validator: (Text) {
                      if(Text!.isEmpty){
                        return "Please Enter Confim Password";
                      }
                      if( Text != PasswordController.text){
                        return "Confrim Password dosen't match your Password";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      register();
                    }, 
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Create Account",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Icon(Icons.arrow_right)
                      ],
                    ) ),
                  )
                                ],
                              )),
            ]),
          ),
        ),
      ],
    );
  }
  void register (){
    if(formkey.currentState!.validate()==true){

    }
  }
}
