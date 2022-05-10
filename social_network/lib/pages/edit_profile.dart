import 'package:flutter/material.dart';
import 'package:social_network/api/api_user.dart';
import 'package:social_network/components/bottom_bar.dart';
import 'package:social_network/components/top_bar.dart';

import '../models/user.dart';

class EditProfile extends StatefulWidget {
  final String userId;
  const EditProfile({required this.userId, Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late User userData;
  late Future<User> _futureUser;

  //Controller
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _titleController;
  late TextEditingController _phoneController;

  //Attributi modificati
  String? _newFirstName;
  String? _newLastName;
  String? _newGender;
  String? _newTitle;
  String? _newPhone;

  Future<User> _fetchUserData(String id) async{
    return userData = await ApiUser.getUserById(id);
  }

  updateUserData(User newUserData) async{
    await ApiUser.updateUser(newUserData, widget.userId);
  }

  void initVars(){
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _genderController = TextEditingController();
    _titleController = TextEditingController();
    _phoneController = TextEditingController();
  }

  void initControllers() {
    _firstNameController.text = userData.firstName ?? '';
    _lastNameController.text = userData.lastName ?? '';
    _genderController.text = userData.gender ?? '';
    _titleController.text = userData.title ?? '';
    _phoneController.text = userData.phone ?? '';
  }

  @override
  void initState() {
    super.initState();
    _futureUser = _fetchUserData(widget.userId);
    initVars();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(title: "Modifica informazioni"),
      bottomNavigationBar: const BottomBar(currentPage: "profilo"),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FutureBuilder(
              future: _futureUser,
              builder: (context, snapshot){
                if (snapshot.hasData && snapshot.data is User){
                  initControllers();
                  return ListView(
                    children: [
                      TextFormField(
                        controller: _firstNameController,
                        onChanged: (value) {
                          _newFirstName = _firstNameController.text;
                        },
                        decoration: const InputDecoration(
                          labelText: "Nome",
                        ),
                      ),

                      TextFormField(
                        controller: _lastNameController,
                        onChanged: (value) {
                          _newLastName = _lastNameController.text;
                        },
                        decoration: const InputDecoration(
                          labelText: "Cognome",
                        ),
                      ),

                      TextFormField(
                        controller: _genderController,
                        onChanged: (value) {
                          _newGender = _genderController.text;
                        },
                        decoration: const InputDecoration(
                          labelText: "Genere",
                        ),
                      ),

                      TextFormField(
                        controller: _titleController,
                        onChanged: (value) {
                          _newTitle = _titleController.text;
                        },
                        decoration: const InputDecoration(
                          labelText: "Titolo",
                        ),
                      ),

                      TextFormField(
                        controller: _phoneController,
                        onChanged: (value) {
                          _newPhone = _phoneController.text;
                        },
                        decoration: const InputDecoration(
                          labelText: "Numero di telefono",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: const Text("Valori iniziali"),
                            onPressed: (){
                              initControllers();
                            },
                          ),
                          TextButton(
                            child: const Text("Salva modifica"),
                            onPressed: (){
                              User newData = User(
                                  firstName: _newFirstName,
                                  lastName: _newLastName,
                                  gender: _newGender,
                                  title: _newTitle,
                                  phone: _newPhone
                              );
                              updateUserData(newData);
                            },
                          )
                        ],
                      )
                    ],
                  );
                }
                if (snapshot.hasError){
                  return Center(
                      child: Text("Errore nel caricamento: ${snapshot.error}", style: const TextStyle(fontSize: 24),)
                  );
                }
                return const Center(
                    child: CircularProgressIndicator()
                );
              },
            ),
          )
      ),
    );
  }
}
