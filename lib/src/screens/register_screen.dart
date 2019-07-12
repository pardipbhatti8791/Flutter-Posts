import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/src/models/arguments.dart';
import 'package:flutter_app/src/models/register_form_data.dart';
import 'package:flutter_app/src/services/auth_api_service.dart';
import 'package:flutter_app/src/utils/validators.dart';

class RegisterScreen extends StatefulWidget {
  static final String route = '/register';
  final AuthApiService _auth = AuthApiService();

  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  // 1. Create GlobalKey for form
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  // 2. Create autovalidate
  bool _registerValidate = false;

  // 3. Create instance of RegisterFormData
  RegisterFormData _registerData = RegisterFormData();

  _handleSuccess(data) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
      (Route<dynamic> route) => false,
      arguments: LoginScreenArguments('You have been successfully registered'),
    );
  }

  _handleError(error) {
    print(error);
  }

  // 4. Create Register function and print all of the data
  _register() {
    widget._auth
        .register(_registerData)
        .then(_handleSuccess)
        .catchError(_handleError);
  }

  _submit() {
    if (_registerFormKey.currentState.validate()) {
      _registerFormKey.currentState.save();
      _register();
    } else {
      setState(() => _registerValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Register')),
        body: Builder(builder: (context) {
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _registerFormKey,
                autovalidate: _registerValidate,
                child: ListView(
                  children: [
                    _buildTitle(),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      validator: composeValidators('name', [
                        requiredValidator,
                      ]),
                      onSaved: (value) => _registerData.name = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                      validator: composeValidators('username', [
                        requiredValidator,
                      ]),
                      onSaved: (value) => _registerData.username = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: composeValidators(
                          'email', [requiredValidator, emailValidator]),
                      onSaved: (value) => _registerData.email = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Avatar Url',
                      ),
                      keyboardType: TextInputType.url,
                      validator:
                          composeValidators('avatar', [requiredValidator]),
                      onSaved: (value) => _registerData.avatar = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      validator: composeValidators(
                          'password', [requiredValidator, minLengthValidator]),
                      onSaved: (value) => _registerData.password = value,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password Confirmation',
                      ),
                      obscureText: true,
                      validator: composeValidators('passwordConfirmation',
                          [requiredValidator, minLengthValidator]),
                      onSaved: (value) =>
                          _registerData.passwordConfirmation = value,
                    ),
                    _buildLinksSection(),
                    _buildSubmitBtn()
                  ],
                ),
              ));
        }));
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Text(
        'Register Today',
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
        child: RaisedButton(
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      child: const Text('Submit'),
      onPressed: _submit,
    ));
  }

  Widget _buildLinksSection() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/login");
            },
            child: Text(
              'Already Registered? Login Now.',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/meetups");
              },
              child: Text(
                'Continue to Home Page',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      ),
    );
  }
}
