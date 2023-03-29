import 'package:brain_tumor/blocob.dart';
import 'package:brain_tumor/cubit/cubit/cubit.dart';
import 'package:brain_tumor/layout/homelayout/homeLayout.dart';
import 'package:brain_tumor/module/Login/login.dart';
import 'package:brain_tumor/module/Login/loginCubit/cubit/cubit.dart';
import 'package:brain_tumor/shared/const/const.dart';
import 'package:brain_tumor/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Network/local/sharedpref.dart';
import 'cubit/Main/cubit/cubit.dart';
import 'cubit/Main/states/states.dart';


Future<void> main()  async {


  BlocOverrides.runZoned(() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    await CacheHelper.init();

    uId=CacheHelper.getData(key: 'uId');
    Widget widget;
    if(uId !=null){
      widget=HomeScreen();
    }
    else{
      widget=LoginScreen();
    }
    runApp( MyApp(startWidget:widget));

  }, blocObserver: SimpleBlocObserver());
}

class MyApp extends StatelessWidget {
  late final Widget startWidget;
  MyApp({
  required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..getUserData()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => MainAppCubit()),
        ],
      child: BlocConsumer<MainAppCubit,MainAppstates>(
        listener: ( context, state) {  },
        builder: ( context,  state) {
          return MaterialApp(
            theme: ThemeData(
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: HexColor("#FFFFFF"),
                shape: StadiumBorder(
                    side: BorderSide(
                        color: Colors.blue, width: 4))
              ),
              appBarTheme: AppBarTheme(

                 color: Colors.blue,
              ),
              unselectedWidgetColor: Colors.blue,
              // primarySwatch: Colors.green,

              bottomNavigationBarTheme:BottomNavigationBarThemeData(
                selectedItemColor:Colors.blue
                ,
                unselectedItemColor:Colors.black ,
                backgroundColor: HexColor('#FFFFFF'),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home:SplashScreen() ,
          );
        },

      ),
    );
  }
}

