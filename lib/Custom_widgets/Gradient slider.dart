
// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class GradientSlideToAct extends StatefulWidget {
  final String text;
  final Function onSlideCompleted;
  final List<Color> gradientColors;

  const GradientSlideToAct({super.key,
    required this.text,
    required this.onSlideCompleted,
    required this.gradientColors,
  });

  @override
  _GradientSlideToActState createState() => _GradientSlideToActState();
}

class _GradientSlideToActState extends State<GradientSlideToAct> {
  double _sliderValue = 0.0;
  bool _slideCompleted = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: GestureDetector(
        onHorizontalDragUpdate: (DragUpdateDetails details) {
          setState(() {
            _sliderValue += details.delta.dx / 100;
            if (_sliderValue >= 1.0) {
              _sliderValue = 1.0;
              _slideCompleted = true;
            } else if (_sliderValue <= 0.0) {
              _sliderValue = 0.0;
              _slideCompleted = false;
            }
          });
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          setState(() {
            if (_slideCompleted) {
              widget.onSlideCompleted();
              _slideCompleted = false;
            }
            _sliderValue = 0.0;
          });
        },
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  colors: widget.gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                style: const TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width * _sliderValue,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: LinearGradient(
                    colors: widget.gradientColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}