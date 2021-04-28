// To parse required this JSON data, do
//
//     final memory = memoryFromJson(jsonString);

import 'dart:convert';

Memory memoryFromJson(String str) => Memory.fromJson(json.decode(str));

String memoryToJson(Memory data) => json.encode(data.toJson());

class Memory {
  Memory({
    this.id,
    required this.content,
    required this.memoryImages,
    required this.memoryVideos,
    this.author,
    this.date,
  });

  int? id;
  String content;
  List<MemoryImage> memoryImages;
  List<MemoryVideo> memoryVideos;
  Author? author;
  DateTime? date;

  factory Memory.fromJson(Map<String, dynamic> json) => Memory(
        id: json["id"],
        content: json["content"],
        memoryImages: List<MemoryImage>.from(
            json["memory_images"].map((x) => MemoryImage.fromJson(x))),
        memoryVideos: List<MemoryVideo>.from(
            json["memory_videos"].map((x) => MemoryVideo.fromJson(x))),
        author: Author.fromJson(json["author"]),
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "memory_images":
            List<dynamic>.from(memoryImages.map((x) => x.toJson())),
        "memory_videos":
            List<dynamic>.from(memoryVideos.map((x) => x.toJson())),
        "author": author?.toJson(),
        "date": date?.toIso8601String(),
      };
}

class Author {
  Author({
    required this.url,
    required this.username,
    required this.email,
  });

  String url;
  String username;
  String email;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        url: json["url"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "username": username,
        "email": email,
      };
}

class MemoryImage {
  MemoryImage({
    required this.id,
    required this.image,
    required this.mid,
  });

  int id;
  String image;
  int mid;

  factory MemoryImage.fromJson(Map<String, dynamic> json) => MemoryImage(
        id: json["id"],
        image: json["image"],
        mid: json["mid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "mid": mid,
      };
}

class MemoryVideo {
  MemoryVideo({
    required this.id,
    required this.videoUrl,
    required this.mid,
  });

  int id;
  String videoUrl;
  int mid;

  factory MemoryVideo.fromJson(Map<String, dynamic> json) => MemoryVideo(
        id: json["id"],
        videoUrl: json["video_url"],
        mid: json["mid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video_url": videoUrl,
        "mid": mid,
      };
}
