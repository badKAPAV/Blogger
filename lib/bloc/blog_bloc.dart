import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/api_service.dart';

abstract class BlogEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBlogs extends BlogEvent {}

class MarkFavorite extends BlogEvent {
  final Blog blog;

  MarkFavorite(this.blog);

  @override
  List<Object> get props => [blog];
}

abstract class BlogState extends Equatable {
  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Blog> blogs;
  final List<Blog> favorites;
  BlogLoaded(this.blogs, this.favorites);
  @override
  List<Object> get props => [blogs, favorites];
}

class BlogError extends BlogState {
  final String message;
  BlogError(this.message);
  @override
  List<Object> get props => [message];
}

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final ApiService apiService;
  BlogBloc(this.apiService) : super(BlogInitial()) {
    on<FetchBlogs>((event, emit) async {
      emit(BlogLoading());
      try {
        final blogs = await apiService.fetchBlogs();
        emit(BlogLoaded(blogs, []));
      } catch (e) {
        emit(BlogError('Failed to fetch blogs'));
      }
    });

    on<MarkFavorite>((event, emit) {
      if (state is BlogLoaded) {
        final currentState = state as BlogLoaded;
        final updatedFavorites = List<Blog>.from(currentState.favorites);
        if (updatedFavorites.contains(event.blog)) {
          updatedFavorites.remove(event.blog);
        } else {
          updatedFavorites.add(event.blog);
        }
        emit(BlogLoaded(currentState.blogs, updatedFavorites));
      }
    });
  }
}
