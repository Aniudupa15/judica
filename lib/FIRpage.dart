import 'package:flutter/material.dart';

class FirComponent extends StatelessWidget {
  // Shared styles can be organized as constants
  static const double padding = 16.0;
  static const double buttonSize = 80.0;

  const FirComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Stack(
              fit: StackFit.expand,
            children:[
              Image.asset('assets/BackgroundImage.jpg',fit: BoxFit.cover,),Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title Text
                Text(
                  'F.I.R',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    shadows: const [Shadow(blurRadius: 8.0, color: Colors.grey, offset: Offset(0, 4))],
                  ),
                ),
                const SizedBox(height: 24),

                // Microphone Button
                GestureDetector(
                  onTap: () {
                    // Define action for button tap
                  },
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(blurRadius: 10.0, color: Colors.grey.withOpacity(0.5), offset: const Offset(0, 6)),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.mic,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Informational Text
                Text(
                  'Press to give Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Get Started Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(blurRadius: 8.0, color: Colors.grey.withOpacity(0.5), offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),]
          ),
      ),
    );
  }
}