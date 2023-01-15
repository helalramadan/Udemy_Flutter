import 'package:conunter/cubit/cubit.dart';
import 'package:conunter/cubit/satats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => Counter_Cubit(),
      child: BlocConsumer<Counter_Cubit, Counter_Stat>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Counter"),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Counter_Cubit.get(context).mins();
                    },
                    child: const Text(
                      "MIUNS",
                    ),
                  ),
                  Text(
                    '${Counter_Cubit.get(context).counter}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Counter_Cubit.get(context).plus();
                    },
                    child: const Text(
                      "PLUS",
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
