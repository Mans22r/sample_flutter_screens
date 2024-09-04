import 'dart:math';

import 'package:flutter/material.dart';
import 'camera_page.dart';

class WidgetsPage extends StatelessWidget {
  const WidgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets Page'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Normal Container'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContainerDemo()),
              );
            },
          ),
          ListTile(
            title: const Text('Flag'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Flag()),
              );
            },
          ),
          ListTile(
            title: const Text('Post'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Post()),
              );
            },
          ),
          ListTile(
            title: const Text('Camera Capture'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CameraPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}


class ContainerDemo extends StatelessWidget {
  const ContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('Container Demo'),
      ),
      body: Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              )
            ]          
          ),
          
          child: const Center(
            child: Text(
              'Hello, Container!',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class Flag extends StatelessWidget {
  const Flag({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indian Flag'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 102, 0),
            )),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255),
              child: const Center(
                child: AshokaChakra(),
              ),
            )),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 10, 85, 24),
            ))
        ],
        
      ),
      );
  }
}

class AshokaChakra extends StatelessWidget {
  const AshokaChakra({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200), // Size of the Chakra
      painter: AshokaChakraPainter(),
    );
  }
}

class AshokaChakraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    // Draw the outer circle
    final Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(Offset(radius, radius), radius, circlePaint);

    // Draw the spokes
    final Paint spokePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4;

    for (int i = 0; i < 24; i++) {
      final double angle = (i * 15) * (3.141592653589793 / 180);
      final double x1 = radius + radius * 0.85 * cos(angle);
      final double y1 = radius + radius * 0.85 * sin(angle);
      final double x2 = radius + radius * 0.25 * cos(angle);
      final double y2 = radius + radius * 0.25 * sin(angle);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), spokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Layout Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PhotoLayoutPage(),
    );
  }
}

class PhotoLayoutPage extends StatelessWidget {
  const PhotoLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Layout'),
      ),
      body: Center(
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'lib/assets/img-5.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Small Photo in the Top Left
            Positioned(
              top: 50,
              left: 20,
              child: Image.asset(
                'lib/assets/img-3.jpg',
                width: 100,
                height: 100,
              ),
            ),
            // Medium Photo in the Center
            Positioned(
              top: 150,
              left: 100,
              child: Image.asset(
                'lib/assets/img-1.jpg',
                width: 150,
                height: 150,
              ),
            ),
            // Large Photo in the Bottom Right
            Positioned(
              bottom: 50,
              right: 20,
              child: Image.asset(
                'lib/assets/img-2.jpg',
                width: 200,
                height: 200,
              ),
            ),
            // Another Photo partially overlapping
            Positioned(
              bottom: 120,
              right: 80,
              child: Image.asset(
                'lib/assets/img-4.jpg',
                width: 120,
                height: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}