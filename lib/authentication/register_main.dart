import 'package:flutter/material.dart';
import 'package:luxurycars/ResponsiveLayout.dart';
import 'package:luxurycars/authentication/register_page.dart';
import 'package:luxurycars/authentication/register_pc.dart';

class RegisterMain extends StatelessWidget {
  const RegisterMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        MobileScaffold: const Registerscreen(),
        TabletScaffold: const Registerscreen(),
        DesktopScaffold: const RegisterscreenPc());
  }
}
