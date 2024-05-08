import 'package:auth_sqlite_bloc/Views/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/AuthBloc/auth_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is LogoutState){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
            }
          },
          builder: (context, state) {
            if(state is Authenticated){
              return Text(state.loggedInUser.fullName!);
            }
            return Container();
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogoutEvent());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(child: Text("Hello")),
    );
  }
}
