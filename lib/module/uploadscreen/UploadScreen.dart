import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';

import 'package:brain_tumor/shared/component/component.dart';
import 'package:brain_tumor/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/homelayout/homeLayout.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen() : super();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, Appstates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var key = GlobalKey<FormState>();
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title: Padding(
                padding: const EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "UPLOAD MRI",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              backgroundColor: Colors.blue,
              centerTitle: true,
            ),
          ),
          body: SafeArea(
              child: Form(
                key: key,
                child: Container(
                  decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //     image: AssetImage("assets/picture/b1.png"),
                    //     fit: BoxFit.contain,
                    //     opacity: .2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child:SingleChildScrollView(
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 50,),
                          defaultFormField(
                              controller: nameController,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if(value!.isEmpty){
                                  return "please insert patient name";
                                }
                                return null;
                              },
                              label: "Enter Patient Name",
                              color: Colors.black),
                          SizedBox(height:15 ,),

                          defaultFormField(
                              controller: ageController,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if(value!.isEmpty){
                                  return "please insert patient age";
                                }
                                return null;
                              },
                              label: "Enter Patient Age",
                              color: Colors.black),
                          SizedBox(height:10 ,),
                          defaultFormField(
                              controller: iDController,
                              type: TextInputType.text,
                              validate: (String? value) {
                                if(value!.isEmpty){
                                  return "please insert patient age";
                                }
                                return null;
                              },
                              label: "Enter Patient ID",
                              color: Colors.black),


                          radio(),
                          Padding(
                            padding:
                            const EdgeInsetsDirectional.only(top: 20, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                if(key.currentState!.validate()){
                                  cubit.getImage(context);
                                }

                              },

                              child: Container(
                                width: double.infinity,
                                height: 230,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                ),
                                child: Center(
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(30),
                                          border: Border.all(color: Colors.black),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            // AppCubit.get(context).getImage();
                                            //cubit.getProfileImages();
                                            if(
                                            key.currentState!.validate()
                                            ){

                                            }

                                          },
                                          icon: const Icon(Icons.add),
                                          color: Colors.black,
                                        ))),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          defaultButton(function: (){
                            navigateTo(context,HomeScreen());
                          }, text: "Home")
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
