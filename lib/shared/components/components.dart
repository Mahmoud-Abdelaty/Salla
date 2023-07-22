// ignore_for_file: prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable, unnecessary_string_interpolations, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unused_local_variable, avoid_types_as_parameter_names, non_constant_identifier_names, body_might_complete_normally_nullable
import 'package:flutter/material.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/style/colors.dart';



void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget,
  ),);

void navigateFrom(context, widget) => Navigator.pop(
  context,
  MaterialPageRoute(builder: (context) => widget,
  ),);



void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget,
  ),
    (Route)
    {
      return false;
    },
);

Widget myTextFormField(
{
  required TextInputType keyboardType,
  required String labelText,
  bool enabled = true,
  required TextEditingController controller,
  TextStyle? labelStyle,
  TextStyle? errorStyle,
  required IconData prefixIcon,
  IconData? suffixIcon,
  bool obscureText = false,
  required FormFieldValidator<String> validator,
  ValueChanged? onFiledSubmitted,
  ValueChanged? onChanged,
  AutovalidateMode? autoValidateMode,
  VoidCallback? suffixOnPressed,
  GestureTapCallback? onTap,
  Color color = Colors.indigo,
  Widget? child,
  double radius =20,
  double pixel = 40,

}) => TextFormField(
      keyboardType: keyboardType,
      onTap: onTap,
      enabled: enabled,
      autovalidateMode: autoValidateMode,
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      onChanged: onChanged,
      onFieldSubmitted: onFiledSubmitted,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          bottom: pixel,
        ),
        labelText: labelText,
        labelStyle: labelStyle,
        errorStyle: errorStyle,
        prefixIcon: Icon(
          prefixIcon,
          color: color,
        ),
        suffixIcon: suffixIcon==null?  null : IconButton(
          icon: Icon(
            suffixIcon,
            color: color,
          ),
          onPressed: suffixOnPressed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
              color: Colors.indigo,
              width: 2
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
              color: Colors.indigo,
              width: 2
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(
              color: Colors.red,
              width: 2
          ),

        ),
      ),
    );


Widget defaultButton
    (
    {
      double width = double.infinity,
      Color color = Colors.green,
      required String text,
      required Function onPressed,
      bool isUpperCase = true,
    })
=> Container(
  width: width,
  color: color,
  child: MaterialButton(
    onPressed: (){
      onPressed();
    },
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);






// Widget buildArticleItem(article, context) => InkWell(
//   onTap: ()
//   {
//     navigateTo(context, WebViewScreen(article['source']['name'],article['url']));
//   },
//   child:   Padding(
//
//     padding: const EdgeInsets.all(20.0),
//
//     child: Row(
//
//       children:
//
//       [
//
//         Container(
//
//           width: 120,
//
//           height: 120,
//
//           decoration: BoxDecoration(
//
//             borderRadius: BorderRadius.circular(10),
//
//             image: DecorationImage(
//
//               image: NetworkImage('${article['urlToImage']}'),
//
//               fit: BoxFit.cover,
//
//             ),
//
//           ),
//
//         ),
//
//         SizedBox(
//
//           width: 20,
//
//         ),
//
//         Expanded(
//
//           child: Container(
//
//             height: 120,
//
//             child: Column(
//
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//               mainAxisAlignment: MainAxisAlignment.start,
//
//               children:
//
//               [
//
//                 Expanded(
//
//                   child: Text(
//
//                     '${article['title']}',
//
//                     maxLines: 3,
//
//                     overflow: TextOverflow.ellipsis,
//
//                     style: Theme.of(context).textTheme.bodyText1,
//
//                   ),
//
//                 ),
//
//                 Text(
//
//                   '${article['publishedAt']}',
//
//                   style: TextStyle(
//
//                       color: Colors.grey
//
//                   ),
//
//                 ),
//
//               ],
//
//             ),
//
//           ),
//
//         ),
//
//       ],
//
//     ),
//
//   ),
// );

// Widget articleBuilder(list, context,{isSearch = false}) => ConditionalBuilder(
//   condition: list.isNotEmpty,
//   builder: (context) {
//     return ListView.separated(
//       physics: BouncingScrollPhysics(),
//       itemBuilder: (context, index) {
//         return buildArticleItem(list[index], context);
//       },
//       separatorBuilder: (context, index) => Padding(
//         padding: const EdgeInsetsDirectional.only(
//             start: 20
//         ),
//         child: Container(
//           color: Colors.deepOrange,
//           width: double.infinity,
//           height: 1,
//         ),
//       ),
//       itemCount: list.length,
//     );
//   },
//   fallback: (context) => isSearch ? Container()  : Center(child: CircularProgressIndicator()),
// );

Widget buildListProduct(model, context) => Padding(
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
              Image(image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
              ),
              if(model.discount != 0 && model.discount != null)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                      horizontal: 5
                  ),
                  child: Text(
                    'Discount  ${model.discount} %',
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
                model.name,
                maxLines: 4,
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
                    '${model.price}',
                    style: TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  if(model.discount != 0 && model.discount != null)
                    Text(
                      '${model.oldPrice}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor: defaultColor,
                        child: Icon(
                          ShopCubit.get(context).favorites[model.id]! ? Icons.favorite_rounded : Icons.heart_broken_rounded,
                          color: ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.white,
                          size: 20,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);