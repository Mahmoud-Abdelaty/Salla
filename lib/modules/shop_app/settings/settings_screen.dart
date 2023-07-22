// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/style/colors.dart';

class SettingsScreen extends StatefulWidget {

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var model = ShopCubit.get(context).userModel;

        nameController.text = model?.data?.name ?? '';
        emailController.text = model?.data?.email ?? '';
        phoneController.text = model?.data?.phone ?? '';

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children:
                  [
                    if(state is ShopLoadingUpdateUserDataState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    myTextFormField(
                        keyboardType: TextInputType.name,
                        labelText: 'Name',
                        controller: nameController,
                        prefixIcon: Icons.person,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Name mustn\'t Empty';
                          }
                          return '';
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        labelText: 'Email',
                        controller: emailController,
                        prefixIcon: Icons.email,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Email mustn\'t Empty';
                          }
                          return '';
                        }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    myTextFormField(
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone',
                        controller: phoneController,
                        prefixIcon: Icons.phone,
                        validator: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return 'Phone mustn\'t Empty';
                          }
                          return '';
                        }
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    defaultButton(
                        text: 'Update',
                        onPressed: ()
                        {
                          if(formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          }
                        },
                        color: defaultColor
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    defaultButton(
                        text: 'LogOut',
                        onPressed: ()
                        {
                          // ShopCubit.get(context).logout_(
                          //     token: model?.data?.token,
                          //   context: context,
                          // );
                          logout(context);
                          //print('Token : ${token!}');
                        },
                      color: defaultColor
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
