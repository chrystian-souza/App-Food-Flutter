import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final String carousel;
  final String titulo;
  final List<String> imageUrls;
  final String info;
  final String preco;

  Carousel({
    Key? key,
    required this.titulo,
    required this.carousel,
    required this.imageUrls,
    required this.info,
    required this.preco,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            carousel,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        CarouselSlider(
          options: CarouselOptions(
            height: 300.0, // Altura ajustada para um melhor layout
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: imageUrls.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180.0, // Altura aumentada para a imagem
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            return Container(
                              color: Colors.grey,
                              child: Center(
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                              width: double.infinity,
                              height: 180.0,
                            );
                          },
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              titulo,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              info,
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              'Preço: $preco',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
