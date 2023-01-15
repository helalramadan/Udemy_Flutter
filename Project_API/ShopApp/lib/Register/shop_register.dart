import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/login/logincubit/logincubit.dart';
import 'package:shopapp/login/logincubit/shopstate.dart';
import 'package:shopapp/login/shop_login.dart';
import 'package:shopapp/shared/companent.dart';

class ShopRegister extends StatelessWidget {
  ShopRegister({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopeLoginCubit(),
      child: BlocConsumer<ShopeLoginCubit, ShopeLoginState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status!) {
              nameController.text = '';
              emailController.text = '';
              phoneController.text = '';
              passWordController.text = '';
              showTost(
                  msg: state.registerModel.message!, state: TostState.SUCCESS);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                          'REGISTER',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          'register Now To Browse Our Hot Offers'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.w100,
                              fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defultTextForm(
                          textController: nameController,
                          type: TextInputType.text,
                          lable: 'user name'.toUpperCase(),
                          onChange: (value) {
                            print(value);
                          },
                          onSubmet: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopeLoginCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passWordController.text,
                              );
                            }
                          },
                          prefix: Icons.person,
                          isPass: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter your full name address"
                                  .toUpperCase();
                            }
                          },
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
                              ShopeLoginCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passWordController.text,
                              );
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
                          textController: phoneController,
                          type: TextInputType.phone,
                          lable: 'phone'.toUpperCase(),
                          onChange: (value) {
                            print(value);
                          },
                          onSubmet: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopeLoginCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passWordController.text,
                              );
                            }
                          },
                          prefix: Icons.phone,
                          isPass: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter your phone address"
                                  .toUpperCase();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defultTextForm(
                          textController: passWordController,
                          type: TextInputType.visiblePassword,
                          lable: 'Password'.toUpperCase(),
                          onChange: (value) {
                            print(value);
                          },
                          onSubmet: (value) {
                            print(value);
                            if (formKey.currentState!.validate()) {
                              ShopeLoginCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                password: passWordController.text,
                              );
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
                              return "password is late match".toUpperCase();
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defultButton(
                              text: "register".toUpperCase(),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopeLoginCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      phone: phoneController.text,
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
                                  navigetorTo(context, ShopLoginScreen());
                                },
                                child: Text("login".toUpperCase()))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
