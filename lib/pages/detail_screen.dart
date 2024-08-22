import 'package:blogger/bloc/blog_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/api_service.dart';

class BlogDetailScreen extends StatefulWidget {
  final Blog blog;
  final bool isFav;

  BlogDetailScreen(this.blog, this.isFav);

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white60,
            )),
        title: Text(
          widget.blog.title,
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(imageUrl: widget.blog.imageUrl),
            const SizedBox(height: 16.0),
            Text(widget.blog.title,
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            //const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Row(
                children: [
                  Text(
                    "Times Now - 4h",
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                            color: Colors.white70)),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      widget.isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 15,
                    ),
                    onPressed: () {
                      context.read<BlogBloc>().add(MarkFavorite(widget.blog));
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share,
                      size: 15,
                      color: Colors.white60,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Details here",
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}
