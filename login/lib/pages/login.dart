import 'package:flutter/material.dart';

import '../components/log_field.dart';
import '../components/menu_laterale.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    final _controllerUsername = TextEditingController(text: 'Username');
    final _controllerPassword = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MenuLaterale(),
      appBar: AppBar(
        toolbarHeight: 24,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                  child: Image.asset(
                'assets/login.jpg',
                width: 150,
                height: 150,
              )),
              const Text(
                "Welcome back!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text("Log in to your account of Q Allure!",
                  style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
              const SizedBox(height: 32),
              Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    LogField(
                        controller: _controllerUsername,
                        fieldText: "Useraname",
                        fieldHint: "name@example.com",
                        fieldIcon: Icons.person),
                    LogField(
                      controller: _controllerPassword,
                      fieldText: "Password",
                      fieldHint: "Password",
                      fieldIcon: Icons.person,
                      hidden: true,
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot password?",
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          child: Text(
                            "LOG IN",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "L'username è ${_controllerUsername.text} e la password è ${_controllerPassword.text}")));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue.shade700),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ))),
                    const SizedBox(height: 8),
                    const Text(
                      "Or connect using",
                      style: TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Icon(Icons.facebook),
                                  Text(
                                    "Facebook",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () => print("Accesso con facebook"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade900),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ))),
                        ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Icon(Icons.cruelty_free),
                                  Text(
                                    "Google",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () => print("Accesso con Google"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.red.shade900),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ))),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('/register');
                      },
                      child: const Text("Don't have an account? Sign up"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
