import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_aap/customExtension/customExtension.dart';
import 'package:todo_aap/screens/loginScreen.dart';
import 'package:todo_aap/theme/myColors.dart';
import 'package:todo_aap/theme/sizeStyle.dart';
import 'package:todo_aap/widgets/customElevatedButton.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              Image.asset('assets/discord_logo.png'),
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/illustration.png'),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Welcome to Discord',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Join over 100 million people who use Discord to talk with communities and friends.',
                textAlign: TextAlign.center,
                style: GoogleFonts.hankenGrotesk(
                    textStyle: const TextStyle(
                        color: ColorTheme.greySemi, fontSize: 14)),
              ).padAll(12),

              ///Register Button
              CustomElevatedButton(
                  width: 335,
                  borderRadius: BorderRadius.circular(3),
                  text: 'Register',
                  textSize: 14,
                  onPressed: () {}),

              ///LogInButton
              CustomElevatedButton(
                  width: 335,
                  borderRadius: BorderRadius.circular(3),
                  buttonColor: ColorTheme.buttonGrey,
                  text: 'LogIn',
                  textSize: 14,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const LogInScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
