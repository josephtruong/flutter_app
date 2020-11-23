import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/blocs/movie_bloc.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/networking/ApiResponse.dart';
import 'package:flutter_app/view/error.dart';
import 'package:flutter_app/view/movie_detail.dart';

import 'loading.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc();
    _bloc.fetchMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'Movies',
            style: TextStyle(fontSize: 28),
          ),
        ),
        body: Container(
          child: StreamBuilder<ApiResponse<List<Movie>>>(
            stream: _bloc.movieListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(
                      loadMessage: snapshot.data.message,
                    );
                    break;
                  case Status.COMPLETE:
                    return MovieList(
                      movieList: snapshot.data.data,
                    );
                    break;
                  case Status.ERROR:
                    return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () => _bloc.fetchMovieList());
                    break;
                }
              }
              return Container();
            },
          ),
        ));
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movieList;

  const MovieList({Key key, this.movieList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: movieList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.5 / 1.8),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MovieDetail(
                          selectedMovie: movieList[index].id,
                        )));
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w342${movieList[index].posterPath}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
