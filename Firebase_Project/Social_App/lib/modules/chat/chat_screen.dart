import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/model_social.dart';
import 'package:social/modules/chat/chat_screen_detail.dart';
import 'package:social/shared/companent.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';
import 'package:social/social_cubit_global/socialstate_global.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return buildUserChat(
                    SocialCubit.get(context).users![index], context);
              },
              separatorBuilder: (context, index) => const SizedBox(
                    height: 5.0,
                  ),
              itemCount: SocialCubit.get(context).users!.length);
        });
  }
}

Widget buildUserChat(SocialUserModle model, context) {
  return InkWell(
    onTap: () {
      navigetorTo(
          context,
          ChatScreenDetails(
            userModel: model,
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      model.name!,
                      style: const TextStyle(
                        fontFamily: 'assets/fonts/jannah.ttf',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    // const Icon(
                    //   Icons.check_circle,
                    //   color: defaultColor,
                    //   size: 16,
                    // ),
                  ],
                ),
                // Text(
                //   model.datetime!,
                //   style: Theme.of(context)
                //       .textTheme
                //       .caption!
                //       .copyWith(height: 1.6),
                // ),
              ],
            ),
          ),
          //  SizedBox(
          //   width: 10.0,
          // ),
          // IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    ),
  );
}
