// import 'package:flutter/material.dart';
// import 'package:flutter_page_indicator/flutter_page_indicator.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:dots_indicator/dots_indicator.dart';

// class IndexScreen extends StatefulWidget {
//   @override
//   _IndexScreenState createState() => _IndexScreenState();
// }

// class _IndexScreenState extends State<IndexScreen> {
//   // final controller = PageController(
//   //   initialPage: 0,
//   // );
//   // PageIndicatorLayout layout = PageIndicatorLayout.SLIDE;
//   int index;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Container(
//             child: CarouselSlider(
//               options: CarouselOptions(
//                 // onPageChanged: () {
//                 //   index++;
//                 // },
//                 height: 650,
//               ),
//               items: [
//                 Container(
//                   color: Colors.white,
//                   child: Center(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 100,
//                         ),
//                         Image.asset('asset/images/logo.jpg'),
//                         Text(
//                           'opena1',
//                           style:
//                               TextStyle(fontSize: 50, fontFamily: 'Pacifico'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           DotsIndicator(
//             dotsCount: 5,
//             position: 1,
//             decorator: DotsDecorator(
//               color: Colors.black87, // Inactive color
//               activeColor: Colors.redAccent,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 50.0),
//             child: Material(
//               elevation: 5.0,
//               color: Colors.blueAccent,
//               borderRadius: BorderRadius.circular(30.0),
//               child: MaterialButton(
//                 onPressed: () {},
//                 minWidth: 200.0,
//                 height: 42.0,
//                 child: Text(
//                   '시작하기',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             PageView(
//               controller: controller,
//               children: [
//                 Container(
//                   child: Center(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 100,
//                         ),
//                         Image.asset('asset/images/logo.jpg'),
//                         Text(
//                           'opena1',
//                           style:
//                               TextStyle(fontSize: 50, fontFamily: 'Pacifico'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   child: Center(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 100,
//                         ),
//                         Image.asset('asset/images/logo.jpg'),
//                         Text(
//                           'opena2',
//                           style:
//                               TextStyle(fontSize: 50, fontFamily: 'Pacifico'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.black,
//                   child: Center(
//                     child: Column(
//                       children: [
//                         SizedBox(
//                           height: 100,
//                         ),
//                         Image.asset('asset/images/logo.jpg'),
//                         Text(
//                           'opena3',
//                           style:
//                               TextStyle(fontSize: 50, fontFamily: 'Pacifico'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 30.0),
//                 child: PageIndicator(
//                   layout: PageIndicatorLayout.SLIDE,
//                   size: 20.0,
//                   controller: controller,
//                   space: 5.0,
//                   count: 4,
//                   color: Colors.grey,
//                   activeColor: Colors.black,
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }
