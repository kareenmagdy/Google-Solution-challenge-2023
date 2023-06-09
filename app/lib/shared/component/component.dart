import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/model/MriModel/MriModel.dart';
import 'package:brain_tumor/module/Login/loginCubit/cubit/cubit.dart';
import 'package:brain_tumor/module/Result/name%20result.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../cubit/states/states.dart';
import '../../module/ImageDetails.dart';
import '../../module/Login/loginCubit/state/states.dart';
import '../colors/colors.dart';
import '../const/const.dart';
// ignore: avoid_types_as_parameter_names
void navigateTo(context,Widget)=>Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>Widget),
);
void navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context)=>Widget)
    , (route) => false);
double divider=80;
// Widget myAppBar({
//  required var PageNum,
//   double raduis=30
// })=>Container(
//   width: double.infinity,
//   height: 80,
//   color: defultcolor,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       CircleAvatar(
//         backgroundColor: PageNum==1? primaryColor:Colors.white,
//         radius: raduis,
//         child: const Text("1",style: TextStyle(fontSize: 24),),
//           foregroundColor:PageNum==1? Colors.white: defultcolor
//
//       ),
//
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//           width:divider ,
//           height: 3,
//           color: Colors.white,
//         ),
//       ),
//       CircleAvatar(
//         backgroundColor: PageNum==2? primaryColor:Colors.white,
//         radius: raduis,
//         child: const Text("2",style: TextStyle(fontSize: 24),),
//         foregroundColor:PageNum==2? Colors.white: defultcolor
//         ,),
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//           width: divider,
//           height: 3,
//           color: Colors.white,
//         ),
//       ),
//       CircleAvatar(
//         backgroundColor: PageNum==3? primaryColor:Colors.white,
//         radius: raduis,
//         child: const Text("3",style: TextStyle(fontSize: 24),),
//         foregroundColor:PageNum==3? Colors.white: defultcolor
//         ,),
//     ],
//   ),
// );

// Widget myBtn({
//   required  onPressed,
//   required var text,
//   double height=60
// })=>MaterialButton(
// disabledColor: Colors.grey,
//   disabledTextColor: textcolor,
//   onPressed: onPressed,
//   minWidth: 202,
//   child: Text("$text",style: TextStyle(color: textcolor,
//       fontSize: 16,
//   fontWeight: FontWeight.w700),),
//   color: maincolor,
//   height: height,);

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double height=35,
  double radius = 4.0,
  required  Function() function,
  @required  text,


}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text ,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: HexColor("#707070"),
      ),
    );


Widget LogutButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double height=35,
  double radius = 4.0,
  required  Function() function,
  @required  text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(
            text ,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
            SizedBox(width: 10,),
            Icon(Icons.logout,color: Colors.white,),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: HexColor("#F41D1D"),
      ),
    );

Widget defultTextButton({
  @required String? text,
  @required function}
    )=> TextButton(onPressed: function, child:Text(text!,style:
TextStyle(color: Colors.blue,decoration: TextDecoration.none,fontSize: 16),));


Widget defaultFormField(
    {
      required TextEditingController controller,
      required TextInputType? type,
      onSubmit,
      onChange,
      onTap,
      double width= double.infinity,
      bool isPassword = false,
      required  validate,
      required String label,
      IconData? prefix,
      IconData? suffix,
      suffixPressed,
      bool isClickable = true,
      required Color color,
    }) =>
    Container(
      width: width,
      child: TextFormField(
        style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400,),
        textAlign: TextAlign.start,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted:onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsetsDirectional.only(start: 12),
            fillColor: Colors.white.withOpacity(0.08),
            labelText: label,
            suffixIcon: suffix != null
                ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(
                suffix,
                color: Colors.grey,

              ),
            )
                : null,
            border:  OutlineInputBorder(

              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color:Colors.blue)
            ),
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),

              borderSide: BorderSide(color: Colors.blue),
            ),
            labelStyle:  TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400)
        ),
      ),
    );
Widget myDivider()=>Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey,
);


void showToast(context, {
  required String message,
  required ToastStates state,
}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates{success, error, warning}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.yellow;
      break;
  }
  return color;
}
String genderM="Male";
class radio extends StatefulWidget {


  @override
  State<radio> createState() => _radioState();
}

class _radioState extends State<radio> {

  Object? radioValue=1;
  String? genderM;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text("Gender",style: TextStyle(color:Colors.blue,fontSize: 16,fontWeight: FontWeight.w700),),
        const SizedBox(width: 10,),
        Radio(
          activeColor: Colors.blue,
          value: 1,
          groupValue: radioValue,
          onChanged: (value){
            setState((){
              radioValue=value;
              genderM="Male";
              print(genderM);
            });
          },
        ),

