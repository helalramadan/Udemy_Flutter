import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/login/shop_login.dart';
import 'package:shopapp/shared/cache_helper.dart';
import 'package:shopapp/shared/companent.dart';

import 'package:shopapp/shop_cubit/shopcubit.dart';
import 'package:shopapp/shop_cubit/shopstate.dart';

class ShopSettings extends StatelessWidget {
  @override
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        if (state is ShopUpdateUserSuccessState) {
          if (state.userData.status!) {
            showTost(msg: state.userData.message!, state: TostState.SUCCESS);
          }
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).GetUserModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
            condition: ShopCubit.get(context).GetUserModel != null,
            builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          if (state is ShopUpdateUserSuccessState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 20.0,
                          ),
                          defultTextForm(
                              textController: nameController,
                              type: TextInputType.text,
                              isPass: false,
                              validator: (value) {
                                if (value.isEmpty || value == null) {
                                  return 'Name Most Not Be Empty';
                                }
                                return null;
                              },
                              prefix: Icons.person,
                              lable: "Name"),
                          SizedBox(
                            height: 20.0,
                          ),
                          defultTextForm(
                              textController: emailController,
                              type: TextInputType.emailAddress,
                              isPass: false,
                              validator: (value) {
                                if (value.isEmpty || value == null) {
                                  return 'Email Most Not Be Empty';
                                }
                                return null;
                              },
                              prefix: Icons.email,
                              lable: "Email Address"),
                          SizedBox(
                            height: 20.0,
                          ),
                          defultTextForm(
                              textController: phoneController,
                              type: TextInputType.phone,
                              isPass: false,
                              validator: (value) {
                                if (value.isEmpty || value == null) {
                                  return 'Email Most Not Be Empty';
                                }
                                return null;
                              },
                              prefix: Icons.phone,
                              lable: "Email Address"),
                          SizedBox(
                            height: 40.0,
                          ),
                          defultButton(
                              text: 'update',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopCubit.get(context).updateUserModels(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              }),
                          SizedBox(
                            height: 40.0,
                          ),
                          defultButton(
                              text: 'Sign Out',
                              onPressed: () {
                                CacheHelper.removeData('token').then((value) {
                                  if (value!) {
                                    navigetorAndFinish(
                                        context, ShopLoginScreen());
                                  }
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                ),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }
}
