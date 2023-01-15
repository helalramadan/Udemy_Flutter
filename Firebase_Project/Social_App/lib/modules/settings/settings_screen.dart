import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/edit_screen/edit_screen.dart';
import 'package:social/shared/companent.dart';
import 'package:social/shared/icon_broken.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';
import 'package:social/social_cubit_global/socialstate_global.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var userMoudel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 280.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: 220.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          image: DecorationImage(
                              image: NetworkImage('${userMoudel!.cover}'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  CircleAvatar(
                    radius: 65.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage('${userMoudel.image}'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(userMoudel.name!,
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(
              height: 5.0,
            ),
            Text('${userMoudel.bio}',
                style: Theme.of(context).textTheme.caption),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('365',
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text('Post',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('365',
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text('Photos',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('10K',
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text('Followers',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text('64',
                              style: Theme.of(context).textTheme.bodyText1),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text('Followings',
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: const Text('Add Photo'),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                OutlinedButton(
                  child: const Icon(IconBroken.Edit),
                  onPressed: () {
                    navigetorTo(context, EditScreen());
                  },
                ),
              ],
            ),
            const Spacer(),
            defultButton(
                onPressed: () {
                  SocialCubit.get(context).signOut(context);
                },
                text: 'sign out')
          ]),
        );
      },
    );
  }
}
