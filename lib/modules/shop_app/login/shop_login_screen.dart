// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, body_might_complete_normally_nullable, avoid_print, sized_box_for_whitespace
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/shop_app/register/shop_register_screen.dart';
import 'package:shop_app/modules/shop_app/shop_layout/shop_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit_login.dart';
import 'package:shop_app/shared/cubit/states_login.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';


class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state) {
          if(state is ShopLoginSuccessState)
            {
              if(state.loginModel.status!)
                {
                  CacheHelper.saveData(key:'t', value:state.loginModel.data!.token).then((value){
                      token = state.loginModel.data!.token;
                    navigateAndFinish(context, ShopLayout());
                  });
                  print('Message = ${state.loginModel.message}');
                  print('Token = ${state.loginModel.data!.token}');

                  Fluttertoast.showToast(
                      msg: state.loginModel.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.green,
                      textColor: Colors.black,
                      fontSize: 16.0
                  );
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
          ShopLoginCubit cubit = BlocProvider.of(context);
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
                        'Login',
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
                          cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text
                          );
                          //print('Email = ${emailController.text}');
                          // print('Password = ${passwordController.text}');
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                        },
                        prefixIcon: Icons.password_rounded,
                        suffixIcon: cubit.isSecure ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                        obscureText: cubit.isSecure,
                        suffixOnPressed: ()
                        {
                          cubit.securePassword();
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
                      ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 43,
                            child: MaterialButton(
                              color: Colors.indigo[300],

                              onPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text
                                  );
                                  //print('Email = ${emailController.text}');
                                  // print('Password = ${passwordController.text}');
                                  FocusScope.of(context).requestFocus(FocusNode());
                                }
                              },
                              child: Text(
                                'Login',
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
                            'Don\'t you have an account ?',
                            style: TextStyle(
                              color: Colors.indigo,
                            ),
                          ),
                          TextButton(onPressed: ()
                          {
                            navigateTo(context, ShopRegisterScreen());
                          },
                            child: Text(
                              'Register Now',
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
