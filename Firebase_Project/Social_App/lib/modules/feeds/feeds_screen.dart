import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/models/model_post.dart';
import 'package:social/shared/icon_broken.dart';
import 'package:social/shared/stayle/colors.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';
import 'package:social/social_cubit_global/socialstate_global.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({super.key});
  var commintController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts!.isNotEmpty,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.all(10.0),
                    elevation: 5.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        const Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/unique-beautiful-women-hands_23-2149012590.jpg'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 200.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Communicate With Friend ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                          SocialCubit.get(context).posts![index],
                          context,
                          index),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 8.0,
                          ),
                      itemCount: SocialCubit.get(context).posts!.length),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildPostItem(SocialPostModle model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                        '${SocialCubit.get(context).userModel!.image}'),
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
                              "${SocialCubit.get(context).userModel!.name}",
                              style: const TextStyle(
                                fontFamily: 'assets/fonts/jannah.ttf',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          model.datetime!,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.6),
                        ),
                      ],
                    ),
                  ),
                  //  SizedBox(
                  //   width: 10.0,
                  // ),
                  IconButton(
                      icon: const Icon(Icons.more_horiz), onPressed: () {}),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                model.text!,
                style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    fontFamily: 'assets/fonts/jannah.ttf'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10.0),
                        child: SizedBox(
                          height: 25.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#Software',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: defaultColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.postimage != '')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    height: 220.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        image: DecorationImage(
                            image: NetworkImage(model.postimage!),
                            fit: BoxFit.cover)),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(top: 10.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text('${SocialCubit.get(context).likes[index]}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text('${SocialCubit.get(context).commints[index]}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.grey[300],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundImage: NetworkImage(
                                SocialCubit.get(context).userModel!.image!),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: commintController,
                              onFieldSubmitted: (value) {
                                SocialCubit.get(context).commintPosts(
                                  postId:
                                      SocialCubit.get(context).postId[index],
                                  commint: commintController.text,
                                );
                              },
                              decoration: const InputDecoration(
                                  hintText: 'Write Comment',
                                  border: InputBorder.none),
                            ),
                          )
                          // Text(
                          //   'Write Comment',
                          //   style: Theme.of(context).textTheme.caption,
                          // )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likePosts(SocialCubit.get(context).postId[index]);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text('Like'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
