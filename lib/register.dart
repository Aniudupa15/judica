import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:judica/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String selectedRole = 'Citizen'; // Default role
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Register function
  void register() async {
    if (passwordController.text != confirmPasswordController.text) {
      displayMessageToUser("Passwords don't match!");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await createUserDocument(userCredential);

      if (context.mounted) {
        Navigator.pop(context); // Close the loading dialog if open
        displayMessageToUser('Registration successful!');
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'The account already exists for that email.';
          break;
        case 'invalid-email':
          message = 'The email provided is not valid.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }
      displayMessageToUser(message);
    } catch (e) {
      displayMessageToUser('An error occurred. Please try again.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createUserDocument(UserCredential userCredential) async {
    if (userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.email) // Use user UID as document ID
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
        'role': selectedRole,
      });
    }
  }

  void displayMessageToUser(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Judica"),
        backgroundColor: const Color.fromRGBO(255, 125, 41, 1),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/Background.jpg',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 238, 169, 1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 100,
                  ),
                ),
                const SizedBox(height: 20),
                // Username TextField
                _buildTextField(usernameController, 'Username', Icons.person_2_outlined),
                const SizedBox(height: 20),
                // Email TextField
                _buildTextField(emailController, 'Email', Icons.email_outlined),
                const SizedBox(height: 20),
                // Password TextField
                _buildTextField(passwordController, 'Password', Icons.remove_red_eye, obscureText: true),
                const SizedBox(height: 20),
                // Confirm Password TextField
                _buildTextField(confirmPasswordController, 'Confirm Password', Icons.remove_red_eye, obscureText: true),
                const SizedBox(height: 20),
                // Role Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      border: Border.all(color: Colors.black),
                    ),
                    child: DropdownButton<String>(
                      value: selectedRole,
                      isExpanded: true,
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRole = newValue!;
                        });
                      },
                      items: <String>['Citizen', 'Police', 'Judge']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 125, 41, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Register'),
                  ),
                ),
                const SizedBox(height: 20),
                // Navigate to Login page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  LoginPage()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, IconData icon, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 15.0, color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
