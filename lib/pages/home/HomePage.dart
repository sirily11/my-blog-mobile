import 'package:flutter/material.dart';
import 'package:my_blog_app/models/UserProvider.dart';
import 'package:my_blog_app/pages/account/AccountView.dart';
import 'package:my_blog_app/pages/memory/MemoryListView.dart';
import 'package:my_blog_app/pages/memory/addMemory/AddMemoryPage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  initState() {
    UserProvider provider = Provider.of(context, listen: false);
    provider.autoLogin();
    super.initState();
  }

  AppBar _renderAppbar() {
    switch (_currentIndex) {
      case 1:
        return AppBar(
          title: Text("Article"),
        );

      case 2:
        return AppBar(
          title: Text("Account"),
        );
      default:
        return AppBar(
          title: Text("Memory"),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => AddMemoryPage(),
                ),
              ),
              icon: Icon(Icons.edit),
            )
          ],
        );
    }
  }

  Widget _renderBody() {
    switch (_currentIndex) {
      case 2:
        return AccountView();

      default:
        return MemoryListView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _renderAppbar(),
      body: _renderBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: "Memory",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: "Article",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Account",
          )
        ],
      ),
    );
  }
}