        Text("Male",style: TextStyle(color: HexColor("#1A1B1C"),fontSize: 15,fontWeight: FontWeight.w400),),
        SizedBox(width: 30,),
        Radio(
            value: 2,
            groupValue: radioValue,
            activeColor: HexColor("#009E82"),
            onChanged:(value){
              setState((){
                radioValue=value;
                genderM="Female";
                print(genderM);
              });
            }
        ),
        Text("Female",style: TextStyle(color: HexColor("#1A1B1C"),fontSize: 15,fontWeight: FontWeight.w400),),
      ],
    );
  }
}
class checkbox extends StatefulWidget {
  const checkbox({Key? key}) : super(key: key);

  @override
  State<checkbox> createState() => _checkboxState();
}
bool checkedValue=false;
class _checkboxState extends State<checkbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          child: Checkbox(
              value: checkedValue,
              onChanged: (value) {
                setState(() {
                  LoginCubit.get(context).changeButtom();
                  checkedValue = value!;
                  print(checkedValue);
                });
              }),
        ),
        Text("Accept",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        defultTextButton(text: "Terms", function: (){}),
        Text("And",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
        defultTextButton(text: "privacy policy", function: (){}),

      ],
    );
  }
}
Widget buildResultItem(context,  MriModel model){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        // if(usermodel!.uId == patientModel.dId)
        Expanded(
          child: Container(
            height: 137,
            decoration: BoxDecoration(
              borderRadius:const BorderRadiusDirectional.only(topStart:Radius.circular(4),bottomStart: Radius.circular(5)) ,
              border: Border.all(color:HexColor("#D9D9D9"),width: 1 ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Name : " ,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 14,fontWeight: FontWeight.w400),),
                      const SizedBox(width: 10,),
                      Text("${model.patientName}",style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 16,fontWeight: FontWeight.w700 ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 20,start: 10),
                  child: Row(
                    children: [
                      Text("Date : " ,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 14,fontWeight: FontWeight.w400),),
                      const SizedBox(width: 10,),
                      Text(model.date!,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 16,fontWeight: FontWeight.w700 ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButton(function: (){
                        navigateTo(context, Details(model: model));
                      }, text: "Details",width: 100,height: 25),
                      // const Spacer(),
                      // InkWell(
                      //   onTap: (){
                      //     if(model.isSaved == true){
                      //       AppCubit.get(context).upadteSave(
                      //           datetime: model.date,
                      //           save: false,
                      //           name: model.patientName,
                      //           result: model.result,
                      //           confidence: model.confidence,
                      //           image: model.image,
                      //           mrid: model.mrId
                      //       );
                      //     }else{
                      //       AppCubit.get(context).upadteSave(
                      //           datetime: model.date,
                      //           save: true,
                      //           name: model.patientName,
                      //           result: model.result,
                      //           confidence: model.confidence,
                      //           image: model.image,
                      //           mrid: model.mrId
                      //       );
                      //     }
                      //
                      //   },
                      //   child: SizedBox(
                      //       height: 35,
                      //       child: model.isSaved!?  savedi : saved),
                      // )
                      // IconButton(onPressed: (){
                      //   print("s");
                      // }, icon: saved,iconSize: 3,)
                    ],
                  ),
                ),
              ],
            ),
          ),flex: 2,),
        // if(usermodel!.uId == patientModel.dId)
        //   Expanded(child: Container(
        //   height: 137,
        //   decoration: BoxDecoration(
        //     //borderRadius: BorderRadiusDirectional.only(topEnd:Radius.circular(4),bottomEnd: Radius.circular(5)) ,
        //     border: BorderDirectional(
        //       end: BorderSide(color:HexColor("#D9D9D9"),width: 1),
        //       bottom: BorderSide(color:HexColor("#D9D9D9"),width: 1),
        //       top: BorderSide(color:HexColor("#D9D9D9"),width: 1),
        //     ),
        //   ),
        //   child: Center(child: Text("${model.confidence!.floor()}%",style: TextStyle(color: AppCubit.get(context).resultColor(model.confidence!.floor()),fontWeight: FontWeight.w700,fontSize: 35),)),
        // ),
        // ),
      ],
    ),
  );
}


