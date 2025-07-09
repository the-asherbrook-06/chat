// packages
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

// Auth
import '../auth/Auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Auth auth = Auth();
  bool passwordObsure = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    void formSubmit() {
      if (formKey.currentState!.validate()) {
        auth.register(context, nameController.text, emailController.text, passwordController.text);
      }
    }

    void passwordObsureTrigger() {
      setState(() {
        passwordObsure = !passwordObsure;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(HugeIcons.strokeRoundedArrowLeft01),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: Text("Register to App", style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(height: 24),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Username is required';
                  if (value.length < 4) return 'Username should be longer than 4 characters';
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(HugeIcons.strokeRoundedUserCircle),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Email is required';
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(HugeIcons.strokeRoundedMail01),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: passwordObsure,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Password is required';
                  if (passwordController.text.length < 6 || passwordController.text.length > 16)
                    return 'Password length should be bwtween 6 to 16 characters';
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(HugeIcons.strokeRoundedSquareLockPassword),
                  suffixIcon: IconButton(
                    onPressed: passwordObsureTrigger,
                    icon: Icon(
                      passwordObsure
                          ? HugeIcons.strokeRoundedView
                          : HugeIcons.strokeRoundedViewOffSlash,
                    ),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              SizedBox(height: 14),
              TextFormField(
                controller: repeatPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: passwordObsure,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Password is required';
                  if (passwordController.text.length < 6 || passwordController.text.length > 16)
                    return 'Password length should be bwtween 6 to 16';
                  if (passwordController.text != repeatPasswordController.text)
                    return 'Passwords should match';
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Repeat Password",
                  prefixIcon: Icon(HugeIcons.strokeRoundedSquareLockPassword),
                  suffixIcon: IconButton(
                    onPressed: passwordObsureTrigger,
                    icon: Icon(
                      passwordObsure
                          ? HugeIcons.strokeRoundedView
                          : HugeIcons.strokeRoundedViewOffSlash,
                    ),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(width: 4),
                  Text("Already have an Account?", style: Theme.of(context).textTheme.bodyMedium),
                  TextButton(
                    style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                  onPressed: formSubmit,
                  child: Text("Register"),
                ),
              ),
              SizedBox(height: 6),
              Divider(),
              SizedBox(height: 6),
              Row(
                children: [
                  SizedBox(width: 4),
                  Text(
                    "Register with Social Accounts",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(width: 4),
                  IconButton(onPressed: () {}, icon: Icon(HugeIcons.strokeRoundedGoogle)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
