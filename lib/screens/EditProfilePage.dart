// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

// auth
import '../auth/Auth.dart';

// components
import '../../components/ProfilePictureURL.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Auth auth = Auth();
  User? user;

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      await auth.setName(_nameController.text);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    user = auth.getUserData();

    _nameController.text = user!.displayName ?? "";
    _emailController.text = user!.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await auth.updateProfilePicture(context);
                      setState(() {
                        user = auth.getUserData();
                      });
                    },
                    icon: ProfilePictureURL(type: "profile", URL: user?.photoURL ?? "", radius: 60),
                  ),
                ],
              ),
              SizedBox(height: 4),
              SizedBox(height: 14),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                validator: (value) {
                  if (value == "") return "Name should not be empty";
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(HugeIcons.strokeRoundedUser03),
                  hint: Text("Name"),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                readOnly: true,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == "") return "Name should not be empty";
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(HugeIcons.strokeRoundedMail01),
                  hint: Text("Email"),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              SizedBox(height: 14),
              ElevatedButton(
                onPressed: submitForm,
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(14)),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
                child: Text("Update Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
