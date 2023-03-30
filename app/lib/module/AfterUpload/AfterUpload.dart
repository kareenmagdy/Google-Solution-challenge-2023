import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/const/const.dart';

class AfterUpload extends StatelessWidget {
  const AfterUpload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener: (BuildContext context, Object? state) {  },
      builder: (BuildContext context, state) {

        var cubit= AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Processing"),
            backgroundColor: Colors.blue,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Container(
                  width: double.infinity,
                  height: 350,
                  child: Image(image: FileImage(cubit.mriImage!),),
                ),



                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 20,top: 10),
                  child: Container(child: defaultButton(function: (){
                    cubit.classifyImage(image :cubit.mriImage,datetime:formattedDate, context: context );
                  }, text: "Start segmentation ")),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 20,top: 18),
                  child: Container(child: defaultButton(function: (){
                    //cubit.getResult(image: cubit.mriImage);



                    cubit.classifyImage(image :cubit.mriImage,datetime:formattedDate, context: context );
                  }, text: "Start prediction")),
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}