Widget buildResentItem(context,  MriModel model, PatientModel patientModel){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        if(usermodel!.uId == patientModel.dId)
          Expanded(
            child: Container(
              height: 137,
              decoration: BoxDecoration(
                borderRadius:const BorderRadiusDirectional.only(topStart:Radius.circular(4),bottomStart: Radius.circular(5)) ,
                border: Border.all(color:HexColor("#D9D9D9"),width: 1 ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Name : " ,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 14,fontWeight: FontWeight.w400),),
                        const SizedBox(width: 10,),
                        Text("${patientModel.name}",style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 16,fontWeight: FontWeight.w700 ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 20,start: 10),
                    child: Row(
                      children: [
                        Text("Date : " ,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 14,fontWeight: FontWeight.w400),),
                        const SizedBox(width: 10,),
                        Text(model.date!,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 16,fontWeight: FontWeight.w700 ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: Row(
                      children: [
                        defaultButton(function: (){
                          navigateTo(context, Details(model: model));
                        }, text: "Details",width: 100,height: 25),
                        const Spacer(),
                        InkWell(
                          onTap: (){
                            if(model.isSaved == true){
                              AppCubit.get(context).upadteSave(
                                  datetime: model.date,
                                  save: false,
                                  name: model.patientName,
                                  result: model.result,
                                  confidence: model.confidence,
                                  image: model.image,
                                  mrid: model.mrId
                              );
                            }else{
                              AppCubit.get(context).upadteSave(
                                  datetime: model.date,
                                  save: true,
                                  name: model.patientName,
                                  result: model.result,
                                  confidence: model.confidence,
                                  image: model.image,
                                  mrid: model.mrId
                              );
                            }
                          },
                          child: SizedBox(
                              height: 35,
                              child:  model.isSaved!?savedi : saved),
                        )
                        // IconButton(onPressed: (){
                        //   print("s");
                        // }, icon: saved,iconSize: 3,)
                      ],
                    ),
                  ),
                ],
              ),
            ),flex: 2,),
        if(usermodel!.uId == patientModel.dId)
          Expanded(child: Container(
            height: 137,
            decoration: BoxDecoration(
              //borderRadius: BorderRadiusDirectional.only(topEnd:Radius.circular(4),bottomEnd: Radius.circular(5)) ,
              border: BorderDirectional(
                end: BorderSide(color:HexColor("#D9D9D9"),width: 1),
                bottom: BorderSide(color:HexColor("#D9D9D9"),width: 1),
                top: BorderSide(color:HexColor("#D9D9D9"),width: 1),
              ),
            ),
            child: Center(child: Text("${model.confidence!.floor()}%",style: TextStyle(color: AppCubit.get(context).resultColor(model.confidence!.floor()),fontWeight: FontWeight.w700,fontSize: 35),)),
          ),
          ),
      ],
    ),
  );
}
Widget buildSavedItem(context,state, MriModel model){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        // if(usermodel!.uId == patientModel.dId)
        // if(model.isSaved!)
        Expanded(
          child: Container(
            height: 137,
            decoration: BoxDecoration(
              borderRadius:const BorderRadiusDirectional.only(topStart:Radius.circular(4),bottomStart: Radius.circular(5)) ,
              border: Border.all(color:HexColor("#D9D9D9"),width: 1 ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("Name : " ,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 14,fontWeight: FontWeight.w400),),
                      const SizedBox(width: 10,),
                      Text("${model.patientName}",style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 16,fontWeight: FontWeight.w700 ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 5,bottom: 20,start: 10),
                  child: Row(
                    children: [
                      Text("Date : " ,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 14,fontWeight: FontWeight.w400),),
                      const SizedBox(width: 10,),
                      Text("${model.date}",style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 16,fontWeight: FontWeight.w700 ),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Row(
                    children: [
                      defaultButton(function: (){
                        navigateTo(context, Details(model: model));
                      }, text: "Details",width: 100,height: 25),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          if(model.isSaved == true){
                            AppCubit.get(context).upadteSave(
                                datetime: model.date,
                                save: false,
                                name: model.patientName,
                                result: model.result,
                                confidence: model.confidence,
                                image: model.image,
                                mrid: model.mrId
                            );
                          }else{
                            AppCubit.get(context).upadteSave(
                                datetime: model.date,
                                save: true,
                                name: model.patientName,
                                result: model.result,
                                confidence: model.confidence,
                                image: model.image,
                                mrid: model.mrId
                            );
                          }
                        },
                        child: SizedBox(
                            height: 35,
                            child:  model.isSaved!?savedi : saved),
                      ),

                      // IconButton(onPressed: (){
                      //   print("s");
                      // }, icon: saved,iconSize: 3,)
                    ],
                  ),
                ),
              ],
            ),
          ),flex: 2,),
        // if(usermodel!.uId == patientModel.dId)
        // // if(model.isSaved!)
        Expanded(child: Container(
          height: 137,
          decoration: BoxDecoration(
            //borderRadius: BorderRadiusDirectional.only(topEnd:Radius.circular(4),bottomEnd: Radius.circular(5)) ,
            border: BorderDirectional(
              end: BorderSide(color:HexColor("#D9D9D9"),width: 1),
              bottom: BorderSide(color:HexColor("#D9D9D9"),width: 1),
              top: BorderSide(color:HexColor("#D9D9D9"),width: 1),
            ),
          ),
          child: Center(child: Text("${model.confidence!.floor()}%",style: TextStyle(color: AppCubit.get(context).resultColor(model.confidence!.floor()),fontWeight: FontWeight.w700,fontSize: 35),)),
        ),
        ),
      ],
    ),
  );
}
Widget buildFolderItem(context,index, PatientModel model, MriModel mriModel){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      children: [
        if(usermodel!.uId == model.dId)
          Expanded(
            child: Container(
              height: 137,
              decoration: BoxDecoration(
                borderRadius:const BorderRadiusDirectional.only(topStart:Radius.circular(4),bottomStart: Radius.circular(5)) ,
                border: Border.all(color:HexColor("#D9D9D9"),width: 1 ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text("Name : " ,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 14,fontWeight: FontWeight.w400),),
                        const SizedBox(width: 10,),
                        Text("${model.name}",style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 16,fontWeight: FontWeight.w700 ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 5,bottom: 20,start: 10),
                    child: Row(
                      children: [
                        Text("Date : " ,style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 14,fontWeight: FontWeight.w400),),
                        const SizedBox(width: 10,),
                        Text("${mriModel.date}",style: TextStyle(color:HexColor("#8A8A8A"),fontSize: 16,fontWeight: FontWeight.w700 ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(function: (){
                          print(mriModel);
                          print(model.name);
                          print(AppCubit.get(context).mriDetails[model.name]!);

                          navigateTo(context, ResultName(mriModel: AppCubit.get(context).mriDetails[model.name],patientModel:model,));
                        }, text: "Open Folder",width: 130,height: 25),
                      ],
                    ),
                  ),
                ],
              ),
            ),flex: 2,),
        // if(usermodel!.uId == model.dId)
        //   Expanded(child: Container(
        //   height: 137,
        //   decoration: BoxDecoration(
        //     //borderRadius: BorderRadiusDirectional.only(topEnd:Radius.circular(4),bottomEnd: Radius.circular(5)) ,
        //     border: BorderDirectional(
        //       end: BorderSide(color:HexColor("#D9D9D9"),width: 1),
        //       bottom: BorderSide(color:HexColor("#D9D9D9"),width: 1),
        //       top: BorderSide(color:HexColor("#D9D9D9"),width: 1),
        //     ),
        //   ),
        //   child: Center(child: Text("${mriModel.result}",style: TextStyle(color: resultColor(mriModel.result) ,fontWeight: FontWeight.w700,fontSize: 20),)),
        // ),
        // ),
      ],
    ),
  );
}
Widget buildStaticsItem ()=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    width: double.infinity,
    height: 260,
    decoration: BoxDecoration(
      // boxShadow:const [
      //   BoxShadow(
      //       color: Colors.black,
      //       blurRadius: 50.0, // soften the shadow
      //       spreadRadius: 2.0, //extend the shadow
      //       offset: Offset(
      //         0.0, // Move to right 10  horizontally
      //         10.0, // M
      //       ) )],
        color: HexColor("#F5FBFA"),
        borderRadius: BorderRadius.circular(4)),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              SizedBox(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 51,
                      width: 51,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        backgroundColor: HexColor("#D8D8D8"),
                        color:HexColor("#F41D1D") ,
                        value:Positive/100  ,
                      ),
                    ),
                    Text('${Positive.toInt()}%',style: TextStyle(
                        fontSize: 14,
                        color: HexColor("#F41D1D")
                    ),),
                  ],
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(height: 15,),
              // SizedBox(
              //   child: Stack(
              //     children: [
              //       SizedBox(
              //         height: 51,
              //         width: 51,
              //         child: CircularProgressIndicator(
              //           strokeWidth: 4,
              //           backgroundColor: HexColor("#D8D8D8"),
              //           color:HexColor("#F4AB1D") ,
              //           value:.26  ,
              //         ),
              //       ),
              //       Text("26%",style: TextStyle(
              //           fontSize: 14,
              //           color: HexColor("#F4AB1D")
              //       ),),
              //     ],
              //     alignment: Alignment.center,
              //   ),
              // ),
              const SizedBox(height: 30,),
              SizedBox(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 51,
                      width: 51,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        backgroundColor: HexColor("#D8D8D8"),
                        color:HexColor("#009E82") ,
                        value:Negaitve/100  ,
                      ),
                    ),
                    Text("${Negaitve.toInt()}%",style: TextStyle(
                        fontSize: 14,
                        color: HexColor("#009E82")
                    ),),
                  ],
                  alignment: Alignment.center,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 19,),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Container(width: 270,height: 212,
            child:BarChart(BarChartData(
                borderData: FlBorderData(
                    border: const Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide(width: 2),
                      bottom: BorderSide(width: 2),
                    )),
                maxY: 100,
                groupsSpace: 10,
                barGroups: [
                  BarChartGroupData(x: 1, barRods: [
                    BarChartRodData( width: 20, color: maincolor, toY:Negaitve),
                  ]),
                  BarChartGroupData(x: 2, barRods: [
                    BarChartRodData(width: 20, color: Colors.red, toY: Positive, ),
                  ]),

                ])),
          ),
        )
      ],
    ),
  ),
);
dynamic Negaitve;
dynamic Positive;

