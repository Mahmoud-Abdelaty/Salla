// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/search_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/cubit_search.dart';
import 'package:shop_app/shared/cubit/states_search.dart';
import 'package:shop_app/shared/style/colors.dart';


class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  children:
                  [
                    myTextFormField(
                        keyboardType: TextInputType.text,
                        labelText: 'Search',
                        controller: searchController,
                        prefixIcon: Icons.search_rounded,
                        pixel: 30,
                        validator: (value)
                        {
                          if(value!.isEmpty){
                            return '           Please Enter Data to Search :(';
                          }
                          return null;
                        },
                        onFiledSubmitted: (text) {
                          if (formKey.currentState!.validate()) {
                            SearchCubit.get(context).search(text);
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).model?.data?.data?[index],context),
                          separatorBuilder: (context, index) => SizedBox(height: 10),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),);
  }

  Widget buildListProduct(Product? model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Container(
            height: 120,
            width: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children:
              [
                Image(image: NetworkImage(model?.image),
                  width: double.infinity,
                  height: 200,
                ),
                if(model?.discount != 0 && model?.discount != null)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                        horizontal: 5
                    ),
                    child: Text(
                      'Discount  ${model?.discount} %',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Text(
                  model?.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      height: 1.3
                  ),
                ),
                Spacer(),
                Row(
                  children :
                  [
                    Text(
                      '${model?.price}',
                      style: TextStyle(
                        fontSize: 12,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    if(model?.discount != 0 && model?.discount != null)
                      Text(
                        '${model?.oldPrice}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
