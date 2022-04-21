import 'package:flutter/material.dart';
import 'package:login/components/log_field.dart';
import 'package:login/components/menu_laterale.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  final _controllerUsername = TextEditingController(text: 'Username');
  final _controllerPassword = TextEditingController();

  final _registerkey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerMail = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerRegisterPsw = TextEditingController();
  final _controllerConfirmPsw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MenuLaterale(),
      appBar: AppBar(
        toolbarHeight: 24,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
/*
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
                    LogField(controller: _controllerUsername, fieldText: "Useraname", fieldHint: "name@example.com", fieldIcon: Icons.person),
                    LogField(controller: _controllerPassword, fieldText: "Password", fieldHint: "Password", fieldIcon: Icons.person, hidden: true,),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("L'username è ${_controllerUsername.text} e la password è ${_controllerPassword.text}"))
                          );
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
                            onPressed: () => print(
                                "Non trovo la G di google quindi ho messo il coniglietto"),
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
                    const SizedBox(height: 32),
                    const Text("Don't have an account? Sign up")
                  ],
                ),
              )
            ],
          ),
        ),
      ),


      */
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

                const SizedBox(height: 32),
                const Text("Already have an account? Log in")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
