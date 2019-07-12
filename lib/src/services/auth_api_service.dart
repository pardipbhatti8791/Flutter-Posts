import 'package:flutter_app/src/models/User.dart';
import 'package:flutter_app/src/models/forms.dart';
import 'package:flutter_app/src/models/register_form_data.dart';
import 'package:flutter_app/src/utils/jwt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {

  /**
   * @initalVariables
   */
  final String url = Platform.isIOS
      ? 'http://localhost:3001/api/v1'
      : 'http://10.0.2.2:3001/api/v1';
  String _token = '';
  User _authUser;

  static final AuthApiService _singleton = AuthApiService._internal();

  factory AuthApiService() {
    return _singleton;
  }

  AuthApiService._internal();

  set authUser(Map<String, dynamic> value) {
    _authUser = User.fromJSON(value);
  }

  get authUser => _authUser;

  Future<String> get token async {
    if(_token.isNotEmpty) {
      return _token;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('tribeToken');
    }
  }

  Future<bool> _persistToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('tribeToken', token);
  }

  Future<bool> _saveToken(String token) async {
    if (token != null) {
      await _persistToken(token);
      _token = token;
      return true;
    }

    return false;
  }

  Future<bool> isAuthenticated() async {
    final token = await this.token;
    if(token.isNotEmpty) {

      final decodedToken = decode(token);
      final bool isValidToken = decodedToken['exp'] * 1000 > DateTime.now().millisecond;
      if(isValidToken) {
        authUser = decodedToken;
      }
      return isValidToken;
    }

    return false;
  }

  _removeAuthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('tribeToken');
    _token = '';
    _authUser = null;
  }

  Future<bool> logout() async {
    try {
      await _removeAuthData();
    } catch(error) {
      print(error);
    }
  }

  /**
   * @function : login
   * @description: let user login
   */
  Future<Map<String, dynamic>> login(LoginFormData loginData) async {
    final body = json.encode(loginData.toJSON());
    final response = await http.post('$url/users/login',
        headers: {"Content-Type": "application/json"}, body: body);

    final parsedData = Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      await _saveToken(parsedData['token']);

      authUser = parsedData;
      return parsedData;
    } else {
      return Future.error(parsedData);
    }
  }
  
  /**
   * @function : register
   * @description: let user register
   */
  Future<bool> register(RegisterFormData loginData) async {
    final body = json.encode(loginData.toJSON());
    final response = await http.post('$url/users/register',
        headers: {"Content-Type": "application/json"}, body: body);

    final parsedData = Map<String, dynamic>.from(json.decode(response.body));

    if (response.statusCode == 200) {
      await _saveToken(parsedData['token']);
      return true;
    } else {
      return Future.error(parsedData);
    }
  }
}
