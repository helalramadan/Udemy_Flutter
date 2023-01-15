import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/message_model.dart';
import 'package:social/models/model_social.dart';
import 'package:social/shared/icon_broken.dart';
import 'package:social/shared/stayle/colors.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';
import 'package:social/social_cubit_global/socialstate_global.dart';

class ChatScreenDetails extends StatelessWidget {
  SocialUserModle? userModel;
  ChatScreenDetails({this.userModel});

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getMessage(receivedId: userModel!.uId!);
    return Builder(builder: (context) {
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userModel!.image!),
                    radius: 25.0,
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(userModel!.name!)
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var message = SocialCubit.get(context).messages[index];
                        if (SocialCubit.get(context).userModel!.uId ==
                            message.senderId) return buildMyMessage(message);
                        return buildMessage(message);
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15.0),
                      itemCount: SocialCubit.get(context).messages.length),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(15.0)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cubit.textController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Type Your Message'),
                          ),
                        ),
                        Container(
                          color: defaultColor,
                          height: 50.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            onPressed: () {
                              SocialCubit.get(context).sendMessage(
                                  receivedId: userModel!.uId!,
                                  text: cubit.textController.text,
                                  dateTime: DateTime.now().toString());
                            },
                            child: const Icon(
                              IconBroken.Send,
                              size: 16.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

Widget buildMessage(MeassageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            )),
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Text(
              model.text!,
              style: const TextStyle(fontSize: 16.0),
            )),
      ),
    );

Widget buildMyMessage(MeassageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(
                  10.0,
                ),
                topStart: Radius.circular(
                  10.0,
                ),
                topEnd: Radius.circular(
                  10.0,
                ),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10.0,
            ),
            child: Text(
              model.text!,
              style: const TextStyle(fontSize: 16.0),
            ),
          )),
    );
