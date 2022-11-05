import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var valueSliderX = 0.0;
  var valueSliderY = 0.0;
  var valueSliderZ = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              bottom: MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight, left: 0, right: 0, child: customSliders()),
          Positioned(top: kToolbarHeight, left: 0, right: 0, child: values()),
          Center(child: customTransform()),
          // Center(child: cube2())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            valueSliderX = 0.0;
            valueSliderY = 0.0;
            valueSliderZ = 0.0;
          });
        },
        child: const Icon(Icons.refresh),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget customTransform() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // perspective
        ..rotateX(valueSliderX)
        ..rotateY(valueSliderY)
        ..rotateZ(valueSliderZ),
      child: cube(edgeSize: 200),
    );
  }

  Widget cube({required double edgeSize}) {
    return Stack(
      children: [
        Transform(
          transform: Matrix4.identity()..translate(0.0, 0.0, edgeSize / 2),
          alignment: Alignment.center,
          child: Container(
            width: edgeSize,
            height: edgeSize,
            color: Colors.red,
            child: const FlutterLogo(),
          ),
        ),
        Transform(
          transform: Matrix4.identity()
            ..translate(edgeSize / 2, 0.0, 0.0)
            ..rotateY(pi / 2),
          alignment: Alignment.center,
          child: Container(
            width: edgeSize,
            height: edgeSize,
            color: Colors.orange,
            child: const FlutterLogo(),
          ),
        ),
      ],
    );
  }

  Widget values() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('X: ${valueSliderX.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20)),
        Text('Y: ${valueSliderY.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20)),
        Text('Z: ${valueSliderZ.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20)),
      ],
    );
  }

  Widget customSliders() {
    return Column(
      children: [
        Slider.adaptive(
          value: valueSliderX,
          min: -10,
          max: 10,
          activeColor: Colors.red,
          inactiveColor: Colors.red.withOpacity(0.3),
          thumbColor: Colors.red,
          onChanged: (value) {
            setState(() {
              valueSliderX = value;
            });
          },
        ),
        Slider.adaptive(
          value: valueSliderY,
          min: -10,
          max: 10,
          activeColor: Colors.yellow,
          inactiveColor: Colors.yellow.withOpacity(0.3),
          thumbColor: Colors.yellow,
          onChanged: (value) {
            setState(() {
              valueSliderY = value;
            });
          },
        ),
        Slider.adaptive(
          value: valueSliderZ,
          min: -10,
          max: 10,
          activeColor: Colors.green,
          inactiveColor: Colors.green.withOpacity(0.3),
          thumbColor: Colors.green,
          onChanged: (value) {
            setState(() {
              valueSliderZ = value;
            });
          },
        ),
      ],
    );
  }
}
