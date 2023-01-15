// ignore_for_file: non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../webview/webview.dart';

Widget BuildArticalItem(artical, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(url: artical['url']),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${artical['urlToImage']}'))),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${artical['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${artical['publishedAt']}',
                      style:
                          const TextStyle(fontSize: 15.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget ArticleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        // physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => BuildArticalItem(list[index], context),
        separatorBuilder: (context, index) => Container(
            height: 1.0, width: double.infinity, color: Colors.grey[200]),
        itemCount: list.length,
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );
Widget defultTextFormFild({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  required Function validator,
  Function? onSubmit,
  Function? onChage,
  Function? onTap,
  required String lable,
  IconData? prefix,
  IconData? suffix,
  Function? fsuffix,
}) =>
    TextFormField(
      validator: (value) => validator(value),
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTap: () {
        onTap!();
      },
      onFieldSubmitted: onSubmit != null ? (s) => onSubmit(s) : null,
      onChanged: onChage != null ? (s) => onChage(s) : null,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            fsuffix!();
          },
        ),
        border: const OutlineInputBorder(),
      ),
    );