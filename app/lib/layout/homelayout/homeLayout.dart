
import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/cubit/states/states.dart';

import 'package:brain_tumor/module/uploadscreen/UploadScreen.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:brain_tumor/shared/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,Appstates>(
      listener: (context,state){
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);

        return state is !GetUserLoading ? Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),

            child: AppBar(
              leadingWidth: 50,
              //title: Text("HOME"),
              // leading: Padding(
              //   padding:  const EdgeInsetsDirectional.only(start: 15,top: 5),
              //   child:  CircleAvatar(child:braini ,backgroundColor: Colors.white,radius: 27,),
              // ) ,
              // title: Padding(
              //   padding: const EdgeInsetsDirectional.only(top: 10),
              //   child:  Row(children: [
              //     if(usermodel != null)
              //       Text(cubit.currentIndex==0?usermodel!.name! :cubit.Titles[cubit.currentIndex],style: const TextStyle(fontSize: 16,color: Colors.white),)
              //   ],),
              // ),
              title: Text("Home"),
              // actions: [
              //   Column(
              //     children: [
              //       const SizedBox(height: 2,),
              //       Padding(
              //         padding: const EdgeInsetsDirectional.only(end: 20),
              //         child: Stack(alignment:Alignment.center ,
              //           children: [
              //             const CircleAvatar(radius: 27,backgroundColor: Colors.white,),
              //             if(usermodel != null)
              //               InkWell(
              //                 onTap: (){
              //                   navigateTo(context, Profile());
              //                 },
              //                 child: CircleAvatar(
              //                   backgroundImage: NetworkImage(usermodel!.image!) ,
              //                   radius: 25,
              //                 ),
              //               ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ],
              backgroundColor: Colors.blue,
              centerTitle: true,
            ),

          ),
          body: cubit.screens[cubit.currentIndex]
          ,bottomNavigationBar:Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.blue, width: 2.0))
          ),
          child: BottomNavigationBar(type:BottomNavigationBarType.fixed,
            items:   [
              BottomNavigationBarItem(icon:SizedBox(height:
              40 ,width: 40,child: home,),label: "Home",activeIcon: homei),
              BottomNavigationBarItem(icon:SizedBox(child: result,height:
              40 ,width: 40,),label: "Result",activeIcon:resulti
              ),
              // BottomNavigationBarItem(icon:SizedBox(child: about,height:
              // 40 ,width: 40,),label: "About us",activeIcon: abouti),
              // BottomNavigationBarItem(icon:SizedBox(child: saved,height:
              // 40 ,width: 40,),label: "Saved",activeIcon: savedi),

            ],
            currentIndex: cubit.currentIndex
            ,
            onTap: (index){
              cubit.ChangeScreens(index, context);
            },
          ),
        ),
          floatingActionButton:FloatingActionButton(
            mini: false,
            //Floating action button on Scaffold
            onPressed: (){
              navigateTo(context, const UploadScreen());
              //code to execute on button press
            },
            child:brain, //icon inside button
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ):Center(child: CircularProgressIndicator());
      },
    );
  }
}
