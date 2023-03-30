import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../model/response_data_model.dart';
import '../../shared/colors/colors.dart';
import '../../shared/component/component.dart';
import '../../shared/const/const.dart';
import '../uploadscreen/UploadScreen.dart';

class Recent extends StatelessWidget {
  const Recent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var cubit = AppCubit.get(context);
          return
            Scaffold(
                body: SingleChildScrollView(
                  child: BuildCondition(
                      condition: cubit.mriModels.isNotEmpty,
                      builder:(context)=> Padding(padding: EdgeInsets.all(50),child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 150,),
                          GestureDetector(
                            onTap: (){
                              navigateTo(context, UploadScreen());
                            },
                            child:     Container(
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  )),
                              child: Center(
                                child: Text("Upload MRI",style: TextStyle(color: Colors.white,fontSize: 20),),
                              ),
                            ),
                          ),
                          SizedBox(height: 100,),
                          GestureDetector(
                            onTap: (){
                              navigateTo(context,  Result());
                            },
                            child:     Container(
                              height: 40,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  )),
                              child: Center(
                                child: Text("previous data",style: TextStyle(color: Colors.white,fontSize: 20),),
                              ),
                            ),
                          ),



                        ],
                      ),),
                      fallback:(context)=>
                          Padding(padding: EdgeInsets.all(50),child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 150,),
                              GestureDetector(
                                onTap: (){
                                  navigateTo(context, UploadScreen());
                                },
                                child:     Container(
                                  height: 40,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Center(
                                    child: Text("Upload MRI",style: TextStyle(color: Colors.white,fontSize: 20),),
                                  ),
                                ),
                              ),
                              SizedBox(height: 100,),
                              GestureDetector(
                                onTap: (){
                                  navigateTo(context,  Result());
                                },
                                child:     Container(
                                  height: 40,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )),
                                  child: Center(
                                    child: Text("previous data",style: TextStyle(color: Colors.white,fontSize: 20),),
                                  ),
                                ),
                              ),



                            ],
                          ),)


                  ),
                )
            );
        });

  }
}
