import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/new_post/new_post.dart';
import 'package:social/modules/search/search_screen.dart';
import 'package:social/shared/companent.dart';
import 'package:social/shared/icon_broken.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';
import 'package:social/social_cubit_global/socialstate_global.dart';

class SocialLayout_Screen extends StatelessWidget {
  const SocialLayout_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is NewPostNavState) {
          navigetorTo(context, NewPost());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titelsScreens[cubit.curentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(
                  onPressed: () {
                    navigetorTo(context, SearchScreen());
                  },
                  icon: const Icon(IconBroken.Search)),
              const SizedBox(
                width: 10.0,
              )
            ],
          ),
          body: cubit.screen[cubit.curentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.curentIndex,
              onTap: (index) {
                cubit.chanageScreen(
                  index,
                );
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Home,
                    ),
                    label: 'home'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload), label: 'New Post'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Location), label: 'User'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting), label: 'Search'),
              ]),
        );
      },
    );
  }
}
