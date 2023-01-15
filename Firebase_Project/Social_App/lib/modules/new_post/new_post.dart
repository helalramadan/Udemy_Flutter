import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/shared/icon_broken.dart';
import 'package:social/shared/stayle/colors.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';
import 'package:social/social_cubit_global/socialstate_global.dart';

class NewPost extends StatelessWidget {
  NewPost({super.key});
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: const Text('Creat Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    final now = DateTime.now();
                    if (SocialCubit.get(context).postImage == null) {
                      SocialCubit.get(context).creatPost(
                          datetime: now.toString(), text: textController.text);
                    } else {
                      SocialCubit.get(context).creatPostImage(
                          datetime: now.toString(), text: textController.text);
                    }
                  },
                  child: Text('post'.toUpperCase()))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatNewPostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatNewPostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${userModel.name}',
                            style: const TextStyle(
                              fontFamily: 'assets/fonts/jannah.ttf',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),
                          // const SizedBox(
                          //   width: 5.0,
                          // ),
                          // const Icon(
                          //   Icons.check_circle,
                          //   color: defaultColor,
                          //   size: 16,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'whate is on your mind ${userModel.name}',
                        border: InputBorder.none),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 220.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                              image: FileImage(
                                  SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                            radius: 25.0, child: Icon(IconBroken.Close_Square)),
                      )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Add Photo')
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('# Tag'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
