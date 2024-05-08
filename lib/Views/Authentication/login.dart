import 'package:auth_sqlite_bloc/Components/textfield.dart';
import 'package:auth_sqlite_bloc/Views/Authentication/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/AuthBloc/auth_bloc.dart';
import '../../Components/button.dart';
import '../home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if(state is Authenticated){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    }else if(state is ErrorState){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.toString())));
    }
  },
  builder: (context, state) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: Hero(
                        tag: "image",
                        child: Image.asset("assets/zaitoon.png")),
                  ),
                  InputField(
                      icon: Icons.account_circle_rounded,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                      controller: username,
                      hintText: "Username"),
                  InputField(
                     icon: Icons.lock,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      controller: password,
                      hintText: "Password"),
                  state is Loading? const CircularProgressIndicator() : Button(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                            LoginEvent(username.text, password.text));
                      }
                    },
                    label: "LOGIN",
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterScreen()));
                          },
                          child: const Text("REGISTER",style: TextStyle(color: Colors.purple),))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
