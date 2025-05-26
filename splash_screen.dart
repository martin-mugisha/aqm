import 'my_home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                'assets/images/icon.jpg',
              ),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
              child: TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween(begin: 0.0, end: 1.0),
                onEnd: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MyHomePage(), // Navigate to your dashboard page
                  ));
                },
                builder: (BuildContext context, double value, Widget? child) {
                  return Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8 * value,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
