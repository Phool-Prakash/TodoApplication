import 'dart:convert';

import 'package:todo_aap/utils/constants.dart';

import '../models/userModel.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<User?> authenticate(String username, String password) async {
    final response = await http.post(
        Uri.parse('${Constants.apiBaseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'username': username, 'password': password, 'expires': 30}));
    if (response.statusCode == 200) {
      print('LogIn Successfully');
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
