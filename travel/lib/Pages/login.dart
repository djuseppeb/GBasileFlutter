import 'package:flutter/material.dart';
import 'package:travel/components/login_field.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _controllerUsername = TextEditingController();
    final _controllerPassword = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.public, size: 24),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text("Travel App", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),),
                    ),
                    Icon(Icons.flight, size: 24),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                  child: LoginField(controller: _controllerUsername, fieldName: 'Username',),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                  child: LoginField(controller: _controllerPassword, fieldName: 'Password', hidden: true,),
                ),
                ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate()){
                    Navigator.of(context).popAndPushNamed("/home");
                  }
                }, child: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),))
              ],
            ),
            ),
        ),
      ),
    );
  }
}
