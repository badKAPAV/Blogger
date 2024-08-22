import 'package:blogger/services/api_service.dart';
import 'package:blogger/bloc/blog_bloc.dart';
import 'package:blogger/pages/detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(17, 17, 17, 1),
      appBar: AppBar(
        title: Text(
          'Blogger',
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
                onPressed: () {
                  context.read<BlogBloc>().add(FetchBlogs());
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white60,
                )),
          )
        ],
        backgroundColor: Colors.black87,
      ),
      body: BlocBuilder<BlogBloc, BlogState>(builder: (context, state) {
        if (state is BlogLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white70,
            ),
          );
        } else if (state is BlogLoaded) {
          return ListView.builder(
            itemCount: state.blogs.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final blog = state.blogs[index];
              return BlogTile(
                  title: state.blogs[index].title,
                  imageUrl: state.blogs[index].imageUrl,
                  isFav: state.favorites.contains(blog),
                  blog: state.blogs[index]);
            },
          );
        } else if (state is BlogError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(
              child:
                  Image(width: 200, image: AssetImage('assets/load_img.png')));
        }
      }),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isFav;
  final Blog blog;
  const BlogTile(
      {required this.title,
      required this.imageUrl,
      required this.isFav,
      required this.blog,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => BlogDetailScreen(blog, isFav)));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: CachedNetworkImage(imageUrl: imageUrl),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 10, bottom: 5, top: 5),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      title,
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
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
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                      size: 15,
                    ),
                    onPressed: () {
                      context.read<BlogBloc>().add(MarkFavorite(blog));
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
            const Divider(
              color: Colors.white24,
              height: 1,
              thickness: 1,
            )
          ],
        ),
      ),
    );
  }
}
