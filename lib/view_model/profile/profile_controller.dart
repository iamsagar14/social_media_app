import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/res/color.dart';
import 'package:social_media_app/res/components/input_text_field.dart';
import 'package:social_media_app/utils/utlis.dart';
import 'package:social_media_app/view_model/services/session_manager.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      uploadImage(context);
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.camera_alt,
                      color: AppColors.primaryIconColor,
                    ),
                    title: Text('Camera'),
                  ),
                  ListTile(
                    onTap: () {
                      pickGalleryImage(context);
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.image,
                      color: AppColors.primaryIconColor,
                    ),
                    title: const Text('Gallery'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage' + SessionController().userId.toString());
    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);
    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();
    ref.child(SessionController().userId.toString()).update({
      'profile': newUrl.toString(),
    }).then(
      (value) {
        Utils.toastMessage('profile Updated');
        setLoading(false);
        _image = null;
      },
    ).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future showUserNameDialogueAlert(BuildContext context, String name) {
    nameController.text = name;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Update username')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                    myController: nameController,
                    focusNode: nameFocusNode,
                    onFieldSubmittedValue: (value) {},
                    onValidator: (value) {},
                    keyBoardType: TextInputType.text,
                    hint: 'enter name',
                    obscureText: false,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancle',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'userName': nameController.text.toString()
                    }).then((value) {
                      nameController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child:
                      Text('Ok', style: Theme.of(context).textTheme.subtitle2))
            ],
          );
        });
  }

  Future showPHoneDialogueAlert(BuildContext context, String phoneNumber) {
    phoneController.text = phoneNumber;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update phoneNumber ')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InputTextField(
                    myController: phoneController,
                    focusNode: phoneFocusNode,
                    onFieldSubmittedValue: (value) {},
                    onValidator: (value) {},
                    keyBoardType: TextInputType.phone,
                    hint: 'enter phone',
                    obscureText: false,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancle',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColors.alertColor),
                  )),
              TextButton(
                  onPressed: () {
                    ref.child(SessionController().userId.toString()).update({
                      'phone': phoneController.text.toString()
                    }).then((value) {
                      phoneController.clear();
                    });
                    Navigator.pop(context);
                  },
                  child:
                      Text('Ok', style: Theme.of(context).textTheme.subtitle2))
            ],
          );
        });
  }
}
