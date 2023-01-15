import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/stats.dart';
import '../../shared/components/components.dart';

class SearchScrren extends StatelessWidget {
  const SearchScrren({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).search;
        TextEditingController searchController = TextEditingController();
        var isSearch = true;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    NewsCubit.get(context).getSearch(value);
                    print(value);
                  },
                  decoration: const InputDecoration(
                    label: Text('Search'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Can not Be Empty";
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: list.isNotEmpty,
                  builder: (context) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        BuildArticalItem(list[index], context),
                    separatorBuilder: (context, index) => Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.grey[200]),
                    itemCount: list.length,
                  ),
                  fallback: (context) => isSearch
                      ? Container()
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
