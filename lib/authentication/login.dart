import 'package:flutter/material.dart';
import 'package:luxurycars/ResponsiveLayout.dart';
import 'package:luxurycars/authentication/loginpage.dart';
import 'package:luxurycars/authentication/loginDesktop.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        MobileScaffold: const LoginScreen(),
        TabletScaffold: const LoginScreen(),
        DesktopScaffold: const LoginDesktop());
  }
}
