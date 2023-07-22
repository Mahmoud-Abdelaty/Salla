// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_print, prefer_const_constructors, sized_box_for_whitespace

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/shop_app/shop_layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit_Register.dart';
import 'package:shop_app/shared/cubit/states_Register.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget{

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
          listener: (context,state) {
            if(state is ShopRegisterSuccessState)
            {
              if(state.loginModel.status!)
              {
                Fluttertoast.showToast(
                    msg: state.loginModel.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.green,
                    textColor: Colors.black,
                    fontSize: 16.0
                );
                print('Message = ${state.loginModel.message}');
                print('Token = ${state.loginModel.data!.token}');

                CacheHelper.saveData(key:'t', value: state.loginModel.data!.token).then((value){
                  token = state.loginModel.data!.token;
                  navigateAndFinish(context, ShopLayout());
                });
              }
              else{
                Fluttertoast.showToast(
                    msg: state.loginModel.message,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 14.0
                );
                print(state.loginModel.message);
              }
            }
          },
          builder: (context,state)
          {
            return Form(
              key: formKey,
              child: Scaffold(
                appBar: AppBar(),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal:25,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                      [
                        Image(
                          image: AssetImage('assets/images/shopLogo.png'),
                          height: 150,
                          width: 200,
                          color: Colors.indigo[200],
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.indigo
                          ),
                        ),
                        Text(
                          'Welcome To MyShopApp to browse our hot offers :)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        myTextFormField(
                          keyboardType: TextInputType.text,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          controller: nameController,
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.indigoAccent,
                          ),
                          errorStyle: TextStyle(
                              color: Colors.red
                          ),
                          pixel: 30,
                          prefixIcon: Icons.email_outlined,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return '       Name mustn\'t be Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        myTextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.indigoAccent,
                          ),
                          errorStyle: TextStyle(
                              color: Colors.red
                          ),
                          pixel: 30,
                          prefixIcon: Icons.email_outlined,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return '       Email mustn\'t be Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        myTextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          labelText: 'Password',
                          pixel: 30,
                          onFiledSubmitted: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone:phoneController.text,
                              );
                              print('Name = ${nameController.text}');
                              print('Email = ${emailController.text}');
                              print('Password = ${passwordController.text}');
                              print('Phone = ${phoneController.text}');
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          },
                          prefixIcon: Icons.password_rounded,
                          suffixIcon: ShopRegisterCubit.get(context).isSecure ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                          obscureText: ShopRegisterCubit.get(context).isSecure,
                          suffixOnPressed: ()
                          {
                            ShopRegisterCubit.get(context).securePassword();
                          },
                          validator: (value)
                          {
                            if(value!.isEmpty || value.length < 6)
                            {
                              return '       Password mustn\'t be less 6';
                            }
                            return null;
                          },
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.indigoAccent,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        myTextFormField(
                          keyboardType: TextInputType.phone,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          controller: phoneController,
                          labelText: 'Phone',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.indigoAccent,
                          ),
                          errorStyle: TextStyle(
                              color: Colors.red
                          ),
                          pixel: 30,
                          prefixIcon: Icons.email_outlined,
                          validator: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return '       Phone mustn\'t be Empty';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 43,
                            child: MaterialButton(
                              color: Colors.indigo[300],
                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ShopRegisterCubit.get(context).userRegister(
                                      name:nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone:phoneController.text,
                                  );
                                  print('Name = ${nameController.text}');
                                  print('Email = ${emailController.text}');
                                  print('Password = ${passwordController.text}');
                                  print('Phone = ${phoneController.text}');
                                  FocusScope.of(context).requestFocus(FocusNode());
                                }
                              },
                              child: Text(
                                  'Register & Login',
                                style: TextStyle(
                                    fontSize: 18
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(
                            backgroundColor: Colors.indigo[100],
                          )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Do you have an account ?',
                              style: TextStyle(
                                color: Colors.indigo,
                              ),
                            ),
                            TextButton(onPressed: ()
                            {
                              Navigator.pop(context);
                            },
                              child: Text(
                                'Login Now',
                                style: TextStyle(
                                    color: Colors.indigo
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
