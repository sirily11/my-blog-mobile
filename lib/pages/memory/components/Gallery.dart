import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart' hide MemoryImage;
import 'package:flutter/material.dart' hide MemoryImage;
import 'package:my_blog_app/objects/Memory.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageGallery extends StatefulWidget {
  final List<MemoryImage> images;
  final int initIndex;

  ImageGallery({required this.images, required this.initIndex});

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: PhotoViewGallery.builder(
              scrollPhysics: BouncingScrollPhysics(),
              itemCount: widget.images.length,
              pageController: pageController,
              loadingBuilder: (context, pr) => Center(
                    child: CupertinoActivityIndicator(),
                  ),
              builder: (context, index) {
                var image = widget.images[index];
                return PhotoViewGalleryPageOptions(
                  heroAttributes:
                      PhotoViewHeroAttributes(tag: "image-${image.mid}"),
                  imageProvider: CachedNetworkImageProvider(
                    image.image,
                  ),
                );
              }),
        ),
        Positioned(
            top: 100,
            left: 10,
            child: IconButton(
              color: Colors.white,
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
            ))
      ],
    );
  }
}
