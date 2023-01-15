import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/catgors_model.dart';
import 'package:shopapp/shop_cubit/shopcubit.dart';
import 'package:shopapp/shop_cubit/shopstate.dart';

class ShopCatgories extends StatelessWidget {
  const ShopCatgories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => bulidCatitems(
                ShopCubit.get(context).categoresModel!.data!.data[index]),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
            itemCount:
                ShopCubit.get(context).categoresModel!.data!.data.length);
      },
    );
  }

  Widget bulidCatitems(CatgoresDataList model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 150.0,
              width: 150.0,
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              model.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      );
}
