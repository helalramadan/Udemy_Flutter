import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/Register/shop_register.dart';
import 'package:shopapp/layout/shop_layout.dart';
import 'package:shopapp/login/logincubit/logincubit.dart';
import 'package:shopapp/login/logincubit/shopstate.dart';
import 'package:shopapp/shared/cache_helper.dart';
import 'package:shopapp/shared/companent.dart';
import 'package:shopapp/shared/stayle/constans.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopeLoginCubit(),
      child: BlocConsumer<ShopeLoginCubit, ShopeLoginState>(
        listener: (context, state) {
          if (state is loginSuccessState) {
            if (state.loginModel.status!) {
              print('message: ${state.loginModel.message!}');
              print('token: ${state.loginModel.data!.token}');
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                navigetorAndFinish(context, ShopLayout_Screen());
              });
            } else {
              showTost(msg: state.loginModel.message!, state: TostState.ERROR);
              print(state.loginModel.message!);
            }
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
                        'Login Now To Browse Our Hot Offers',
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
                            ShopeLoginCubit.get(context).userLogin(
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
                            ShopeLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passWordController.text);
                          }
                        },
                        prefix: Icons.lock,
                        suffix: ShopeLoginCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopeLoginCubit.get(context).changeIcon();
                        },
                        isPass: ShopeLoginCubit.get(context).isPassword,
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
                        condition: state is! loginLoadingState,
                        builder: (context) => defultButton(
                            text: "login",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopeLoginCubit.get(context).userLogin(
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
                                navigetorTo(context, ShopRegister());
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
