import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../shared/components/components.dart';
class ScienceScreen extends StatelessWidget {
  var isSearch = false;

  ScienceScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var list = NewsCubit.get(context).science;
        return ConditionalBuilder(
          condition: list.length>0,
          builder: (context) => ListView.separated(
            // physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => BuildArticalItem(list[index], context),
            separatorBuilder: (context, index) => Container(
                height: 1.0, width: double.infinity, color: Colors.grey[200]),
            itemCount: list.length,
          ),
          fallback: (context) =>
          isSearch ? Container() : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
