import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/shared/stayle/colors.dart';
import 'package:shopapp/shop_cubit/shopcubit.dart';

Future navigetorAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Future navigetorTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

Widget defultTextForm({
  required TextEditingController textController,
  required TextInputType type,
  Function? onTap,
  Function? onChange,
  Function? onSubmet,
  required Function validator,
  Function? suffixPressed,
  required String lable,
  required IconData prefix,
  IconData? suffix,
  bool? isPass,
}) =>
    TextFormField(
      controller: textController,
      keyboardType: type,
      obscureText: isPass!,
      onTap: onTap != null ? onTap() : null,
      onChanged: onChange != null ? (s) => onChange(s) : null,
      onFieldSubmitted: onSubmet != null ? (s) => onSubmet(s) : null,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        label: Text(lable),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defultButton({
  required Function onPressed,
  double width = double.infinity,
  Color backgraound = Colors.blue,
  required String text,
  bool isUppercase = true,
  double radius = 3.0,
}) =>
    Container(
      height: 50,
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: backgraound,
        borderRadius: BorderRadius.circular(radius),
      ),
    );

void showTost({required String msg, required TostState state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: changeColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum TostState { SUCCESS, ERROR, WARNING }

Color changeColor(TostState state) {
  Color color;
  switch (state) {
    case TostState.SUCCESS:
      color = Colors.green;
      break;
    case TostState.ERROR:
      color = Colors.red;
      break;
    case TostState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget ListProdectItem(model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 200.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                height: 200.0,
                image: NetworkImage(model.product!.image!),
                // fit: BoxFit.cover,
                width: 200,
              ),
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    'discount'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 8.0),
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
                    model.product!.name!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20.0,
                      height: 1.6,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.product!.price.toString(),
                        style: const TextStyle(
                          color: defaultColor,
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          model.product!.oldPrice!.toString(),
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id!);
                            print(model.id!);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopCubit.get(context)
                                        .favorites[model.product!.id] ==
                                    true
                                ? defaultColor
                                : Colors.grey,
                            child: Icon(
                              color: Colors.white,
                              Icons.favorite_border,
                              size: 16.0,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
