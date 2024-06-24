import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes_sehatyuk/bloc/login/login_cubit.dart';
import 'package:tubes_sehatyuk/phone_auth_screen.dart';
import 'register_page.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailEdc = TextEditingController();
  final passEdc = TextEditingController();
  bool passInvisible = false;

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) return;

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName,
          'profileImageUrl': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false,
      );
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return BlocProvider(
            create: (context) => LoginCubit(),
            child: Builder(
              builder: (context) {
                return Scaffold(
                  backgroundColor: Color(0xFFFFCC00), // Changed background color to match design
                  body: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 80),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                "Welcome to Selamat!",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.02,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 50),
                              TextField(
                                controller: emailEdc,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 16),
                              TextField(
                                controller: passEdc,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passInvisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passInvisible = !passInvisible;
                                      });
                                    },
                                  ),
                                ),
                                obscureText: !passInvisible,
                              ),
                              SizedBox(height: 8), // Adjusted spacing
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    // Handle forgot password
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: Color(0xFF407BFF),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16), // Adjusted spacing
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final email = emailEdc.text;
                                    final password = passEdc.text;
                                    context
                                        .read<LoginCubit>()
                                        .login(email: email, password: password);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 132.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                  child: Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              BlocConsumer<LoginCubit, LoginState>(
                                listener: (context, state) {
                                  if (state is LoginSuccess) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                  } else if (state is LoginFailure) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Login failed: ${state.msg}")),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (state is LoginLoading) {
                                    return CircularProgressIndicator();
                                  }
                                  return Container();
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text(
                                      "Or Login with",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: Color(0x6A707CA6),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSocialLoginButton("images/google.png",
                                      signInWithGoogle),
                                  SizedBox(width: 16),
                                  _buildSocialLoginButton("images/facebook.png",
                                          () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => PhoneAuthScreen()));
                                      }),
                                  SizedBox(width: 16),
                                  _buildSocialLoginButton("images/phone.png",
                                          () {
                                        // Handle Apple login
                                      }),
                                ],
                              ),
                              SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage()),
                                      );
                                    },
                                    child: Text(
                                      "Register Now",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: Color(0xFF407BFF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        // Display loading indicator while waiting for Firebase to initialize
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildSocialLoginButton(String assetName, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 85,
        height: 70,
        decoration: BoxDecoration(
          color: Color(0xFFE8ECF4),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Color(0xFFE8ECF4),
          ),
        ),
        child: Center(
          child: Image.asset(assetName, width: 40, height: 40),
        ),
      ),
    );
  }
}
