import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/image_painter.dart';
import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:brain_tumor/module/uploadscreen/UploadScreen.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../shared/const/const.dart';

class ProcessingDetails extends StatelessWidget {
  const ProcessingDetails({Key? key}) : super(key: key);

  @override
  Widget build( context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        final _imageKey = GlobalKey<ImagePainterState>();
        var cubit = AppCubit.get(context);
        return  Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title: const Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "YOUR PROCESS",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              actions: [

              ],
              backgroundColor: Colors.blue,
              centerTitle: true,),
          ),
          body: state is !ClassificationLoading ?Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: 130,),
                  Container(
                    width: double.infinity,

                    child:   Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [

                          Row(
                            children: [
                              Text("Name : ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400,fontSize: 25),),
                              Text("${nameController.text}  ",style: textStyle.copyWith(color: Colors.blue,fontSize: 20))
                            ],
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              Text("Age: ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400,fontSize: 25),),
                              Text("${ageController.text}  ",style: textStyle.copyWith(color: Colors.blue,fontSize: 20))
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Text("ID : ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400,fontSize: 25),),
                              Text("${iDController.text}  ",style: textStyle.copyWith(color: Colors.blue,fontSize: 20))
                            ],
                          ),
                          const SizedBox(height: 15,),

                          Row(
                            children: [
                              Text("Date : ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400,fontSize: 25),),
                              Text("$formattedDate  ",style: textStyle.copyWith(color:Colors.blue,fontSize: 20),),
                            ],
                          ),


                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              Text("TUMOR TYPE: ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400,fontSize: 25),),
                              Text("${cubit.processResult}",style: textStyle.copyWith(color: Colors.blue,fontSize: 15)),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              Text("GENDER: ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400,fontSize: 25),),
                              Text("male",style: textStyle.copyWith(color: Colors.blue,fontSize: 20)),
                            ],
                          ),

                          const SizedBox(height: 20,),

                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 130,),
                  defaultButton(function: (){
                    navigateTo(context, UploadScreen());
                  }, text: "Finish")
                ],
              ),
            ),
          ):const Center(child: CircularProgressIndicator(color: Colors.blue  ,)),
        );
      },
    );
  }


}

