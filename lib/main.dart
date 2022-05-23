import 'package:bloc_state/cubits/counter/counter_cubit.dart';
import 'package:bloc_state/other_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*

      * bloc Consumer help to create bloc listener and builder at the same time 
      * without block listener if we go one page to another there will be a error
      * to prevent those error we have to wrap our widget in to a block listener 
      
      
      
      */
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.counter == 3) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('counter is ${state.counter}'),
                  );
                });
          } else if (state.counter == -1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OtherPage();
            }));
          }
        },
        //this part is for bloc listener
        //if we don't use the bloc listener there will be n error

        builder: (context, state) {
          return Center(
            child: Text(
              '${BlocProvider.of<CounterCubit>(context, listen: true).state.counter}',
              style: TextStyle(fontSize: 52.0),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increment();
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}
