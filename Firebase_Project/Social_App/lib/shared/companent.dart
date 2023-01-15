import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social/social_cubit_global/socialcubit_global.dart';

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
  required bool isPass,
}) =>
    TextFormField(
      controller: textController,
      keyboardType: type,
      obscureText: isPass,
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
      decoration: BoxDecoration(
        color: backgraound,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          isUppercase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
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

void notificationsVerifiyEmail(context) => ConditionalBuilder(
      condition: SocialCubit.get(context).userModel != null,
      builder: (context) {
        var model = SocialCubit.get(context).userModel;
        return Column(
          children: [
            // if (!model!.isEmailVerified!)
            if (!FirebaseAuth.instance.currentUser!.emailVerified)
              Container(
                height: 50.0,
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline),
                      const SizedBox(
                        width: 15.0,
                      ),
                      const Expanded(child: Text('Please Verify Your Email')),
                      const SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.currentUser!
                                .sendEmailVerification()
                                .then((value) {
                              showTost(
                                  msg: 'Check Your Mail',
                                  state: TostState.SUCCESS);
                            }).catchError((error) {});
                          },
                          child: const Text('Send')),
                    ],
                  ),
                ),
              )
          ],
        );
      },
      fallback: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
