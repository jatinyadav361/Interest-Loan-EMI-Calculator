import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());

  var rectangle = Rectangle();
  rectangle.draw();

}


    abstract class Shape {
      int x;
      int y;
      void draw();
      Shape(){
        print("Shape class constructor");
      }
    }

    class Rectangle extends Shape {
      void draw() {
        print("Drawing rectangle!");
      }
      Rectangle(){
        print("Rectangle class constructor!");
      }
    }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBAr'),
      ),
    );
  }
}
