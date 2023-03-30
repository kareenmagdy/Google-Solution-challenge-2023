import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/model/MriModel/MriModel.dart';

import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/const/const.dart';
import '../uploadscreen/UploadScreen.dart';

class ResultName extends StatefulWidget {
  List<MriModel>? mriModel;
  PatientModel? patientModel;
  ResultName({Key? key, required this.mriModel,required this.patientModel}) : super(key: key);

  @override
  State<ResultName> createState() => _ResultNameState();
}

class _ResultNameState extends State<ResultName> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,Appstates>(
      listener:(context,state){
      },
      builder:(context,state){
        var cubit =AppCubit.get(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title:  Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "${widget.patientModel!.name!}",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              actions: [
                Column(
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 27,
                            backgroundColor: Colors.white,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(usermodel!.image!),
                            radius: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //buildStaticsItem(),
                const SizedBox(height: 20,),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>buildResultItem(context, widget.mriModel![index]),
                    separatorBuilder: (context,index)=>const SizedBox(height: 15,),
                    itemCount: widget.mriModel!.length
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(function: (){
                    nameController.text=widget.patientModel!.name!;
                    navigateTo(context, UploadScreen());
                  }, text: "Make other Mri"),
                )
              ],
            ),
          ),

        );
      } ,
    );
  }

}
