import 'dart:math';
import 'package:flutter/material.dart';

enum Faces { fru, frd, bru, brd, flu, fld, blu, bld }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double valueSliderX = 0.0;
  double valueSliderY = 0.0;
  double valueSliderZ = 200.0;
  bool touchMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('3D RUBIK\'S CUBE'),
      ),
      body: Stack(
        children: [
          Positioned(
              bottom: MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight, left: 0, right: 0, child: customSliders()),
          Positioned(top: 20, left: 0, right: 0, child: values()),
          Positioned(
            top: kToolbarHeight + 120,
            left: 0,
            right: 0,
            child: Center(child: touchMode == false ? customTransform() : customGestureDetector()),
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
                child: SwitchListTile.adaptive(
                    title: const Text('Touch Mode'),
                    value: touchMode,
                    onChanged: (value) {
                      setState(() {
                        touchMode = value;
                      });
                    })),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            valueSliderX = 0.0;
            valueSliderY = 0.0;
            valueSliderZ = 200;
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
        ..rotateX(valueSliderX)
        ..rotateY(valueSliderY),
      child: cube(),
    );
  }

  Widget customGestureDetector() {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          valueSliderX += details.delta.dx * pi / 180;
          valueSliderY += details.delta.dy * pi / 180;
        });
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..rotateX(valueSliderX)
          ..rotateY(valueSliderY),
        child: cube(),
      ),
    );
  }

  Widget cube() {
    return Stack(
      children: cubeFaces()!,
    );
  }

  List<Widget>? cubeFaces() {
    if (valueSliderY <= pi / 2 && valueSliderY >= 0) {
      if (valueSliderX <= pi / 2 && valueSliderX >= 0) {
        return faces(Faces.fru);
      } else if (valueSliderX <= pi && valueSliderX >= pi / 2) {
        return faces(Faces.blu);
      } else if (valueSliderX <= 0 && valueSliderX >= -pi / 2) {
        return faces(Faces.frd);
      } else {
        return faces(Faces.bld);
      }
    } else if (valueSliderY <= pi && valueSliderY >= pi / 2) {
      if (valueSliderX <= pi / 2 && valueSliderX >= 0) {
        return faces(Faces.bru);
      } else if (valueSliderX <= pi && valueSliderX >= pi / 2) {
        return faces(Faces.flu);
      } else if (valueSliderX <= 0 && valueSliderX >= -pi / 2) {
        return faces(Faces.brd);
      } else {
        return faces(Faces.fld);
      }
    } else if (valueSliderY <= 0 && valueSliderY >= -pi / 2) {
      if (valueSliderX <= pi / 2 && valueSliderX >= 0) {
        return faces(Faces.flu);
      } else if (valueSliderX <= pi && valueSliderX >= pi / 2) {
        return faces(Faces.bru);
      } else if (valueSliderX <= 0 && valueSliderX >= -pi / 2) {
        return faces(Faces.fld);
      } else {
        return faces(Faces.brd);
      }
    } else {
      if (valueSliderX <= pi / 2 && valueSliderX >= 0) {
        return faces(Faces.blu);
      } else if (valueSliderX <= pi && valueSliderX >= pi / 2) {
        return faces(Faces.fru);
      } else if (valueSliderX <= 0 && valueSliderX >= -pi / 2) {
        return faces(Faces.bld);
      } else {
        return faces(Faces.frd);
      }
    }
  }

  List<Widget> faces(Faces face) {
    List<Widget> faces = [];
    switch (face) {
      case Faces.fru:
        faces.add(frontFace());
        faces.add(rightFace());
        faces.add(upFace());
        break;
      case Faces.frd:
        faces.add(frontFace());
        faces.add(rightFace());
        faces.add(downFace());
        break;
      case Faces.bru:
        faces.add(backFace());
        faces.add(rightFace());
        faces.add(upFace());
        break;
      case Faces.brd:
        faces.add(backFace());
        faces.add(rightFace());
        faces.add(downFace());
        break;
      case Faces.flu:
        faces.add(frontFace());
        faces.add(leftFace());
        faces.add(upFace());
        break;
      case Faces.fld:
        faces.add(frontFace());
        faces.add(leftFace());
        faces.add(downFace());
        break;
      case Faces.blu:
        faces.add(backFace());
        faces.add(leftFace());
        faces.add(upFace());
        break;
      case Faces.bld:
        faces.add(backFace());
        faces.add(leftFace());
        faces.add(downFace());
        break;
    }
    return faces;
  }

  Widget upFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, -valueSliderZ / 2, 0.0)
        ..rotateX(-pi / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.yellow, text: 'UP'),
    );
  }

  Widget downFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, valueSliderZ / 2, 0.0)
        ..rotateX(-pi / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.white, text: 'DOWN'),
    );
  }

  Widget frontFace() {
    return Transform(
      transform: Matrix4.identity()..translate(0.0, 0.0, -valueSliderZ / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.red, text: 'FRONT'),
    );
  }

  Widget backFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, 0.0, valueSliderZ / 2)
        ..rotateY(pi),
      alignment: Alignment.center,
      child: customContainer(color: Colors.orange, text: 'BACK'),
    );
  }

  Widget leftFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(-valueSliderZ / 2, 0.0, 0.0)
        ..rotateY(-3 * pi / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.blue, text: 'LEFT'),
    );
  }

  Widget rightFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(valueSliderZ / 2, 0.0, 0.0)
        ..rotateY(-pi / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.green, text: 'RIGHT'),
    );
  }

  Container customContainer({required color, String text = ''}) {
    return Container(
        width: valueSliderZ,
        height: valueSliderZ,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          color: Colors.black45,
          borderRadius: BorderRadius.circular(10),
        ),
        child: customGrid(color));
  }

  Widget customGrid(color) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            invidualGrid(color),
            invidualGrid(color),
            invidualGrid(color),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            invidualGrid(color),
            invidualGrid(color),
            invidualGrid(color),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            invidualGrid(color),
            invidualGrid(color),
            invidualGrid(color),
          ],
        ),
      ],
    );
  }

  Widget invidualGrid(color) {
    return Container(
      width: valueSliderZ / 3 - 1,
      height: valueSliderZ / 3 - 1,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: valueSliderZ / 40),
        color: color,
        borderRadius: BorderRadius.circular(valueSliderZ / 20),
      ),
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
          min: -pi,
          max: pi,
          activeColor: Colors.red,
          inactiveColor: Colors.red.withOpacity(0.3),
          thumbColor: Colors.red,
          onChanged: (value) {
            setState(() {
              valueSliderX = touchMode == false ? value : valueSliderX;
            });
          },
        ),
        Slider.adaptive(
          value: valueSliderY,
          min: -pi,
          max: pi,
          activeColor: Colors.yellow,
          inactiveColor: Colors.yellow.withOpacity(0.3),
          thumbColor: Colors.yellow,
          onChanged: (value) {
            setState(() {
              valueSliderY = touchMode == false ? value : valueSliderY;
            });
          },
        ),
        Slider.adaptive(
          value: valueSliderZ,
          min: 150,
          max: 250,
          activeColor: Colors.green,
          inactiveColor: Colors.green.withOpacity(0.3),
          thumbColor: Colors.green,
          onChanged: (value) {
            setState(() {
              valueSliderZ = touchMode == false ? value : valueSliderZ;
            });
          },
        ),
      ],
    );
  }
}
