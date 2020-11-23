import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/movie_detail_bloc.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/networking/ApiResponse.dart';
import 'package:flutter_app/view/error.dart';
import 'package:flutter_app/view/loading.dart';
import 'dart:ui' as ui;

class MovieDetail extends StatefulWidget {
  final int selectedMovie;

  const MovieDetail({Key key, this.selectedMovie}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  MovieDetailBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MovieDetailBloc();
    _bloc.fetchMovieDetail(widget.selectedMovie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Movies',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        child: StreamBuilder<ApiResponse<Movie>>(
            stream: _bloc.movieDetailStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    return Loading(
                      loadMessage: snapshot.data.message,
                    );
                    break;
                  case Status.COMPLETE:
                    return ShowMovieDetail(
                      displayMovie: snapshot.data.data,
                    );
                    break;
                  case Status.ERROR:
                    return Error(
                      errorMessage: snapshot.data.message,
                      onRetryPressed:
                          _bloc.fetchMovieDetail(widget.selectedMovie),
                    );
                    break;
                }
              }
              return Container();
            }),
      ),
    );
  }
}

class ShowMovieDetail extends StatelessWidget {
  final Movie displayMovie;

  const ShowMovieDetail({Key key, this.displayMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://image.tmdb.org/t/p/w342${displayMovie.posterPath}',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w342${displayMovie.posterPath}'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20.0, offset: Offset(0.0, 10.0))
                          ]),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                    child: Row(
                        children: [
                          Expanded(child: Text(displayMovie.title, style: TextStyle(color: Colors.white, fontSize: 30.0),)),
                          Text(displayMovie.voteAverage.toString(), style: TextStyle(color: Colors.white, fontSize: 20.0))
                        ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
