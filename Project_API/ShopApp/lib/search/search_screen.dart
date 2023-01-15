import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shopapp/shared/companent.dart';
import 'package:shopapp/shared/stayle/colors.dart';
import 'package:shopapp/shop_cubit/shopcubit.dart';
import 'package:shopapp/shop_cubit/shopstate.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formkey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit(),
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defultTextForm(
                        textController: searchController,
                        type: TextInputType.text,
                        lable: 'Search',
                        prefix: Icons.search,
                        isPass: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        onSubmet: (value) {
                          ShopCubit.get(context).searchModel(value.toString());
                        }),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (state is LoadingSearchState) LinearProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    if (state is SuccessSearchState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                ListProdecSearchtItem(
                                    ShopCubit.get(context)
                                        .model!
                                        .data!
                                        .data[index],
                                    context,
                                    false),
                            separatorBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  height: 1.0,
                                  color: Colors.grey,
                                ),
                            itemCount: ShopCubit.get(context)
                                .model!
                                .data!
                                .data
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget ListProdecSearchtItem(model, context, bool isOldPrice) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 200.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  height: 150.0,
                  image: NetworkImage(model.image!),
                  // fit: BoxFit.cover,
                  width: 150.0,
                ),
                if (model.discount != 0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'discount'.toUpperCase(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 8.0),
                    ),
                  )
              ]),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        height: 1.6,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          model.price.toString(),
                          style: const TextStyle(
                            color: defaultColor,
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model.discount != 0 && isOldPrice)
                          Text(
                            model.old_price.toString(),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12.0,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        // IconButton(
                        //     padding: EdgeInsets.zero,
                        //     onPressed: () {
                        //       ShopCubit.get(context)
                        //           .changeFavorites(model.product!.id!);
                        //       print(model.id!);
                        //     },
                        //     icon: CircleAvatar(
                        //       radius: 15.0,
                        //       backgroundColor: ShopCubit.get(context)
                        //                   .favorites[model.product.id] ==
                        //               true
                        //           ? defaultColor
                        //           : Colors.grey,
                        //       child: Icon(
                        //         color: Colors.white,
                        //         Icons.favorite_border,
                        //         size: 16.0,
                        //       ),
                        //     ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
