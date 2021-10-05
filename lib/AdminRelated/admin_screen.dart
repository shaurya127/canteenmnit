import 'package:flutter/material.dart';

import './AdminScreen/mainBody.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: MainAdminBody(),
    );
  }
}
