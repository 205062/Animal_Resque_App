import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:petzz_project/adds_model.dart';
import 'package:petzz_project/login_user_adds.dart';
import 'commandialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataController extends GetxController {
  final firebaseInstance = FirebaseFirestore.instance;
  List<AnimalAdd> loginUserData = [];
  List<AnimalAdd> allAnimals = [];

  Future<void> addNewAnimal(Map animaldata, File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    final ref =
        FirebaseStorage.instance.ref().child('animal_images').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();

    try {
      CommanDialog.showLoading();
      var response = await firebaseInstance.collection('animallist').add({
        'animal_name': animaldata['a_name'],
        "animal_phone_number": animaldata['a_phone_number'],
        'animal_tbr': animaldata['a_tbr'],
        'animal_st': animaldata['a_st'],
        'animal_location': animaldata['a_location'],
        "animal_upload_date": animaldata['a_upload_date'],
        'animal_image': imageUrl,
        'user_Id': getUserId(),
      });
      print(animaldata);

      print("Firebase response1111 $response");
      CommanDialog.hideLoading();
      Get.to(() => LoginUserAdds());
    } catch (exception) {
      CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }

  String getUserId() {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user!.uid;
    return userId;
  }

  Future<void> getLoginUserProduct() async {
    print("loginUserData YEs $loginUserData");
    loginUserData = [];
    try {
      CommanDialog.showLoading();
      final List<AnimalAdd> lodadedAnimal = [];
      var response = await firebaseInstance
          .collection('animallist')
          .where('user_Id', isEqualTo: getUserId())
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            print("Animal ID  ${result.id}");
            lodadedAnimal.add(
              AnimalAdd(
                a_Id: result.id,
                userId: result['user_Id'],
                a_name: result['animal_name'],
                a_st: result['animal_st'],
                a_tbr: result['animal_tbr'],
                a_phone_number: int.parse(result["animal_phone_number"]),
                a_date: result["animal_upload_date"].toString(),
                a_location: result['animal_location'],
                a_image: result['animal_image'],
              ),
            );
          },
        );
      }
      loginUserData.addAll(lodadedAnimal);
      update();
      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }

  Future<void> getAllProduct() async {
    allAnimals = [];
    try {
      CommanDialog.showLoading();
      final List<AnimalAdd> lodadedAnimal1 = [];
      var response = await firebaseInstance
          .collection('animallist')
          .where('user_Id', isNotEqualTo: getUserId())
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            print(result.id);
            lodadedAnimal1.add(
              AnimalAdd(
                a_Id: result.id,
                userId: result['user_Id'],
                a_name: result['animal_name'],
                a_st: result['animal_st'],
                a_tbr: result['animal_tbr'],
                a_phone_number: int.parse(result["animal_phone_number"]),
                a_date: result["animal_upload_date"].toString(),
                a_location: result['animal_location'],
                a_image: result['animal_image'],
              ),
            );
          },
        );
        allAnimals.addAll(lodadedAnimal1);
        update();
      }

      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }
}
