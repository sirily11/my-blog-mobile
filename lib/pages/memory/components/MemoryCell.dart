import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_blog_app/models/MemoryProvider.dart';
import 'package:my_blog_app/objects/Memory.dart';
import 'package:my_blog_app/pages/dialogs/ConfirmDialog.dart';
import 'package:my_blog_app/pages/memory/components/Gallery.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class MemoryCell extends StatelessWidget {
  final Memory memory;

  const MemoryCell({Key? key, required this.memory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(
              memory.author!.username[0].toUpperCase(),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Text(
                    memory.author!.username,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    timeago.format(memory.date!),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                memory.content,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              if (memory.memoryImages.length > 0) _buildImageGrid1(context),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    color: Colors.grey,
                    onPressed: () {},
                    icon: Icon(
                      Icons.question_answer,
                    ),
                  ),
                  IconButton(
                    color: Colors.grey,
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite,
                    ),
                  ),
                  IconButton(
                    color: Colors.grey,
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                    ),
                  ),
                  IconButton(
                    color: Colors.grey,
                    onPressed: () async {
                      MemoryProvider memoryProvider =
                          Provider.of(context, listen: false);
                      var confirm = await showDialog<bool>(
                        context: context,
                        builder: (c) => ConfirmDialog(
                          content: 'Cannot undo',
                          title: "Do you want to delete",
                        ),
                      );

                      if (confirm != null && confirm) {
                        memoryProvider.deleteMemory(memory: memory);
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  )
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }

  Container _buildImageGrid1(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        itemCount: memory.memoryImages.length,
        itemBuilder: (context, index) {
          var image = memory.memoryImages[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (c) => ImageGallery(
                  initIndex: index,
                  images: memory.memoryImages,
                ),
              ),
            ),
            child: Hero(
              tag: "image-${image.id}",
              child: CachedNetworkImage(
                imageUrl: image.image,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (c, _, p) =>
                    CupertinoActivityIndicator(),
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
      ),
    );
  }
}
