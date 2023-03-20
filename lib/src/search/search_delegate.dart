import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_providers.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = PeliculaProvider();
  String seleccion = '';
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Acciones de Apbar
    return [
      IconButton(
          onPressed: () {
            query = '';
            //print('click');
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Icono a la izquierda de apbar
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation));
  }

  @override
  Widget buildResults(BuildContext context) {
    // resultados que va mostrar
    return Center(
      child: Container(
        width: 100.0,
        height: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // son las sugerencias que aparecen cuando escriben

    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas!.map((pelicula) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: const AssetImage('assets/img/noimage.jpg'),
                  image: NetworkImage(pelicula.getPosterImage()),
                  width: 50.0,
                  fit: BoxFit.cover,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: () {
                  close(context, null);
                  pelicula.uniqueID = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: RefreshProgressIndicator(),
          );
        }
      },
    );
  }
}
