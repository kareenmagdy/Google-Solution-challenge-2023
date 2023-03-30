import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:brain_tumor/image_painter.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../model/MriModel/MriModel.dart';
import '../shared/const/const.dart';

class Details extends StatefulWidget {
  MriModel? model;
  //PatientModel? patientModel;
  Details({Key? key,required this.model}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final _imageKey = GlobalKey<ImagePainterState>();

    return BlocConsumer<AppCubit,Appstates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var cubit = AppCubit.get(context);
        return state is !GetUserLoading ? Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
            child: AppBar(
              leadingWidth: 50,
              title: const Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Text(
                  "Details",
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImagePainter.network("${widget.model!.image}", key: _imageKey
                    ,   scalable: true,
                    height: 300,
                    width: double.infinity,
                    initialStrokeWidth: 3,
                    textDelegate: DutchTextDelegate(),
                    initialColor: Colors.blue,
                    initialPaintMode: PaintMode.freeStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child:
                    Column(
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
                        // Row(
                        //   children: [
                        //     Text("Percentage: ",style: textStyle.copyWith(color:HexColor("#8A8A8A"),fontWeight: FontWeight.w400),),
                        //     // const SizedBox(width: 47,),
                        //     Text("${((cubit.confidence)!.toInt())}",style: textStyle.copyWith(color: cubit.resultColor(((cubit.confidence)!.toInt())),fontSize: 20)),
                        //   ],
                        // ),
                        const SizedBox(height: 20,),

                      ],
                    ),


                  ),
                ],
              ),
            ),
          ),
        ):const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class DutchTextDelegate implements TextDelegate {
  @override
  String get arrow => "Arrow";

  @override
  String get changeBrushSize => "changeBrushSize";

  @override
  String get changeColor => " changeColor";

  @override
  String get changeMode => "changeMode";

  @override
  String get circle => "circle";

  @override
  String get clearAllProgress => "clearAll";

  @override
  String get dashLine => "Dashline";

  @override
  String get done => "done";

  @override
  String get drawing => "free drawing";

  @override
  String get line => "line";

  @override
  String get noneZoom => "Geen / Zoom";

  @override
  String get rectangle => "rectangle";

  @override
  String get text => "text";

  @override
  String get undo => "ongedaan maken";
}
