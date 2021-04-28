// To parse required this JSON data, do
//
//     final memory = memoryFromJson(jsonString);

import 'dart:convert';

Memory memoryFromJson(String str) => Memory.fromJson(json.decode(str));

String memoryToJson(Memory data) => json.encode(data.toJson());

class Memory {
  Memory({
    required this.id,
    required this.content,
    required this.memoryImages,
    required this.memoryVideos,
  });

  int id;
  String content;
  List<MemoryImage> memoryImages;
  List<MemoryVideo> memoryVideos;

  factory Memory.fromJson(Map<String, dynamic> json) => Memory(
        id: json["id"],
        content: json["content"],
        memoryImages: List<MemoryImage>.from(
            json["memory_images"].map((x) => MemoryImage.fromJson(x))),
        memoryVideos: List<MemoryVideo>.from(
            json["memory_videos"].map((x) => MemoryVideo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "memory_images":
            List<dynamic>.from(memoryImages.map((x) => x.toJson())),
        "memory_videos":
            List<dynamic>.from(memoryVideos.map((x) => x.toJson())),
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
