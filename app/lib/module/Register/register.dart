import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:brain_tumor/module/Login/loginCubit/cubit/cubit.dart';
import 'package:brain_tumor/module/Login/loginCubit/state/states.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/component/component.dart';
import '../Login/login.dart';
class Register extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var rePasswordController=TextEditingController();
  var nameController=TextEditingController();
  var jobController=TextEditingController();

  Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit,LoginStates>(
      listener: (context,state){
        if(state is GetUserSuccess){
          navigateAndFinish(context, HomeScreen());
        }
      },
      builder: (context,state){
        final cubit  =  LoginCubit.get(context);
        String? gender=genderM;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 81,horizontal: 20),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      //text
                      Center(
                        child: Text("Sign Up"
                            ,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.grey)
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Container(
                        child: defaultFormField(
                            color: Colors.black,

                            controller:nameController,
                            type: TextInputType.name,
                            validate: (String? value){
                              if(value!.isEmpty){
                                return 'please Enter your  name ';
                              }
                              return null;
                            },
                            label: 'Name',
                            prefix: Icons.person
                        ),
                      ),
                      const SizedBox(height: 15,),
                      //email
                      Container(
                        child: defaultFormField(
                            color: cubit.errorMessage!=null? HexColor("#Da1d19"):Colors.black,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value){
                              if(value!.isEmpty){
                                cubit.Regerror();
                                return 'please Enter your Email Adress ';
                              }
                              else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                                cubit.Regerror();
                                return ("Please Enter a valid email");
                              }

                            },
                            label: 'EmailAdress',
                            prefix: Icons.email_outlined
                        ),
                      ),
                      if (cubit.errorMessage!=null)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(top: 3,start: 11),
                          child: Text(cubit.errorMessage!,style:  TextStyle(color: HexColor("#Da1d19"),fontSize: 12),),
                        ),
                      const SizedBox(height: 20,),

                      Container(
                        child: defaultFormField(
                          color: Colors.black,
                          controller:jobController,
                          type: TextInputType.text,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please Enter your number ';
                            }
                            return null;
                          },
                          label: 'phone number',
                        ),
                      ),
                      //password
                      const SizedBox(height: 20,),
                      //button
                      Container(
                        child: defaultFormField(
                          color: Colors.black,
                          controller: passwordController,
                          onSubmit: (value){
                          },
                          type: TextInputType.visiblePassword,
                          isPassword: LoginCubit.get(context).isPassword,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please Enter your password ';
                            }
                            if(value.length <6){
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                          label: 'password',
                          prefix: Icons.lock_open_outlined,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: (){
                            LoginCubit.get(context).visiblePass();
                          },

                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        child: defaultFormField(
                          color: Colors.black,
                          controller: rePasswordController,
                          onSubmit: (value){
                          },
                          type: TextInputType.visiblePassword,
                          isPassword: LoginCubit.get(context).isPassword,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'please confirm your password ';
                            }
                            if(value != passwordController.text){
                              return 'Password is not matching';
                            }
                            return null;
                          },
                          label: 'Confirm Password',
                          prefix: Icons.lock_open_outlined,
                          suffix: LoginCubit.get(context).suffix,
                          suffixPressed: (){
                            LoginCubit.get(context).visiblePass();
                          },

                        ),
                      ),
                      const SizedBox(height: 20,),


                      const SizedBox(height: 15,),
                      // radio(),
                      //checkbox(),
                      SizedBox(height: 15,),
                      BuildCondition(
                        condition: state is! LoginLoading,
                        builder:(context)=> defaultButton(function: (){
                          cubit.ChangeError();
                          if(formkey.currentState!.validate()){

                            LoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }


                        }, text: "SignUp"),


                        fallback:(context)=> const Center(child: CircularProgressIndicator(color: Colors.blue,)),),

                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          //Reg now text Button
                          Container(
                            child: defultTextButton(text: "Login"
                                , function: (){
                                  navigateTo(context, LoginScreen());
                                }),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
