import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/model_post.dart';
import 'package:social/modules/chat/chat_screen.dart';
import 'package:social/modules/feeds/feeds_screen.dart';
import 'package:social/modules/login/social_login.dart';
import 'package:social/modules/new_post/new_post.dart';
import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/modules/users/users_screen.dart';
import 'package:social/shared/companent.dart';
import 'package:social/shared/stayle/constans.dart';
import 'package:social/social_cubit_global/socialstate_global.dart';

import '../models/model_social.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialinitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModle? userModel;

  void getUser() {
    emit(SocialGetUserLoadState());
    FirebaseFirestore.instance.collection('user').doc(uId).get().then((value) {
      print('Global Get User Success');
      print(value.data());
      userModel = SocialUserModle.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print('Global Get User Error');
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int curentIndex = 0;
  List<Widget> screen = [
    FeedsScreen(),
    const ChatScreen(),
    NewPost(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  void chanageScreen(int index) {
    if (index == 0) {
      getPosts();
    }
    if (index == 1) {
      getAllUser();
    }
    if (index == 2) {
      emit(NewPostNavState());
    } else {
      curentIndex = index;

      emit(CahnageBottomNavState());
    }
  }

  List<String> titelsScreens = [
    'Home',
    'Chat',
    'Post',
    'User',
    'Setting',
  ];

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    // final pickerImage = await picker.getImage(source: ImageSource.gallery); => old Way
    final pickerImage =
        await picker.pickImage(source: ImageSource.gallery); // => New Way

    if (pickerImage != null) {
      profileImage = File(pickerImage.path);
      print('Picked Image Success ');
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('Picked Image Error ');
    }
    emit(SocialProfileImagePickedErrorState());
  }

  File? coverImage;
  var pickerCover = ImagePicker();
  Future<void> getCoverImage() async {
    // final pickerImage = await picker.getImage(source: ImageSource.gallery); => old Way
    final coverPicerImage =
        await pickerCover.pickImage(source: ImageSource.gallery); // => New Way

    if (coverPicerImage != null) {
      coverImage = File(coverPicerImage.path);
      print('Picked Image Success ');
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('Picked Image Error ');
    }
    emit(SocialCoverImagePickedErrorState());
  }

  void uploadProfileImageStorage({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUploadProfileImageState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('URL image Profile $value');
        upDateUser(name: name, phone: phone, bio: bio, image: value);
        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState(error.toString()));
    });
  }

  void uploadCoverImageStorage({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUploadProfileImageState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('URL image Cover $value');
        upDateUser(name: name, phone: phone, bio: bio, cover: value);
        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState(error.toString()));
    });
  }

  void upDateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialUserModle modelUpdate = SocialUserModle(
        name: name,
        email: userModel!.email,
        phone: phone,
        uId: uId,
        image: image ?? userModel!.image,
        cover: cover ?? userModel!.cover,
        bio: bio,
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('user')
        .doc(modelUpdate.uId)
        .update(modelUpdate.toMap())
        .then((value) {
      getUser();
    }).catchError((error) {
      emit(SocialUpdateInfromtionErrorState(error.toString()));
    });
  }

  void creatPostImage({
    required String datetime,
    required String text,
  }) {
    emit(SocialCreatNewPostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('URL image Cover $value');
        creatPost(datetime: datetime, text: text, postimage: value);

        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialCreatNewPostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialCreatNewPostErrorState(error.toString()));
    });
  }

  File? postImage;
  var pickerpost = ImagePicker();
  Future<void> getPostImage() async {
    // final pickerImage = await picker.getImage(source: ImageSource.gallery); => old Way
    final postPicerImage =
        await pickerpost.pickImage(source: ImageSource.gallery); // => New Way

    if (postPicerImage != null) {
      postImage = File(postPicerImage.path);
      print('Picked Image Success ');
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('Picked Image Error ');
    }
    emit(SocialPostImagePickedErrorState());
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemoveImageState());
  }

  void signOut(context) {
    FirebaseAuth.instance.signOut().then((value) {
      uId = '';
      navigetorAndFinish(context, SocialLoginScreen());
      emit(SocialSignOutSuccessState());
    }).catchError((error) {
      emit(SocialSignOutErrorState(error.toString()));
    });
  }

  void creatPost({
    required String datetime,
    required String text,
    String? postimage,
  }) {
    SocialPostModle modelPost = SocialPostModle(
      name: userModel!.name,
      text: text,
      postimage: postimage ?? '',
      uId: uId,
      image: userModel!.image,
      datetime: datetime,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(modelPost.toMap())
        .then((value) {
      emit(SocialCreatNewPostSuccessState());
    }).catchError((error) {
      emit(SocialCreatNewPostErrorState(error.toString()));
    });
  }

  List<SocialPostModle>? posts;
  List<String> postId = [];
  List<int> likes = [];
  List<int> commints = [];
  void getPosts() {
    posts = [];
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          postId.add(element.id);
          likes.add(value.docs.length);
        });
        element.reference.collection('commint').get().then((value) {
          commints.add(value.docs.length);
          posts!.add(SocialPostModle.fromJson(element.data()));
          emit(SocialGetPostsSuccessState());
        }).catchError((error) {
          emit(SocialGetPostsErrorState(error.toString()));
        });
      }
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  void commintPosts({
    required String commint,
    String? postId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('commint')
        .doc(userModel!.uId)
        .set({'commint': commint}).then((value) {
      emit(SocialCommintPostSuccessState());
    }).catchError((error) {
      emit(SocialCommintPostErrorState(error.toString()));
    });
  }

  List<SocialUserModle>? users;
  void getAllUser() {
    users = [];
    FirebaseFirestore.instance.collection('user').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != uId) {
          users!.add(SocialUserModle.fromJson(element.data()));
        }
        emit(SocialGetAllUserSuccessState());
      }
    }).catchError((error) {
      emit(SocialGetAllUserErrorState(error.toString()));
    });
  }

  var textController = TextEditingController();
  void sendMessage({
    required String receivedId,
    required String text,
    required String dateTime,
  }) {
    MeassageModel model = MeassageModel(
        senderId: userModel!.uId,
        dateTime: dateTime,
        text: text,
        receiverId: receivedId);
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(receivedId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      textController.text = '';
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
    FirebaseFirestore.instance
        .collection('user')
        .doc(receivedId)
        .collection('chat')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  List<MeassageModel> messages = [];
  void getMessage({
    required String receivedId,
  }) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(userModel!.uId)
        .collection('chat')
        .doc(receivedId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var ele in event.docs) {
        messages.add(MeassageModel.fromJson(ele.data()));
      }
      emit(SocialGetMessagesSuccessState());
    });
  }
}
