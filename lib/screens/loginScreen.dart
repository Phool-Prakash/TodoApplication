import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_aap/customExtension/customExtension.dart';
import 'package:todo_aap/screens/todoScreen.dart';
import 'package:todo_aap/services/apiService.dart';
import 'package:todo_aap/theme/myColors.dart';
import 'package:todo_aap/widgets/customElevatedButton.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  ///Controllers
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  ///CircleIndicator
  bool _isLoading = false;

  //passwordVisibility
  bool obscureText = true;

  ///TextStyle
  final TextStyle textStyle = const TextStyle(
      color: ColorTheme.titleColor, fontSize: 16, fontWeight: FontWeight.w400);

  ///LogInFunction
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    ///ApiServiceCall
    final user = await ApiService()
        .authenticate(_usernameController.text, _passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => TodoScreen()));
    } else {
      ///Dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Invalid username or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text('We’re so excited to see you again!',
                style: GoogleFonts.hankenGrotesk(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: ColorTheme.greySemi,
                  ),
                )),
          ),
          const SizedBox(height: 30),

          ///AccountInfo
          const Text(
            'ACCOUNT INFORMATION',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ).padAll(12),
          const SizedBox(height: 10),

          ///Username
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'Email or phone number',
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ).padSymmetric(horizontal: 12),
          const SizedBox(height: 20),

          ///Password
          TextFormField(
            controller: _passwordController,
            obscureText: obscureText,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility),
                )),
          ).padSymmetric(horizontal: 12),
          const SizedBox(height: 10),

          ///forgotPassword
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Forgot your password?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 20),

          ///LogIn Button
          Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : Center(
                    child: CustomElevatedButton(
                            height: 58,
                            textSize: 14,
                            width: MediaQuery.of(context).size.width,
                            borderRadius: BorderRadius.circular(3),
                            text: 'LogIn',
                            onPressed: _login)
                        .padAll(10),
                  ),
          ),
        ],
      ),
    );
  }
}
