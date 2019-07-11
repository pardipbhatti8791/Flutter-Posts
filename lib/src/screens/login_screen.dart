import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/forms.dart';
import 'package:flutter_app/src/screens/meetup_home_screen.dart';
import 'package:flutter_app/src/screens/register_screen.dart';
import 'package:flutter_app/src/services/auth_api_service.dart';
import 'package:flutter_app/src/utils/validators.dart';

class LoginScreen extends StatefulWidget {
  static final String route = '/login';
  final authApi = AuthApiService();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginFormData _loginData = LoginFormData();
  BuildContext _scaffoldContext;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _authvalidate = false;

  initState() {
    super.initState();

//    _emailController.addListener(() {
//      print(_emailController.text);
//    });
  }

  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    widget.authApi.login(_loginData).then((data) {
      Navigator.pushNamed(context, MeetupHomeScreen.route);
    }).catchError((err) {
      Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
        content: Text(err['errors']['message']),
      ));
    });
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _login();
    } else {
      setState(() {
        _authvalidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Builder(
        builder: (context) {
          _scaffoldContext = context;
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              autovalidate: _authvalidate,
              // Provide key
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      'Login And Explore',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextFormField(
                    key: _emailKey,
                    decoration: InputDecoration(hintText: 'Email Address'),
                    onSaved: (value) => _loginData.email = value,
                    validator: composeValidators('email', [
                      requiredValidator,
                      minLengthValidator,
                      emailValidator,
                    ]),
                  ),
                  TextFormField(
                    key: _passwordKey,
                    decoration: InputDecoration(hintText: 'Password'),
                    onSaved: (value) => _loginData.password = value,
                    validator: composeValidators('password', [
                      requiredValidator,
                      minLengthValidator,
                    ]),
                    obscureText: true,
                  ),
                  _buildLinks(),
                  Container(
//                    alignment: Alignment(-1.0, 0.0),
                    margin: EdgeInsets.only(top: 10.0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: const Text('Sign In'),
                      onPressed: _submit,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text('Login'),
      ),
    );
  }

  Widget _buildLinks() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RegsiterScreen.route),
            child: Text(
              'Not register yet? Register now',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, MeetupHomeScreen.route),
            child: Text(
              'Back to home',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
