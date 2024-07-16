import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Image.asset('assets/discord_logo.png'),
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
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Join over 100 million people who use Discord to talk with communities and friends.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Daket')),
              ElevatedButton(onPressed: () {}, child: Text('Daket'))
            ],
          ),
        ),
      ),
    );
  }
}
