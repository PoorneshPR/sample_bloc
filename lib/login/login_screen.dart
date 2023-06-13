import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_bloc/login/login_event.dart';
import 'package:sample_bloc/login/login_state.dart';

import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? emailController;
  TextEditingController? passwordController;
  LoginBloc? loginBloc;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() async {
    await loginBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bloc Login Sample")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          print(state);
          print("state is  : ${state}");
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: "Email", hintText: "Enter Email"),
              ),
              TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: "Password", hintText: "Enter your Password"),
                  obscureText: true),
              const SizedBox(
                height: 20,
              ),
              state is LoginLoadingState
                  ? const LinearProgressIndicator()
                  : SizedBox(),
              state is LoginSuccessState
                  ? Container(
                      height: 50,
                      color: Colors.green,
                      child: const Text("Logged In Successfully"),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        loginBloc?.add(InitLoginEvent(
                            email: (emailController?.text ?? ""),
                            password: passwordController?.text ?? ""));
                      },
                      child: const Text("Login"))
            ],
          );
        }),
      ),
    );
  }
}
