import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  const CardSwiper({super.key, required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (context, int index) {
          peliculas[index].uniqueID = '${peliculas[index].id}-tarjeta';
          return Hero(
            tag: peliculas[index].uniqueID,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle',
                    arguments: peliculas[index]),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(peliculas[index].getPosterImage()),
                  placeholder: const AssetImage('assets/img/noimage.jpg'),
                ),
              ),
            ),
          );
        },
        duration: 1200,
        itemCount: peliculas.length,
        itemWidth: screenSize.width * 0.7,
        itemHeight: screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
