import 'dart:math';
import 'package:flutter/material.dart';

enum Faces { fru, frd, bru, brd, flu, fld, blu, bld }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var valueSliderX = 0.0;
  var valueSliderY = 0.0;
  var valueSliderZ = 0.0;
  double edgeSize = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Positioned(
              bottom: MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight, left: 0, right: 0, child: customSliders()),
          Positioned(top: kToolbarHeight, left: 0, right: 0, child: values()),
          Center(child: customTransform()),
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
        ..rotateX(valueSliderX)
        ..rotateY(valueSliderY)
        ..rotateZ(valueSliderZ),
      child: cube(),
    );
  }

  Widget cube() {
    return Stack(
      children: cubeFaces()!,
    );
  }

  List<Widget>? cubeFaces() {
    print('x=${cos(valueSliderX) * 100} y=${cos(valueSliderY) * 100} z=${cos(valueSliderZ) * 100}');
    double cx = cos(valueSliderX);
    double cy = cos(valueSliderY);
    double cz = cos(valueSliderZ);
    //cuadrante 1,1,1
    if (0 <= cx && cx <= 1 && 0 <= cy && cy <= 1 && 0 <= cz && cz <= 1) {
      return faces(Faces.fru);
    }
    //cuadrante 1,1,-1
    else if (0 <= cx && cx <= 1 && 0 <= cy && cy <= 1 && -1 <= cz && cz <= 0) {
      return faces(Faces.frd);
    }
    //cuadrante 1,-1,1
    else if (0 <= cx && cx <= 1 && -1 <= cy && cy <= 0 && 0 <= cz && cz <= 1) {
      return faces(Faces.bru);
    }
    //cuadrante 1,-1,-1
    else if (0 <= cx && cx <= 1 && -1 <= cy && cy <= 0 && -1 <= cz && cz <= 0) {
      return faces(Faces.brd);
    }
    //cuadrante -1,1,1
    else if (-1 <= cx && cx <= 0 && 0 <= cy && cy <= 1 && 0 <= cz && cz <= 1) {
      return faces(Faces.blu);
    }
    //cuadrante -1,1,-1
    else if (-1 <= cx && cx <= 0 && 0 <= cy && cy <= 1 && -1 <= cz && cz <= 0) {
      return faces(Faces.bld);
    }
    //cuadrante -1,-1,1
    else if (-1 <= cx && cx <= 0 && -1 <= cy && cy <= 0 && 0 <= cz && cz <= 1) {
      return faces(Faces.flu);
    }
    //cuadrante -1,-1,-1
    else if (-1 <= cx && cx <= 0 && -1 <= cy && cy <= 0 && -1 <= cz && cz <= 0) {
      return faces(Faces.fld);
    }
  }

  List<Widget> faces(Faces face) {
    List<Widget> faces = [];
    switch (face) {
      case Faces.fru:
        faces.add(frontFace());
        faces.add(rightFace());
        faces.add(upFace());
        print('fru');
        break;
      case Faces.frd:
        faces.add(frontFace());
        faces.add(rightFace());
        faces.add(downFace());
        print('frd');
        break;
      case Faces.bru:
        faces.add(backFace());
        faces.add(rightFace());
        faces.add(upFace());
        print('bru');
        break;
      case Faces.brd:
        faces.add(backFace());
        faces.add(rightFace());
        faces.add(downFace());
        print('brd');
        break;
      case Faces.flu:
        faces.add(frontFace());
        faces.add(leftFace());
        faces.add(upFace());
        print('flu');
        break;
      case Faces.fld:
        faces.add(frontFace());
        faces.add(leftFace());
        faces.add(downFace());
        print('fld');
        break;
      case Faces.blu:
        faces.add(backFace());
        faces.add(leftFace());
        faces.add(upFace());
        print('blu');
        break;
      case Faces.bld:
        faces.add(backFace());
        faces.add(leftFace());
        faces.add(downFace());
        print('bld');
        break;
    }
    return faces;
  }

  Widget upFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, -edgeSize / 2, 0.0)
        ..rotateX(-pi / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.yellow, text: 'UP'),
    );
  }

  Widget downFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, edgeSize / 2, 0.0)
        ..rotateX(-pi / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.white, text: 'DOWN'),
    );
  }

  Widget frontFace() {
    return Transform(
      transform: Matrix4.identity()..translate(0.0, 0.0, -edgeSize / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.red, text: 'FRONT'),
    );
  }

  Widget backFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, 0.0, edgeSize / 2)
        ..rotateY(pi),
      alignment: Alignment.center,
      child: customContainer(color: Colors.orange, text: 'BACK'),
    );
  }

  Widget leftFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(-edgeSize / 2, 0.0, 0.0)
        ..rotateY(-3 * pi / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.blue, text: 'LEFT'),
    );
  }

  Widget rightFace() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(edgeSize / 2, 0.0, 0.0)
        ..rotateY(-pi / 2),
      alignment: Alignment.center,
      child: customContainer(color: Colors.green, text: 'RIGHT'),
    );
  }

  Container customContainer({required color, String text = ''}) {
    return Container(
      width: edgeSize,
      height: edgeSize,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        color: color,
      ),
      child: Center(child: Text(text, style: const TextStyle(fontSize: 20))),
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
          min: 0,
          max: pi,
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
          min: 0,
          max: pi,
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
          min: 0,
          max: pi,
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
