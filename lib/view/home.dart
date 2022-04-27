import 'package:bmi_app/model/constants/animated_page-route.dart';
import 'package:bmi_app/view/calculate/calculate_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const routeNames = '/Home';
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: size.height * 0.16,
            child: const Image(
              image: AssetImage('assets/images/spalsh_page_back3.png'),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/spalsh_screen_back2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.62,
            left: size.width * 0.1,
            child: Text(
              'Ideal for the health conscious',
              style: TextStyle(
                fontSize: size.height * 0.02,
                color: const Color(0xff72909D),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.65,
            left: size.width * 0.1,
            child: Text(
              'Keep your body \nat glance.',
              style: TextStyle(
                fontSize: size.height * 0.05,
                color: const Color(0xffE0F2F1),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.82,
            right: size.width * 0.03,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  AnimatedPageRoute(
                    beginDx: 10.0,
                    beginDy: 10.0,
                    endDx: 0.0,
                    endDy: 0.0,
                    duration: const Duration(seconds: 1),
                    curve: Curves.ease,
                    widget: const CalculateScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  Text(
                    'Start',
                    style: TextStyle(
                      fontSize: size.height * 0.025,
                      color: const Color(0xffFFFFFF),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Icon(Icons.sports, size: size.width * 0.11),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
