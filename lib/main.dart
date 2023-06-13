import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_bloc/bloc/my_bloc.dart';
import 'package:sample_bloc/login/login_bloc.dart';
import 'package:sample_bloc/login/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const LoginScreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MyBloc _bloc = MyBloc();

  @override
  void dispose() {
    // Dispose the BLoC
    _bloc.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _bloc.myStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                  ("Processed event clicked  ${snapshot.data.toString()}") ??
                      "");
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bloc.processEvent(_bloc.i);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
