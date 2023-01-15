// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit.dart';
import '../cubit/stats.dart';
import '../modules/search/search.dart';

class News_Layout extends StatelessWidget {
  const News_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("News App"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScrren()));
                  },
                  icon: Icon(Icons.search)),
              // IconButton(
              // icon: const Icon(Icons.brightness_4_outlined),
              //     onPressed: () {
              //       ThemeCubit.get(context).changeAppMode();
              //     },
              //     ),
            ],
          ),
          body: cubit.screen[cubit.currentindex],
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   child: const Icon(Icons.add),
          // ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomBarItem,
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.bottomSheet(index);
            },
          ),
        );
      },
    );
  }
}
