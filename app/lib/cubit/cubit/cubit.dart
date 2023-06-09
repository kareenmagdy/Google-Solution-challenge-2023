import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:brain_tumor/Network/local/sharedpref.dart';
import 'package:brain_tumor/model/MriModel/MriModel.dart';
import 'package:brain_tumor/module/After%20Process/Afterprocess.dart';
import 'package:brain_tumor/module/AfterUpload/AfterUpload.dart';
import 'package:brain_tumor/module/Login/login.dart';
import 'package:brain_tumor/module/Result/result.dart';
import 'package:brain_tumor/module/saved/saved.dart';
import 'package:brain_tumor/shared/colors/colors.dart';
import 'package:brain_tumor/shared/component/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brain_tumor/cubit/states/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import '../../model/usermodel/User_model.dart';
import '../../module/recent result/resent.dart';
import '../../shared/const/const.dart';

class AppCubit extends Cubit<Appstates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  File? mriImage;
  var picker = ImagePicker();

  Future<void> getImage(context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      mriImage = File(pickedFile.path);
      navigateTo(context, AfterUpload());
      emit(uploadImageSuccess());
    } else {
      print('No image selected.');
      emit(uploadImageError());
    }
  }

  int? code;
  String? processResult;
  getResult({required image}) async {
    final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://f1fa-197-54-138-129.eu.ngrok.io/predictApi"));
    final headers = {
      "Content-Type": "multipart/form-data",
    };
    request.files.add(http.MultipartFile(
        'fileup', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split("/").last));
    request.headers.addAll(headers);

    final response = await request.send();
    code = response.statusCode;
    if (response.statusCode == 200) {
      emit(getResultSuccess());
      print("Request Send ");


    } else {
      print("Error and this code is  ${response.statusCode}");
    }
    http.Response res = await http.Response.fromStream(response);
    final restjson = jsonDecode(res.body);
    print(restjson);
    processResult = restjson['prediction'];

    print(processResult);
  }

  void endapp() {
    mriImage = null;
    code = null;
  }

  // loadModel() async {
  //   await Tflite.loadModel(
  //     model: "assets/model.tflite",
  //     labels: "assets/labels.txt",
  //   ).then((value) {
  //     print("done");
  //   }).catchError((error) {
  //     print(" ${error.toString()}");
  //   });
  // }

  List? outputs;
  String? brainResult;
  double? confidence;
  classifyImage({required image,
    required context,
    required datetime}) async {
    emit(ClassificationLoading());
    getResult(image: image);
    navigateTo(context, const ProcessingDetails());
    UploadMriImage(name: nameController.text, datetime: datetime, result: brainResult!, confidence: confidence!, image: image);
    //
    // await Tflite.runModelOnImage(
    //   path: image.path,
    // ).then((value) {
    //   print("predict = " + value.toString());
    //   outputs = value;
    //   confidence = value![0]["confidence"] ;
    //   confidence=confidence!*100;
    //   // if (value[0]["index"] == 0) {
    //   //   brainResult = "Positive ";
    //   // } else {
    //   //   brainResult = "Negative ";
    //   // }
    //   emit(ClassificationSuccess());
    // }).then((value){
    //   navigateTo(context, const ProcessingDetails());
    //   UploadMriImage(name: nameController.text, datetime: datetime, result: brainResult!, confidence: confidence!, image: image
    //   );
    // }).catchError((error) {
    //   print("Error of class is ${error.toString()}");
    // });
  }

  void getUserData() async {
    try {
      emit(GetUserLoading());
      final value =
      await FirebaseFirestore.instance.collection('users').doc(uId).get();
      usermodel = UserModel.fromJson(value.data()!);
      getPatient();
      emit(GetUserSuccess());
    } catch (error) {
      print("get Error is $error");
      emit(GetUserError(error.toString()));
    }
  }

  int currentIndex = 0;
  List<String> Titles = [
    "${usermodel?.name}",
    "All Results",
    "About Us",
    "Saved Results"
  ];
  List<Widget> screens = [
    const Recent(),
    const Result(),
    //const AboutUs(),
    //const SavedScreen(),
  ];
  void ChangeScreens(int index, context) {
    currentIndex = index;
    emit(changeBottomNav());
  }


  String? mrId;
  void AddMri({
    required String datetime,
    required String result,
    required double confidence,
    required String image,
  }) {
    emit(UploadResultLoading());
    PatientModel patientModel = PatientModel(
      name: nameController.text,
      dId: usermodel!.uId,
    );
    MriModel mriModel=MriModel(
      confidence: confidence,
      patientName: nameController.text,
      image: image,
      isSaved: false,
      result: result,
      date: datetime,
    );
    FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
        .collection("patient")
        .doc(nameController.text).set(patientModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
          .collection('patient')
          .doc(nameController.text)
          .collection('Mri')
          .add(mriModel.toMap())
          .then((value) {
        updatePatient(
          pName: nameController.text,
          confidence: confidence,
          datetime: datetime,
          image: image,
          isSave: false,
          mrid: value.id,
          result: result,
        );
        emit(UploadResultSuccess());
      })
          .catchError((error) {
        emit(UploadResultError());
        print(error.toString());
      });
    }).catchError((error) {
      print("Error of patint is $error");
      emit(UploadResultError());
    });
  }



  void updatePatient({
    required String datetime,
    required String pName,
    required bool isSave,
    required String result,
    required double confidence,
    required String image,
    required String mrid,
  }){
    emit(UpdatePatientLoading());
    PatientModel patientModel = PatientModel(
      name: nameController.text,
      dId: usermodel!.uId,
    );
    MriModel mriModel=MriModel(
      confidence: confidence,
      patientName: pName,
      image: image,
      isSaved: isSave,
      result: result,
      date: datetime,
      mrId: mrid,
    );
    FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
        .collection("patient")
        .doc(nameController.text).update(patientModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
          .collection('patient')
          .doc(nameController.text)
          .collection('Mri')
          .doc(mrid).update(mriModel.toMap())
          .then((value) {
        patientModels = [];
        mriModels = [];
        getPatient();
        emit(UpdatePatientSuccess());
      })
          .catchError((error) {
        emit(UpdatePatientError());
      });
    }).catchError((error) {
      print("Error of patint is $error");
      emit(UpdatePatientError());
    });
  }

  bool isSaved = false;
  void upadteSave({
    required String? datetime,
    required String? name,
    required bool? save,
    required String? result,
    required double? confidence,
    required String? image,
    required String? mrid,
  }){
    // isSaved = !isSaved;
    // emit(ChangeSaved());

    emit(UpdateSaveTrueLoading());
    PatientModel patientModel = PatientModel(
      name: name,
      dId: usermodel!.uId,
    );
    MriModel mriModel=MriModel(
      confidence: confidence,
      patientName: name,
      image: image,
      isSaved: save,
      result: result,
      date: datetime,
      mrId: mrid,
    );
    FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
        .collection("patient")
        .doc(name).update(patientModel.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
          .collection('patient')
          .doc(name)
          .collection('Mri')
          .doc(mrid).update(mriModel.toMap())
          .then((v) {
        isSaved = !isSaved;
        getPatient();
      })
          .catchError((error) {
        emit(UpdateSaveError());
      });
    }).catchError((error) {
      print("Error of patint is $error");
      emit(UpdateSaveError());
    });


  }

  void logout(context){
    emit(SignOutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId').then((value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );

        patientModels = [];
        mriModels = [];
        recentModels = [];
        mriSave = [];
        mrIdList = [];
        resultList = [];
        emit(SignOutSuccessState());
      });
    }).catchError((error) {
      emit(SignOutErrorState());
      print(error.toString());
    });
  }
  List<PatientModel> patientModels = [];
  List<MriModel> mriModels = [];
  List<MriModel> recentModels = [];
  List<MriModel> mriSave = [];
  List<MriModel> mriPositive = [];
  List<MriModel> mriNigative = [];
  List<String> mrIdList = [];
  List<String?> resultList = [];
  Map<String, List<MriModel>> mriDetails = {};


  void getPatient() async{

    emit(getPatientLoading());
    patientModels = [];
    mriModels = [];
    await FirebaseFirestore.instance.collection('users').doc(usermodel!.uId)
        .get().then((value) {
      value.reference.collection('patient')
          .get().then((value) {
        value.docs.forEach((patientId) {
          patientModels.add(PatientModel.fromJson(patientId.data()));
          mriDetails.addAll({patientId.id:[]});
          patientId.reference.collection('Mri').get().then((value) {
            value.docs.forEach((element) {
              mriDetails[patientId.id]!.add(MriModel.fromJson(element.data()));
              mrIdList.add(element.id);
              mriModels.add(MriModel.fromJson(element.data()));
              print("mrimpd ${mriModels.length}");
            });
            mriSave = [];
            mriPositive = [];
            mriNigative = [];
            mriModels.forEach((e) {
              if(e.isSaved == true){
                mriSave.add(e);
              }
              if(e.result=="Negative "){
                mriNigative.add(e);
              }  if(e.result=="Positive "){
                mriPositive.add(e);
              }
              print("mrisave ${mriSave.length}");
              print("mriPositive ${mriPositive.length}");
              Positive=(mriPositive.length/(mriPositive.length+mriNigative.length))*100;
              Negaitve=(mriNigative.length/(mriPositive.length+mriNigative.length))*100;
              print("mriNigative ${mriNigative.length}");
            });
            emit(getMriSuccess());
          });
        });

      });
      emit(getPatientSuccess());
    }).catchError((error) {
      print("errrrrrrrrrror  ${error.toString()}");
      emit(getPatientError());
    });
  }


  var imageLink;
  List<File> ImageFile = [];
  void UploadMriImage({
    required String name,
    required String datetime,
    required String result,
    required double  confidence,
    required  image,
  }) {
    FirebaseStorage.instance
        .ref()
        .child('${nameController.text}/${Uri.file(mriImage!.path).pathSegments.last}')
        .putFile(mriImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        AddMri(
          datetime: datetime,
          result: result,
          confidence: confidence,
          image: value,
        );
      });
    }).catchError((error) {});
  }
  List<PatientModel> processInfo=[];
  void getProcessInfo(){
    emit(GetPostsLoading());
    FirebaseFirestore.instance
        .collection('patient').doc().get().
    then((value) {
      processInfo.add(PatientModel.fromJson(value.data()!));
      print(value);
      emit(GetPostsSuccess());
      print(processResult);
    }).catchError((error){
      print(error);
      emit(GetPostsError(error.toString()));
    });
  }
  void updateUser({
    required String name,
    required String email,
    String? cover,
    String? image,
  }) {
    emit(UpdateuserLoading());
    UserModel model = UserModel(
      name: name,
      image: image ?? usermodel!.image!,
      isEmailVerified: false,
      uId: usermodel!.uId,
      email: email,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(Updateusersuccess());
      ProfileImage=null;
    }).catchError((error) {
      emit(UpdateuserError());
    });
  }
  void UploadProfileImage({
    required String name,
    required String email,
  }) {
    emit(UploadProfileImageLoading());
    FirebaseStorage.instance
        .ref()
        .child('usersprof/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(ProfileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name,
          email: email,
          image: value,
        );
        emit(UploadProfileImageSuccess());
      });
    }).catchError((error) {
      emit(UploadProfileImageError());
    }).catchError((error) {
      emit(UploadProfileImageError());
    });
  }
  File? ProfileImage;
  Future<void> getProfileImage({
    required String name,
    required String email}
      ) async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      ProfileImage = File(PickedFile.path);
      emit(PickProfileImageSuccess());
      UploadProfileImage(email: email, name: name,);
    } else {
      print("Error please try again");
      emit(PickProfileImageError());
    }
  }


  Color resultColor(var conf){
    if (conf<50){
      return maincolor;
    }
    else if (conf >50 && conf <=80){
      return HexColor("#F4AB1D");
    }
    else{
      return HexColor("#F41D1D");
    }
  }
  bool isEdit=false;
  IconData editicon =Icons.edit;
  void editprofile(){
    isEdit=!isEdit;
    editicon=isEdit? Icons.edit_off : Icons.edit;
    EditnameController.text=usermodel!.name!;
    emit(editstate());
    print(isEdit);
  }  bool isEEdit=false;
  IconData Eediticon =Icons.edit;
  void Eeditprofile(){
    isEEdit=!isEEdit;
    Eediticon=isEEdit? Icons.edit_off : Icons.edit;
    EditemailController.text=usermodel!.email!;
    emit(editstate());
    print(isEdit);
  }
}

// bool isPassword=true;
// IconData suffix=Icons.remove_red_eye;
// void visiblePass(){
//   isPassword=!isPassword;
//   suffix=isPassword? Icons.remove_red_eye:Icons.visibility_off;
//   emit(LoginVisiblePassword());
//   print(isPassword);
// }
