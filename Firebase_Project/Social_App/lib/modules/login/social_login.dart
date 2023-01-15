import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social/layout/social_layout.dart';
import 'package:social/modules/Register/social_register.dart';
import 'package:social/modules/login/socialcubit/social_cubit.dart';
import 'package:social/modules/login/socialcubit/social_state.dart';

import 'package:social/shared/cache_helper.dart';

import 'package:social/shared/companent.dart';

class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showTost(msg: state.error, state: TostState.ERROR);
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
              navigetorAndFinish(context, SocialLayout_Screen());
            });
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Login Now To Communicate With Friend'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.grey[900],
                            fontWeight: FontWeight.w100,
                            fontSize: 20.0),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defultTextForm(
                        textController: emailController,
                        type: TextInputType.emailAddress,
                        lable: 'Email Address',
                        onChange: (value) {
                          print(value);
                        },
                        onSubmet: (value) {
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passWordController.text);
                          }
                        },
                        prefix: Icons.email,
                        isPass: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please enter your email address";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defultTextForm(
                        textController: passWordController,
                        type: TextInputType.visiblePassword,
                        lable: 'Password',
                        onChange: (value) {
                          print(value);
                        },
                        onSubmet: (value) {
                          print(value);
                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passWordController.text);
                          }
                        },
                        prefix: Icons.lock,
                        suffix: SocialLoginCubit.get(context).suffix,
                        suffixPressed: () {
                          SocialLoginCubit.get(context).changeIcon();
                        },
                        isPass: SocialLoginCubit.get(context).isPassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "password is late match";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => defultButton(
                            text: "login",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passWordController.text);
                              }
                            }),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don\'t Have an Account?"),
                          TextButton(
                              onPressed: () {
                                navigetorTo(context, SocialRegister());
                              },
                              child: Text("Register".toUpperCase()))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
