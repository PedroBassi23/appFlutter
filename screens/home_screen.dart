import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import 'add_movie_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Movie> _movies = [
    Movie(
      title: 'O Poderoso Chefão',
      director: 'Francis Ford Coppola',
      year: 1972,
    ),
    Movie(title: 'Pulp Fiction', director: 'Quentin Tarantino', year: 1994),
    Movie(
      title: 'O Senhor dos Anéis: O Retorno do Rei',
      director: 'Peter Jackson',
      year: 2003,
    ),
  ];

  void _navigateAndAddMovie(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMovieScreen()),
    );

    if (result != null && result is Movie) {
      setState(() {
        _movies.add(result);
      });
    }
  }

  void _deleteMovie(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Exclusão'),
          content: Text(
            'Você tem certeza que deseja excluir "${_movies[index].title}"?',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Excluir', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  _movies.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meu Catálogo de Filmes')),
      body: _movies.isEmpty
          ? Center(
              child: Text(
                'Nenhum filme no catálogo.\nClique em + para adicionar!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
            )
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Icon(
                      Icons.movie,
                      color: Colors.amber.shade800,
                      size: 40,
                    ),
                    title: Text(
                      movie.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${movie.director}, ${movie.year}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red.shade700),
                      onPressed: () => _deleteMovie(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndAddMovie(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
