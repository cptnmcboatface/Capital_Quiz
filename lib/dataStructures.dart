import 'package:flutter/material.dart';

class Country{
  final String country, capital, cCode, photo;
  Country(this.country, this.capital, this.cCode, this.photo);
}
class QuizCard{
  final String country, cCode, photo;
  final List<String> options;
  final int correctAnswer;
  QuizCard(this.country, this.cCode, this.photo,this.options, this.correctAnswer);
}

Animatable<Color> background = TweenSequence<Color>([
  TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: Colors.red,
      end: Colors.green,
    ),
  ),
  TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: Colors.green,
      end: Colors.blue,
    ),
  ),
  TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: Colors.blue,
      end: Colors.pink,
    ),
  ),
  TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: Colors.pink,
      end: Colors.purpleAccent,
    ),
  ),TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: Colors.purpleAccent,
      end: Colors.yellow,
    ),
  ),TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: Colors.yellow,
      end: Colors.orange,
    ),
  ),TweenSequenceItem(
    weight: 1.0,
    tween: ColorTween(
      begin: Colors.orange,
      end: Colors.red,
    ),
  )
]);