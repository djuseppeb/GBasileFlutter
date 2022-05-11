import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_network/components/login_card.dart';
import 'package:social_network/components/logo.dart';


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.pink.shade50, Colors.deepPurple.shade200, ]
          )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Logo
                const Logo(),
                //User Selection
                const SizedBox(height: 60,),
                Column(
                  children: [
                    Text("Seleziona l'utente con cui effettuare l'accesso", style: GoogleFonts.ubuntu(fontSize: 16, color: Colors.black54)),
                    const SizedBox(height: 24,),
                    Row(
                      children: const [
                        Expanded(child: LoginCard(id: '60d0fe4f5311236168a109ca', firstName: 'Sara', lastName: 'Andersen', imageUrl: "https://randomuser.me/api/portraits/women/58.jpg")),
                        Expanded(child: LoginCard(id: '60d0fe4f5311236168a109cd', firstName: 'Roberto', lastName: 'Vega', imageUrl: "https://randomuser.me/api/portraits/med/men/25.jpg")),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
