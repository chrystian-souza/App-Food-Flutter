
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final List<String> imageUrls = [
    
    'https://source.unsplash.com/200x200/?hamburguer',
    'https://source.unsplash.com/200x200/?food',
    'https://source.unsplash.com/200x200/?drinks',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200.0,
          autoPlay: false,
          enlargeCenterPage: true,
          
        ),
        items: imageUrls.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: Center(
                  child: Image.network(
                    i,
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}