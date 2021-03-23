// import 'package:flutter/material.dart';
// import 'package:xlo_mobx/models/ad.dart';
// import 'package:readmore/readmore.dart';

// class DescriptionPanel extends StatelessWidget {

//   DescriptionPanel(this.ad);

//   final Ad ad;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(top: 18),
//           child: Text('Descrição',
//           style: TextStyle(
//             fontSize: 17,
//             fontWeight: FontWeight.w600
//           )),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 18),
//           child: ReadMoreText(
//             ad.description,
//             trimLines: 3,
//             trimCollapsedText: 'Ver descrição completa',
//             trimExpandedText: 'Ver menos',
//             trimMode: TrimMode.Line,
//             colorClickableText: Colors.purple,
//             style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w400
//             ),
//             textAlign: TextAlign.justify,
//           ),
//         )
//       ],
//     );
//   }
// }