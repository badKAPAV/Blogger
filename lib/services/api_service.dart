import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as api;

class ApiService {
  final Box blogBox = Hive.box('blogsBox');
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> fetchBlogs() async {
    try {
      final response = await api.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      }).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        return compute(parseBlogs, response.body);
      } else {
        throw Exception(
            'Failed to load blogs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

List<Blog> parseBlogs(String responseBody) {
  final parsed = jsonDecode(responseBody)['blogs'].cast<Map<String, dynamic>>();
  return parsed.map<Blog>((json) => Blog.fromJson(json)).toList();
}

class Blog {
  final String id;
  final String title;
  final String imageUrl;
  Blog({required this.title, required this.imageUrl, required this.id});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] ?? '',
      imageUrl: json['image_url'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
