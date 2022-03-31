import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopapp/components/auth_form.dart';
import 'package:flutter_svg/svg.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.topEnd,
                colors: [
                  Color.fromRGBO(131, 208, 201, 1),
                  Colors.white,
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: deviceSize.height * 0.25,
                      width: double.infinity,
                      child: Image.asset("assets/images/please.png"),
                    ),
                    AuthForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
