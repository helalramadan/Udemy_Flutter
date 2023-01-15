import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/shared/companent.dart';
import 'package:social/shared/icon_broken.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';
import 'package:social/social_cubit_global/socialstate_global.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key});
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userMoudel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        nameController.text = userMoudel!.name!;
        bioController.text = userMoudel.bio!;
        phoneController.text = userMoudel.phone!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: const Text('Edit'),
            actions: [
              TextButton(
                  onPressed: () {
                    SocialCubit.get(context).upDateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  child: Text('update'.toUpperCase()))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 280.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 220.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${userMoudel.cover}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: CircleAvatar(
                                    radius: 25.0,
                                    child: Icon(IconBroken.Camera)),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userMoudel.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                  radius: 25.0, child: Icon(IconBroken.Camera)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null)
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defultButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .uploadProfileImageStorage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                  },
                                  text: "upload image"),
                              if (state is SocialUploadProfileImageState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUploadProfileImageState)
                                LinearProgressIndicator(),
                            ],
                          )),
                        SizedBox(
                          width: 10.0,
                        ),
                        if (SocialCubit.get(context).coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defultButton(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .uploadCoverImageStorage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                  },
                                  text: "upload cover"),
                              if (state is SocialUploadProfileImageState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is SocialUploadProfileImageState)
                                LinearProgressIndicator(),
                            ],
                          )),
                      ],
                    ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defultTextForm(
                      textController: nameController,
                      type: TextInputType.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'name must not be empty'.toLowerCase();
                        }

                        return null;
                      },
                      lable: 'Name',
                      prefix: IconBroken.User,
                      isPass: false),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defultTextForm(
                      textController: bioController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'bio must not be empty'.toLowerCase();
                        }

                        return null;
                      },
                      lable: 'Bio',
                      prefix: IconBroken.Info_Circle,
                      isPass: false),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defultTextForm(
                      textController: phoneController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'phone must not be empty'.toLowerCase();
                        }

                        return null;
                      },
                      lable: 'Phone',
                      prefix: IconBroken.Call,
                      isPass: false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
