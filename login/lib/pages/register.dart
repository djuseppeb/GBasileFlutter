import 'package:flutter/material.dart';

import '../components/log_field.dart';
import '../components/menu_laterale.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _registerkey = GlobalKey<FormState>();
    final _controllerName = TextEditingController();
    final _controllerMail = TextEditingController();
    final _controllerPhone = TextEditingController();
    final _controllerRegisterPsw = TextEditingController();
    final _controllerConfirmPsw = TextEditingController();

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
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                const Text(
                  "Let's get started!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text("Create an account to Q Allure to get all features",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center),
                const SizedBox(height: 32),
                Form(
                  key: _registerkey,
                  child: Column(
                    children: [
                      LogField(
                          controller: _controllerName,
                          fieldText: "Name",
                          fieldHint: "Mario Rossi",
                          fieldIcon: Icons.person),
                      LogField(
                          controller: _controllerMail,
                          fieldText: "Email",
                          fieldHint: "name@example.com",
                          fieldIcon: Icons.mail),
                      LogField(
                          controller: _controllerPhone,
                          fieldText: "Phone",
                          fieldHint: "+39123123123",
                          fieldIcon: Icons.phone),
                      LogField(
                          controller: _controllerRegisterPsw,
                          fieldText: "Password",
                          fieldHint: "Password",
                          fieldIcon: Icons.lock,
                          hidden: true),
                      LogField(
                          controller: _controllerConfirmPsw,
                          fieldText: "Confirm Password",
                          fieldHint: "Confirm Password",
                          fieldIcon: Icons.lock,
                          hidden: true),
                    ],
                  ),
                ),
                ElevatedButton(
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: Text(
                      "LOG IN",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                            "Benvenuto/a ${_controllerName.text} ti sei registrato con successo con la mail ${_controllerMail.text} e il numero di telefono ${_controllerPhone.text}"),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blue.shade700),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).popAndPushNamed('/login');
                  },
                  child: const Text(
                    "Already have an account? Log in",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
