// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/search/search_screen.dart';
import 'package:shopapp/shared/companent.dart';
import 'package:shopapp/shop_cubit/shopcubit.dart';
import 'package:shopapp/shop_cubit/shopstate.dart';

class ShopLayout_Screen extends StatelessWidget {
  const ShopLayout_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (conext, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Haydra Market'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  navigetorTo(context, SearchScreen());
                },
              ),
              // IconButton(
              //   icon: const Icon(Icons.table_rows_sharp),
              //   onPressed: () {
              //     Column(
              //       mainAxisSize: MainAxisSize.max,
              //       children: [
              //         TextButton(
              //           onPressed: () {
              //             CacheHelper.removeData('token').then((value) {
              //               if (value!)
              //                 navigetorAndFinish(context, ShopLoginScreen());
              //             });
              //           },
              //           child: const Text(
              //             'SIGN OUT',
              //             style: const TextStyle(color: Colors.black),
              //           ),
              //         )
              //       ],
              //     );
              //   },
              // ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currantIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              cubit.changeBottomScreen(index);
            },
            currentIndex: cubit.currantIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: "Catgoryes"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        );
      },
    );
  }
}
