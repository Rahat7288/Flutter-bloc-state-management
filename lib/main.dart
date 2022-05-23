import 'package:bloc_state/blocs/counter/counter_bloc.dart';
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
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
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
      body: BlocListener<CounterBloc, CounterState>(
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
        child: Center(
          child: Text(
            '${context.watch<CounterBloc>().state.counter}',
            style: TextStyle(fontSize: 52.0),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterBloc>(context)
                  .add(IncrementCounterEvent());
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(
            width: 10.0,
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(DecrementCounterEvent());
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}
