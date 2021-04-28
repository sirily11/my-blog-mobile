import 'package:flutter/material.dart';
import 'package:my_blog_app/models/UserProvider.dart';
import 'package:my_blog_app/pages/account/LoginView.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context);

    if (userProvider.hasLogined) {
      return Container(
        child: Center(
          child: Text("You are logined"),
        ),
      );
    }

    return LoginPage();
  }
}
