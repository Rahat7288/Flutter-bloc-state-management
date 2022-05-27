import 'dart:math';
import 'package:bloc_state/cubits/counter/counter_cubit.dart';
import 'package:bloc_state/other_page.dart';
import 'package:bloc_state/theme/cubit/theme_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/color/color_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
        BlocProvider(
            create: (context) =>
                CounterCubit(colorCubit: context.read<ColorCubit>()))
      ],
      child: MaterialApp(
        title: 'Cubit2Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorCubit>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<ColorCubit>().changeColor();
                },
                child: Text(
                  'Change Color',
                  style: TextStyle(fontSize: 24.0),
                )),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '${context.watch<CounterCubit>().state.counter}',
              style: TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<CounterCubit>().changeCounter();
                },
                child: Text(
                  'Increment Number',
                  style: TextStyle(fontSize: 24.0),
                )),
          ],
        ),
      ),
    );
  }
}
