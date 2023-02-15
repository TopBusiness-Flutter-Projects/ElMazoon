import 'package:elmazoon/core/utils/assets_manager.dart';
import 'package:elmazoon/core/widgets/customAppbar.dart';
import 'package:elmazoon/core/widgets/my_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
        ],
      ),
    );
  }
}
