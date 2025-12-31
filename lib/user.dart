import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Rwan"),
              accountEmail: Text("Rwan@gmail.come"),
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.pushNamed(context, "/home", arguments: 1);
              },
            ),
            ListTile(
              title: Text("create account"),
              onTap: () {
                Navigator.pushNamed(context, "/user");
              },
            ),
            ListTile(
              title: Text("ContactUsScreen"),
              onTap: () {
                Navigator.pushNamed(context, "/ContactUs");
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text("Login")),
      body: Form(
        child: Column(
          children: [
            // Name
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: Text("Enter your name"),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),

            // Email
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: Text("Enter your email"),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),

            // Password
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  label: Text("Enter your password"),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Login Button (الدخول مباشرة)
            ElevatedButton(
              onPressed: () {
                print(nameController.text);
                print(emailController.text);
                print(passwordController.text);

                Navigator.pushNamed(context, "/prodacts");
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
