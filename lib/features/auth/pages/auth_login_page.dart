import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/features/auth/components/background.dart';
import 'package:shop/features/auth/components/auth_form.dart';

class AuthLoginPage extends StatelessWidget {
  const AuthLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 70,
                  ),
                  transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepOrange.shade900,
                  ),
                  child: Text(
                    'Minha Loja',
                    style: TextStyle(
                      fontSize: 45,
                      fontFamily: 'Anton',
                      color: Colors.white,
                    ),
                  ),
                ),
                AuthForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
