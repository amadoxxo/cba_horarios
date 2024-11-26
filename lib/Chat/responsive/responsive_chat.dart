import 'package:flutter/material.dart';

class ResponsiveChat extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveChat({super.key, required this.mobileScreenLayout, required this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth > 900) {
        return webScreenLayout;
      }
      return mobileScreenLayout;
    });
  }
}