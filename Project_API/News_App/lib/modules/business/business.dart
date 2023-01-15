import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var isSearch = false;
        var list = NewsCubit.get(context).business;
        return ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                BuildArticalItem(list[index], context),
            separatorBuilder: (context, index) => Container(
                height: 1.0, width: double.infinity, color: Colors.grey[200]),
            itemCount: list.length,
          ),
          fallback: (context) => isSearch
              ? Container()
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
