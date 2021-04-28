import 'package:flutter/material.dart';
import 'package:my_blog_app/models/MemoryProvider.dart';
import 'package:my_blog_app/objects/Memory.dart';
import 'package:provider/provider.dart';

class AddMemoryPage extends StatefulWidget {
  @override
  _AddMemoryPageState createState() => _AddMemoryPageState();
}

class _AddMemoryPageState extends State<AddMemoryPage> {
  final TextEditingController textEditingController = TextEditingController();

  Future<void> _post() async {
    FocusScope.of(context).unfocus();
    String content = textEditingController.text;

    Memory memory =
        Memory(content: content, memoryImages: [], memoryVideos: []);

    MemoryProvider provider = Provider.of(context, listen: false);

    var m = await provider.addMemory(memory: memory);
    if (m != null) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await _post();
            },
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            child: GestureDetector(
              onVerticalDragEnd: (a) {
                FocusScope.of(context).unfocus();
              },
              child: TextField(
                controller: textEditingController,
                maxLines: 18,
                decoration: InputDecoration(
                  hintText: "Write something",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          _buildToolBar()
        ]),
      ),
    );
  }

  Row _buildToolBar() {
    return Row(
      children: [
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(
            Icons.image,
          ),
        ),
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(
            Icons.camera_alt,
          ),
        )
      ],
    );
  }
}