class Changepassword extends StatelessWidget {
  const Changepassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController=TextEditingController();
    var newPasswordController=TextEditingController();
    var RenewPasswordController=TextEditingController();
    var formkey=GlobalKey<FormState>();
    return BlocConsumer<LoginCubit,LoginStates>(
      listener:(context,state){
        if(state is ChangePassSuccessState){
          showToast(context, message: "Password was Changed", state: ToastStates.success);
          passwordController.text='';
          newPasswordController.text='';
          RenewPasswordController.text='';
        }
        if(state is ChangePassErrorState){
          showToast(context, message: "Password was wrong", state: ToastStates.error);

        }
      } ,
      builder:(context,state)=> Form(
        key: formkey,
        child: Column(
          children: [
            Container(
              child: defaultFormField(
                color: borderColor,
                controller: passwordController,
                type: TextInputType.visiblePassword,
                isPassword: LoginCubit.get(context).isPassword,
                validate: (String? value){
                  if(value!.isEmpty){
                    return 'please Enter your password ';
                  }
                  return null;
                },
                label: 'Old password',
                suffix: LoginCubit.get(context).suffix,
                suffixPressed:(){ LoginCubit.get(context).visiblePass();},
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: defaultFormField(
                color: borderColor,
                controller: newPasswordController,
                type: TextInputType.visiblePassword,
                isPassword: LoginCubit.get(context).isPassword,
                validate: (String? value){
                  if(value!.isEmpty){
                    return 'please Enter your New password ';
                  }
                  if(newPasswordController.text!=RenewPasswordController.text){
                    return "Passwords is not match";
                  }
                  if(value.length<6){
                    return "password cant be less than 6 digit";
                  }
                  return null;
                },
                label: 'New Password',
                onSubmit: (value){
                  print("s");
                },
                suffix: LoginCubit.get(context).suffix,
                suffixPressed:(){ LoginCubit.get(context).visiblePass();},
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: defaultFormField(
                color: borderColor,
                controller: RenewPasswordController,
                type: TextInputType.visiblePassword,
                isPassword: LoginCubit.get(context).isPassword,
                validate: (String? value){
                  if(value!.isEmpty){
                    return 'please Enter your New password ';
                  }
                  if(newPasswordController.text!=RenewPasswordController.text){
                    return "Passwords is not match";
                  }
                  return null;
                },
                label: ' Confirm Password',
                onSubmit: (value){
                  print("s");
                },
                suffix: LoginCubit.get(context).suffix,
                suffixPressed:(){ LoginCubit.get(context).visiblePass();},
              ),
            ),
            SizedBox(height: 10,),
            BuildCondition(
              condition: state is !ChangePassLoadingState,
              builder:(context)=> defaultButton( function: (){
                if(formkey.currentState!.validate()){
                  LoginCubit.get(context).changePassword(newPassword: newPasswordController.text, currentPassword: passwordController.text);
                }
              }, text: "Change password"),
              fallback:(context)=> Center(child: CircularProgressIndicator()),
            ),
            SizedBox(height: 50,),
            LogutButton( function: (){
              LoginCubit.get(context).logout(context);
            }, text: " Logout"),

          ],
        ),
      ),
    );
  }
}
var EditnameController=TextEditingController();
var EditemailController=TextEditingController();