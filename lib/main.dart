import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home_page.dart';


main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
      primarySwatch: Colors.grey
       

      ),
       debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}
