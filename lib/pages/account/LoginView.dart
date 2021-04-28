import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_blog_app/models/UserProvider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white),
        hintColor: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildLoginPanel(),
      ),
    );
  }

  Widget buildLoginPanel() {
    Widget textPanel = Column(
      children: [
        Spacer(
          flex: 4,
        ),
        Text(
          "Login",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(color: Colors.black),
            labelText: "Username",
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.black),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        ClipOval(
          child: Material(
            color: Colors.blue, // button color
            child: InkWell(
              splashColor: Colors.red, // inkwell color
              child: SizedBox(
                width: 50,
                height: 50,
                child: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                if (!isLoading) {
                  UserProvider loginProvider =
                      Provider.of(context, listen: false);
                  setState(() {
                    isLoading = true;
                  });

                  await loginProvider.login(
                    username: usernameController.text,
                    password: passwordController.text,
                  );
                }
              },
            ),
          ),
        ),
        Spacer(
          flex: 7,
        )
      ],
    );

    return Stack(
      children: [
        AnimatedOpacity(
          opacity: isLoading ? 0.2 : 1,
          duration: Duration(milliseconds: 300),
          child: textPanel,
        ),
        if (isLoading)
          Center(
            child: CupertinoActivityIndicator(),
          )
      ],
    );
  }
}
