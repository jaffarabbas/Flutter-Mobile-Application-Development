// import 'package:flutter/material.dart';
// import './quiz.dart';
// import './result.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MyAppState();
//   }
// }

// class _MyAppState extends State<MyApp> {
//   var count = 0;
//   var totalScore = 0;

//   final question = [
//     {
//       'questiontext': 'whats your Namme ? ',
//       'answer': [
//         {'text': 'jaffar', 'score': 10},
//         {'text': 'rrrr', 'score': 5},
//         {'text': 'dsfsdf', 'score': 9},
//         {'text': 'asmi', 'score': 0}
//       ]
//     },
//     {
//       'questiontext': 'whats your car ? ',
//       'answer': [
//         {'text': 'lamborgini', 'score': 10},
//         {'text': 'farari', 'score': 5},
//         {'text': 'tesla', 'score': 9},
//         {'text': 'jaguar', 'score': 0}
//       ]
//     },
//     {
//       'questiontext': 'whats your age ? ',
//       'answer': [
//         {'text': '21', 'score': 10},
//         {'text': '22', 'score': 5},
//         {'text': '23', 'score': 9},
//         {'text': '20', 'score': 0}
//       ]
//     }
//   ];
//   // ignore: non_constant_identifier_names
//   void CLickedButton(int score) {
//     totalScore += score;
//     setState(() {
//       count += 1;
//     });
//     print(count);
//   }

//   void resetQuiz() {
//     setState(() {
//       count = 0;
//       totalScore = 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dark'),
//         ),
//         body: count < question.length
//             ? Quiz(
//                 answerQuestion: CLickedButton,
//                 questionIndex: count,
//                 questions: question)
//             : Result(totalScore, resetQuiz),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
 
 Widget build(BuildContext context) {
    
   return MaterialApp(
  
      home: Scaffold(
      body:LOGIN(),
      ),
    );
   }

}


// class LOGIN extends StatelessWidget {
//   LOGIN({
//     Key key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffffffff),
//       body: Stack(
//         children: <Widget>[
//           Transform.translate(
//             offset: Offset(65.0, 197.0),
//             child:
//                 // Adobe XD layer: 'login_elements' (group)
//                 SizedBox(
//               width: 240.0,
//               height: 474.0,
//               child: Stack(
//                 children: <Widget>[
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 173.0, 240.0, 1.0),
//                     size: Size(240.0, 474.0),
//                     pinLeft: true,
//                     pinRight: true,
//                     fixedHeight: true,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xffffffff),
//                         border: Border.all(
//                             width: 1.0, color: const Color(0xff707070)),
//                       ),
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 254.0, 240.0, 1.0),
//                     size: Size(240.0, 474.0),
//                     pinLeft: true,
//                     pinRight: true,
//                     fixedHeight: true,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: const Color(0xffffffff),
//                         border: Border.all(
//                             width: 1.0, color: const Color(0xff707070)),
//                       ),
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(76.0, 436.0, 93.0, 38.0),
//                     size: Size(240.0, 474.0),
//                     pinBottom: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child: PageLink(
//                       links: [
//                         PageLinkInfo(
//                           transition: LinkTransition.Fade,
//                           ease: Curves.easeOut,
//                           duration: 0.3,
//                         ),
//                       ],
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: const Color(0xff9c9494),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(76.0, 0.0, 74.0, 33.0),
//                     size: Size(240.0, 474.0),
//                     pinLeft: true,
//                     pinBottom: true,
//                     fixedHeight: true,
//                     child:
//                         // Adobe XD layer: 'Welcome back!' (text)
//                         Text(
//                       'LOGIN',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 24,
//                         color: const Color(0xff303030),
//                         fontWeight: FontWeight.w700,
//                         height: 1.4583333333333333,
//                       ),
//                       textHeightBehavior:
//                           TextHeightBehavior(applyHeightToFirstAscent: false),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(100.0, 446.0, 45.0, 19.0),
//                     size: Size(240.0, 474.0),
//                     pinBottom: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child: Text(
//                       'LOGIN',
//                       style: TextStyle(
//                         fontFamily: 'Segoe UI',
//                         fontSize: 14,
//                         color: const Color(0xffffffff),
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 152.0, 104.0, 20.0),
//                     size: Size(240.0, 474.0),
//                     pinLeft: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child: Text(
//                       'Phone Number',
//                       style: TextStyle(
//                         fontFamily: 'Segoe UI',
//                         fontSize: 15,
//                         color: const Color(0x52000000),
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 230.0, 66.0, 20.0),
//                     size: Size(240.0, 474.0),
//                     pinLeft: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child: Text(
//                       'Password',
//                       style: TextStyle(
//                         fontFamily: 'Segoe UI',
//                         fontSize: 15,
//                         color: const Color(0x52000000),
//                       ),
//                       textAlign: TextAlign.left,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Transform.translate(
//             offset: Offset(15.0, 14.3),
//             child:
//                 // Adobe XD layer: 'Light Status Bar' (group)
//                 SizedBox(
//               width: 342.0,
//               height: 17.0,
//               child: Stack(
//                 children: <Widget>[
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(318.0, 0.0, 24.3, 11.3),
//                     size: Size(342.3, 16.7),
//                     pinRight: true,
//                     pinTop: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child:
//                         // Adobe XD layer: 'Battery' (group)
//                         Stack(
//                       children: <Widget>[
//                         Pinned.fromSize(
//                           bounds: Rect.fromLTWH(0.0, 0.0, 22.0, 11.3),
//                           size: Size(24.3, 11.3),
//                           pinLeft: true,
//                           pinRight: true,
//                           pinTop: true,
//                           pinBottom: true,
//                           child:
//                               // Adobe XD layer: 'Border' (shape)
//                               Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(2.67),
//                               border: Border.all(
//                                   width: 1.0, color: const Color(0x733e4a59)),
//                             ),
//                           ),
//                         ),
//                         Pinned.fromSize(
//                           bounds: Rect.fromLTWH(23.0, 3.7, 1.3, 4.0),
//                           size: Size(24.3, 11.3),
//                           pinRight: true,
//                           fixedWidth: true,
//                           fixedHeight: true,
//                           child:
//                               // Adobe XD layer: 'Cap' (shape)
//                               SvgPicture.string(
//                             _svg_3z9ai,
//                             allowDrawingOutsideViewBox: true,
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         Pinned.fromSize(
//                           bounds: Rect.fromLTWH(2.0, 2.0, 18.0, 7.3),
//                           size: Size(24.3, 11.3),
//                           pinLeft: true,
//                           pinTop: true,
//                           pinBottom: true,
//                           fixedWidth: true,
//                           child:
//                               // Adobe XD layer: 'Capacity' (shape)
//                               Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(1.33),
//                               color: const Color(0x733e4a59),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(297.7, 0.0, 15.3, 11.0),
//                     size: Size(342.3, 16.7),
//                     pinRight: true,
//                     pinTop: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child:
//                         // Adobe XD layer: 'Wifi' (shape)
//                         SvgPicture.string(
//                       _svg_684ofy,
//                       allowDrawingOutsideViewBox: true,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(275.7, 0.3, 17.0, 10.7),
//                     size: Size(342.3, 16.7),
//                     pinRight: true,
//                     pinTop: true,
//                     fixedWidth: true,
//                     fixedHeight: true,
//                     child:
//                         // Adobe XD layer: 'Cellular Connection' (shape)
//                         SvgPicture.string(
//                       _svg_g4nwbn,
//                       allowDrawingOutsideViewBox: true,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                   Pinned.fromSize(
//                     bounds: Rect.fromLTWH(0.0, 0.7, 54.0, 16.0),
//                     size: Size(342.3, 16.7),
//                     pinLeft: true,
//                     pinTop: true,
//                     pinBottom: true,
//                     fixedWidth: true,
//                     child:
//                         // Adobe XD layer: 'Time Style' (group)
//                         Stack(
//                       children: <Widget>[
//                         Pinned.fromSize(
//                           bounds: Rect.fromLTWH(0.0, 0.0, 54.0, 16.0),
//                           size: Size(54.0, 16.0),
//                           pinLeft: true,
//                           pinRight: true,
//                           fixedHeight: true,
//                           child:
//                               // Adobe XD layer: '↳ Time' (text)
//                               Text(
//                             '9:41',
//                             style: TextStyle(
//                               fontFamily: 'Helvetica Neue',
//                               fontSize: 14,
//                               color: const Color(0x733e4a59),
//                               letterSpacing: -0.28,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// const String _svg_3z9ai =
//     '<svg viewBox="23.0 4.0 1.3 4.0" ><path transform="translate(23.0, 4.0)" d="M 0 0 L 0 4 C 0.8047311305999756 3.661223411560059 1.328037977218628 2.873133182525635 1.328037977218628 2 C 1.328037977218628 1.126866698265076 0.8047311305999756 0.3387765288352966 0 0" fill="#3e4a59" fill-opacity="0.45" stroke="none" stroke-width="1" stroke-opacity="0.45" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_684ofy =
//     '<svg viewBox="294.7 0.3 15.3 11.0" ><path transform="translate(294.69, 0.33)" d="M 7.636500358581543 10.96560001373291 C 7.553820133209229 10.96560001373291 7.473130226135254 10.93181037902832 7.41510009765625 10.87290000915527 L 5.417100429534912 8.856900215148926 C 5.355820178985596 8.796520233154297 5.321700096130371 8.712539672851563 5.323500156402588 8.626500129699707 C 5.325290203094482 8.540619850158691 5.363010406494141 8.458290100097656 5.427000045776367 8.400600433349609 C 6.043790340423584 7.878690242767334 6.828470230102539 7.591279983520508 7.636500358581543 7.591279983520508 C 8.444530487060547 7.591279983520508 9.229209899902344 7.878699779510498 9.846000671386719 8.400600433349609 C 9.909970283508301 8.457460403442383 9.947690010070801 8.539790153503418 9.94950008392334 8.626500129699707 C 9.951300621032715 8.712539672851563 9.917180061340332 8.796520233154297 9.855899810791016 8.856900215148926 L 7.857900142669678 10.87290000915527 C 7.799020290374756 10.93268013000488 7.720390319824219 10.96560001373291 7.636500358581543 10.96560001373291 Z M 11.14441013336182 7.428060054779053 C 11.0646800994873 7.428060054779053 10.98871040344238 7.397890090942383 10.93050003051758 7.343100070953369 C 10.02591991424561 6.524199962615967 8.856080055236816 6.073200225830078 7.636500358581543 6.073200225830078 C 6.417750358581543 6.073200225830078 5.248880386352539 6.524189949035645 4.345200061798096 7.343100070953369 C 4.286990165710449 7.397880077362061 4.210910320281982 7.428060054779053 4.13100004196167 7.428060054779053 C 4.047810077667236 7.428070068359375 3.969830274581909 7.395659923553467 3.911400318145752 7.336800098419189 L 2.7576003074646 6.170400142669678 C 2.695760250091553 6.108550071716309 2.662200212478638 6.026730060577393 2.663100242614746 5.940000057220459 C 2.664000272750854 5.853129863739014 2.698840141296387 5.771950244903564 2.761200189590454 5.711400032043457 C 4.090540409088135 4.474770069122314 5.822390079498291 3.793730020523071 7.637740135192871 3.793730020523071 C 9.453080177307129 3.793730020523071 11.18469047546387 4.474770069122314 12.51360034942627 5.711400032043457 C 12.57653999328613 5.772520065307617 12.6117000579834 5.853700160980225 12.61260032653809 5.940000057220459 C 12.61348056793213 6.025149822235107 12.57937049865723 6.109119892120361 12.51900005340576 6.170400142669678 L 11.36429977416992 7.336800098419189 C 11.30543994903564 7.395649909973145 11.22735023498535 7.428060054779053 11.14441013336182 7.428060054779053 Z M 13.8044900894165 4.7430100440979 C 13.7237606048584 4.743000030517578 13.64759063720703 4.711989879608154 13.59000015258789 4.655700206756592 C 11.9755802154541 3.121769905090332 9.861249923706055 2.276999950408936 7.636500358581543 2.276999950408936 C 5.410800457000732 2.276999950408936 3.296470165252686 3.121769905090332 1.683000206947327 4.655700206756592 C 1.625420212745667 4.711989879608154 1.549220204353333 4.743000030517578 1.468440175056458 4.7430100440979 C 1.385690212249756 4.743020057678223 1.307830214500427 4.710730075836182 1.249200224876404 4.652100086212158 L 0.09360022097826004 3.485699892044067 C 0.03235022351145744 3.423540115356445 -0.0008897756924852729 3.342350006103516 2.24304201879022e-07 3.257100105285645 C 0.0009102242765948176 3.170550107955933 0.0351102240383625 3.089679956436157 0.09630022197961807 3.029400110244751 C 2.134720325469971 1.075860023498535 4.81242036819458 6.866454960174906e-09 7.636160373687744 6.866454960174906e-09 C 10.45989990234375 6.866454960174906e-09 13.13784980773926 1.075860023498535 15.17670059204102 3.029400110244751 C 15.23733043670654 3.090039968490601 15.2721004486084 3.173029899597168 15.2721004486084 3.257100105285645 C 15.27299022674561 3.342350006103516 15.23974990844727 3.423540115356445 15.17850017547607 3.485699892044067 L 14.02290058135986 4.652100086212158 C 13.96471977233887 4.710730075836182 13.88714981079102 4.7430100440979 13.8044900894165 4.7430100440979 Z" fill="#3e4a59" fill-opacity="0.45" stroke="none" stroke-width="1" stroke-opacity="0.45" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
// const String _svg_g4nwbn =
//     '<svg viewBox="272.7 0.7 17.0 10.7" ><path transform="translate(272.67, 0.67)" d="M 16.00020027160645 10.6668004989624 L 15.00030040740967 10.6668004989624 C 14.44895076751709 10.6668004989624 14.00040054321289 10.2182502746582 14.00040054321289 9.666900634765625 L 14.00040054321289 0.999900221824646 C 14.00040054321289 0.4485502541065216 14.44895076751709 2.494811894848681e-07 15.00030040740967 2.494811894848681e-07 L 16.00020027160645 2.494811894848681e-07 C 16.55154991149902 2.494811894848681e-07 17.00010108947754 0.4485502541065216 17.00010108947754 0.999900221824646 L 17.00010108947754 9.666900634765625 C 17.00010108947754 10.2182502746582 16.55154991149902 10.6668004989624 16.00020027160645 10.6668004989624 Z M 11.33370018005371 10.6668004989624 L 10.33290100097656 10.6668004989624 C 9.781550407409668 10.6668004989624 9.333000183105469 10.2182502746582 9.333000183105469 9.666900634765625 L 9.333000183105469 3.333600282669067 C 9.333000183105469 2.782250165939331 9.781550407409668 2.333700180053711 10.33290100097656 2.333700180053711 L 11.33370018005371 2.333700180053711 C 11.88505077362061 2.333700180053711 12.3336009979248 2.782250165939331 12.3336009979248 3.333600282669067 L 12.3336009979248 9.666900634765625 C 12.3336009979248 10.2182502746582 11.88505077362061 10.6668004989624 11.33370018005371 10.6668004989624 Z M 6.666300773620605 10.6668004989624 L 5.66640043258667 10.6668004989624 C 5.115050315856934 10.6668004989624 4.666500568389893 10.2182502746582 4.666500568389893 9.666900634765625 L 4.666500568389893 5.66640043258667 C 4.666500568389893 5.115050315856934 5.115050315856934 4.666500091552734 5.66640043258667 4.666500091552734 L 6.666300773620605 4.666500091552734 C 7.218140602111816 4.666500091552734 7.667100429534912 5.115050315856934 7.667100429534912 5.66640043258667 L 7.667100429534912 9.666900634765625 C 7.667100429534912 10.2182502746582 7.218140602111816 10.6668004989624 6.666300773620605 10.6668004989624 Z M 1.999800562858582 10.6668004989624 L 0.9999005198478699 10.6668004989624 C 0.4485505521297455 10.6668004989624 5.447387820822769e-07 10.2182502746582 5.447387820822769e-07 9.666900634765625 L 5.447387820822769e-07 7.667100429534912 C 5.447387820822769e-07 7.115260124206543 0.4485505521297455 6.666300296783447 0.9999005198478699 6.666300296783447 L 1.999800562858582 6.666300296783447 C 2.551150560379028 6.666300296783447 2.999700546264648 7.115260124206543 2.999700546264648 7.667100429534912 L 2.999700546264648 9.666900634765625 C 2.999700546264648 10.2182502746582 2.551150560379028 10.6668004989624 1.999800562858582 10.6668004989624 Z" fill="#3e4a59" fill-opacity="0.45" stroke="none" stroke-width="1" stroke-opacity="0.45" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';



class LOGIN extends StatelessWidget {
  LOGIN({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(30.0, 593.0),
            child:
                // Adobe XD layer: 'Services' (group)
                SizedBox(
              width: 490.0,
              height: 174.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 315.0, 26.0),
                    size: Size(490.0, 174.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Title' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 105.0, 26.0),
                          size: Size(315.0, 26.0),
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'My Services' (text)
                              Text(
                            'My Services',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              color: const Color(0xff132051),
                              letterSpacing: -0.4166666793823242,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(266.0, 4.0, 49.0, 19.0),
                          size: Size(315.0, 26.0),
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'View All' (text)
                              Text(
                            'View All',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: const Color(0xfff7b701),
                              letterSpacing: -0.25000000762939456,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 56.0, 235.0, 118.0),
                    size: Size(490.0, 174.0),
                    pinLeft: true,
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Service' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 235.0, 118.0),
                          size: Size(235.0, 118.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Bg' (shape)
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xfff1f1f9),
                            ),
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(95.0, 35.0, 92.0, 48.0),
                          size: Size(235.0, 118.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Text' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 68.0, 24.0),
                                size: Size(92.0, 48.0),
                                fixedHeight: true,
                                child:
                                    // Adobe XD layer: 'Shipping' (text)
                                    Text(
                                  'Shipping',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    color: const Color(0xff132051),
                                    letterSpacing: -0.28125,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 29.0, 92.0, 19.0),
                                size: Size(92.0, 48.0),
                                fixedHeight: true,
                                child:
                                    // Adobe XD layer: 'Secure Delivery' (text)
                                    Text(
                                  'Secure Delivery',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    color: const Color(0xff8d93ac),
                                    letterSpacing: -0.21875,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(30.0, 34.0, 50.0, 50.0),
                          size: Size(235.0, 118.0),
                          pinLeft: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Icon' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
                                size: Size(50.0, 50.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Rectangle' (shape)
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: const Color(0xff4e73ff),
                                  ),
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(14.0, 15.0, 21.0, 21.0),
                                size: Size(50.0, 50.0),
                                fixedWidth: true,
                                fixedHeight: true,
                                child:
                                    // Adobe XD layer: 'ios-send' (group)
                                    Stack(
                                  children: <Widget>[
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(0.0, 0.0, 21.0, 21.0),
                                      size: Size(21.0, 21.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Path' (shape)
                                          SvgPicture.string(
                                        _svg_ufmi4r,
                                        allowDrawingOutsideViewBox: true,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(255.0, 56.0, 235.0, 118.0),
                    size: Size(490.0, 174.0),
                    pinRight: true,
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Service' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 235.0, 118.0),
                          size: Size(235.0, 118.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Bg' (shape)
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xfff1f1f9),
                            ),
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(95.0, 35.0, 92.0, 48.0),
                          size: Size(235.0, 118.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Text' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 68.0, 24.0),
                                size: Size(92.0, 48.0),
                                fixedHeight: true,
                                child:
                                    // Adobe XD layer: 'Shipping' (text)
                                    Text(
                                  'Shipping',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    color: const Color(0xff132051),
                                    letterSpacing: -0.28125,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 29.0, 92.0, 19.0),
                                size: Size(92.0, 48.0),
                                fixedHeight: true,
                                child:
                                    // Adobe XD layer: 'Secure Delivery' (text)
                                    Text(
                                  'Secure Delivery',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    color: const Color(0xff8d93ac),
                                    letterSpacing: -0.21875,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(30.0, 34.0, 50.0, 50.0),
                          size: Size(235.0, 118.0),
                          pinLeft: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Icon' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
                                size: Size(50.0, 50.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Rectangle' (shape)
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: const Color(0xfff7b701),
                                  ),
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(17.0, 14.0, 16.0, 23.0),
                                size: Size(50.0, 50.0),
                                fixedWidth: true,
                                fixedHeight: true,
                                child:
                                    // Adobe XD layer: 'ios-pin' (group)
                                    Stack(
                                  children: <Widget>[
                                    Pinned.fromSize(
                                      bounds:
                                          Rect.fromLTWH(0.0, 0.0, 16.0, 23.0),
                                      size: Size(16.0, 23.0),
                                      pinLeft: true,
                                      pinRight: true,
                                      pinTop: true,
                                      pinBottom: true,
                                      child:
                                          // Adobe XD layer: 'Shape' (shape)
                                          SvgPicture.string(
                                        _svg_nza7ok,
                                        allowDrawingOutsideViewBox: true,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Adobe XD layer: 'Illustration Back' (group)
          SizedBox(
            width: 375.0,
            height: 530.0,
            child: Stack(
              children: <Widget>[
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 530.0),
                  size: Size(375.0, 530.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'Mask' (shape)
                      SvgPicture.string(
                    _svg_6bidgc,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromSize(
                  bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 530.0),
                  size: Size(375.0, 530.0),
                  pinLeft: true,
                  pinRight: true,
                  pinTop: true,
                  pinBottom: true,
                  child:
                      // Adobe XD layer: 'Illustration Back' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(-68.0, 293.0, 183.0, 246.0),
                        size: Size(375.0, 530.0),
                        pinLeft: true,
                        pinBottom: true,
                        fixedWidth: true,
                        fixedHeight: true,
                        child:
                            // Adobe XD layer: 'Phone' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(0.0, 2.0, 183.0, 244.0),
                              size: Size(183.0, 246.0),
                              pinLeft: true,
                              pinRight: true,
                              pinTop: true,
                              pinBottom: true,
                              child:
                                  // Adobe XD layer: 'Path' (shape)
                                  SvgPicture.string(
                                _svg_e1lnq5,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(5.0, 0.0, 178.0, 238.0),
                              size: Size(183.0, 246.0),
                              pinLeft: true,
                              pinRight: true,
                              pinTop: true,
                              pinBottom: true,
                              child:
                                  // Adobe XD layer: 'Path' (shape)
                                  SvgPicture.string(
                                _svg_ykpyq3,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(15.0, 26.0, 156.0, 182.0),
                              size: Size(183.0, 246.0),
                              pinLeft: true,
                              pinRight: true,
                              pinTop: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Path' (shape)
                                  SvgPicture.string(
                                _svg_fv1k6p,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(56.0, 13.0, 21.0, 2.0),
                              size: Size(183.0, 246.0),
                              pinTop: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Path' (shape)
                                  SvgPicture.string(
                                _svg_42qn70,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(52.2, 12.2, 2.1, 2.6),
                              size: Size(183.0, 246.0),
                              pinTop: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child: Transform.rotate(
                                angle: -0.855,
                                child:
                                    // Adobe XD layer: 'Oval' (shape)
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xff8686b7),
                                  ),
                                ),
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(121.5, 213.0, 13.8, 18.2),
                              size: Size(183.0, 246.0),
                              pinBottom: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child: Transform.rotate(
                                angle: -0.855,
                                child:
                                    // Adobe XD layer: 'Oval' (shape)
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xffcccaf4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(36.1, 296.0, 146.7, 259.0),
                        size: Size(375.0, 530.0),
                        pinLeft: true,
                        pinBottom: true,
                        fixedWidth: true,
                        fixedHeight: true,
                        child:
                            // Adobe XD layer: 'Man Illustration' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(0.0, 237.0, 35.5, 21.4),
                              size: Size(146.7, 259.0),
                              pinLeft: true,
                              pinBottom: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Left-Shoe_1_' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 35.5, 21.4),
                                    size: Size(35.5, 21.4),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 35.5, 21.4),
                                          size: Size(35.5, 21.4),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Path' (shape)
                                              SvgPicture.string(
                                            _svg_qdut7v,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(39.0, 25.0, 20.8, 24.6),
                              size: Size(146.7, 259.0),
                              pinTop: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Nexk_3_' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(1.0, 0.0, 16.8, 22.7),
                                    size: Size(20.8, 24.6),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Mask_3_' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 16.8, 22.7),
                                          size: Size(16.8, 22.7),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Path' (shape)
                                              SvgPicture.string(
                                            _svg_cwexgu,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 8.5, 20.8, 16.2),
                                    size: Size(20.8, 24.6),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinBottom: true,
                                    fixedHeight: true,
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 20.8, 16.2),
                                          size: Size(20.8, 16.2),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Group' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromSize(
                                                bounds: Rect.fromLTWH(
                                                    0.0, 0.0, 20.8, 16.2),
                                                size: Size(20.8, 16.2),
                                                pinLeft: true,
                                                pinRight: true,
                                                pinTop: true,
                                                pinBottom: true,
                                                child:
                                                    // Adobe XD layer: 'Rectangle' (shape)
                                                    Container(
                                                  decoration: BoxDecoration(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(2.1, 132.1, 69.3, 112.7),
                              size: Size(146.7, 259.0),
                              pinLeft: true,
                              pinBottom: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Left-Leg_1_' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds:
                                        Rect.fromLTWH(0.0, 0.0, 69.3, 112.7),
                                    size: Size(69.3, 112.7),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 69.3, 112.7),
                                          size: Size(69.3, 112.7),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Path' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromSize(
                                                bounds: Rect.fromLTWH(
                                                    0.0, 0.0, 69.3, 112.7),
                                                size: Size(69.3, 112.7),
                                                pinLeft: true,
                                                pinRight: true,
                                                pinTop: true,
                                                pinBottom: true,
                                                child:
                                                    // Adobe XD layer: 'Path' (shape)
                                                    SvgPicture.string(
                                                  _svg_mq69ll,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Pinned.fromSize(
                                                bounds: Rect.fromLTWH(
                                                    0.0, 0.0, 69.3, 112.7),
                                                size: Size(69.3, 112.7),
                                                pinLeft: true,
                                                pinRight: true,
                                                pinTop: true,
                                                pinBottom: true,
                                                child:
                                                    // Adobe XD layer: 'Path' (shape)
                                                    SvgPicture.string(
                                                  _svg_mtzsn1,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(81.4, 19.3, 54.3, 44.6),
                              size: Size(146.7, 259.0),
                              pinRight: true,
                              pinTop: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Small-Box_1_' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 54.3, 44.6),
                                    size: Size(54.3, 44.6),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 54.3, 44.6),
                                          size: Size(54.3, 44.6),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Path' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromSize(
                                                bounds: Rect.fromLTWH(
                                                    0.0, 0.0, 54.3, 44.6),
                                                size: Size(54.3, 44.6),
                                                pinLeft: true,
                                                pinRight: true,
                                                pinTop: true,
                                                pinBottom: true,
                                                child:
                                                    // Adobe XD layer: 'Path' (shape)
                                                    SvgPicture.string(
                                                  _svg_9qngbm,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Pinned.fromSize(
                                                bounds: Rect.fromLTWH(
                                                    0.0, 0.0, 54.3, 44.6),
                                                size: Size(54.3, 44.6),
                                                pinLeft: true,
                                                pinRight: true,
                                                pinTop: true,
                                                pinBottom: true,
                                                child:
                                                    // Adobe XD layer: 'Path' (shape)
                                                    SvgPicture.string(
                                                  _svg_yxwpml,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(66.9, 60.1, 79.8, 56.3),
                              size: Size(146.7, 259.0),
                              pinRight: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Large-Box_1_' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 79.8, 56.3),
                                    size: Size(79.8, 56.3),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 79.8, 56.3),
                                          size: Size(79.8, 56.3),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Path' (group)
                                              Stack(
                                            children: <Widget>[
                                              Pinned.fromSize(
                                                bounds: Rect.fromLTWH(
                                                    0.0, 0.0, 79.8, 56.3),
                                                size: Size(79.8, 56.3),
                                                pinLeft: true,
                                                pinRight: true,
                                                pinTop: true,
                                                pinBottom: true,
                                                child:
                                                    // Adobe XD layer: 'Path' (shape)
                                                    SvgPicture.string(
                                                  _svg_50hdys,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Pinned.fromSize(
                                                bounds: Rect.fromLTWH(
                                                    0.0, 0.0, 79.8, 56.3),
                                                size: Size(79.8, 56.3),
                                                pinLeft: true,
                                                pinRight: true,
                                                pinTop: true,
                                                pinBottom: true,
                                                child:
                                                    // Adobe XD layer: 'Path' (shape)
                                                    SvgPicture.string(
                                                  _svg_okqjwz,
                                                  allowDrawingOutsideViewBox:
                                                      true,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(25.4, 39.0, 48.2, 99.5),
                              size: Size(146.7, 259.0),
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Shirt_1_' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 48.2, 99.5),
                                    size: Size(48.2, 99.5),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 48.2, 99.5),
                                          size: Size(48.2, 99.5),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Path' (shape)
                                              SvgPicture.string(
                                            _svg_9ggqil,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(36.0, 78.3, 73.6, 43.5),
                              size: Size(146.7, 259.0),
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Right-Hand_1_' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 73.6, 43.5),
                                    size: Size(73.6, 43.5),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 73.6, 43.5),
                                          size: Size(73.6, 43.5),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Path' (shape)
                                              SvgPicture.string(
                                            _svg_qeamkn,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(62.1, 244.3, 37.4, 14.7),
                              size: Size(146.7, 259.0),
                              pinBottom: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Right-Shoe_1_' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 37.4, 14.7),
                                    size: Size(37.4, 14.7),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Group' (group)
                                        Stack(
                                      children: <Widget>[
                                        Pinned.fromSize(
                                          bounds: Rect.fromLTWH(
                                              0.0, 0.0, 37.4, 14.7),
                                          size: Size(37.4, 14.7),
                                          pinLeft: true,
                                          pinRight: true,
                                          pinTop: true,
                                          pinBottom: true,
                                          child:
                                              // Adobe XD layer: 'Path' (shape)
                                              SvgPicture.string(
                                            _svg_jxh4kx,
                                            allowDrawingOutsideViewBox: true,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(38.0, 132.1, 53.8, 117.9),
                              size: Size(146.7, 259.0),
                              pinBottom: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Path' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds:
                                        Rect.fromLTWH(0.0, 0.0, 53.8, 117.9),
                                    size: Size(53.8, 117.9),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Path' (shape)
                                        SvgPicture.string(
                                      _svg_5zad4y,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds:
                                        Rect.fromLTWH(0.0, 0.0, 53.8, 117.9),
                                    size: Size(53.8, 117.9),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Path' (shape)
                                        SvgPicture.string(
                                      _svg_ruyvve,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(30.9, 0.0, 31.0, 35.0),
                              size: Size(146.7, 259.0),
                              pinTop: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Path' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 31.0, 35.0),
                                    size: Size(31.0, 35.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Path' (shape)
                                        SvgPicture.string(
                                      _svg_9aqj62,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 31.0, 35.0),
                                    size: Size(31.0, 35.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Path' (shape)
                                        SvgPicture.string(
                                      _svg_9j8yg4,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromSize(
                              bounds: Rect.fromLTWH(37.9, 8.0, 27.0, 31.0),
                              size: Size(146.7, 259.0),
                              pinTop: true,
                              fixedWidth: true,
                              fixedHeight: true,
                              child:
                                  // Adobe XD layer: 'Path' (group)
                                  Stack(
                                children: <Widget>[
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 27.0, 31.0),
                                    size: Size(27.0, 31.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Path' (shape)
                                        SvgPicture.string(
                                      _svg_kbtf5x,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Pinned.fromSize(
                                    bounds: Rect.fromLTWH(0.0, 0.0, 27.0, 31.0),
                                    size: Size(27.0, 31.0),
                                    pinLeft: true,
                                    pinRight: true,
                                    pinTop: true,
                                    pinBottom: true,
                                    child:
                                        // Adobe XD layer: 'Path' (shape)
                                        SvgPicture.string(
                                      _svg_vez6m5,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Pinned.fromSize(
                        bounds: Rect.fromLTWH(0.0, 0.0, 375.0, 530.0),
                        size: Size(375.0, 530.0),
                        pinLeft: true,
                        pinRight: true,
                        pinTop: true,
                        pinBottom: true,
                        child:
                            // Adobe XD layer: 'Mask' (shape)
                            SvgPicture.string(
                          _svg_6bidgc,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(30.0, 220.0),
            child:
                // Adobe XD layer: 'Form' (group)
                SizedBox(
              width: 315.0,
              height: 60.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 315.0, 60.0),
                    size: Size(315.0, 60.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Rectangle' (shape)
                        Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffffffff),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff1134b9),
                            offset: Offset(0, 20),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(56.0, 21.0, 75.0, 19.0),
                    size: Size(315.0, 60.0),
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'eg. 4729012' (text)
                        Text(
                      'eg. 4729012',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        color: const Color(0xff8d93ac),
                        letterSpacing: -0.21875,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(20.0, 23.0, 16.0, 15.0),
                    size: Size(315.0, 60.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'ios-filing' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 16.0, 15.0),
                          size: Size(16.0, 15.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Shape' (shape)
                              SvgPicture.string(
                            _svg_wvi8el,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(3.0, 3.0, 11.0, 3.0),
                          size: Size(16.0, 15.0),
                          pinLeft: true,
                          pinRight: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Shape' (shape)
                              SvgPicture.string(
                            _svg_6d3q5k,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(279.0, 22.0, 16.0, 16.0),
                    size: Size(315.0, 60.0),
                    pinRight: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'ios-arrow-dropright…' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 16.0, 16.0),
                          size: Size(16.0, 16.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Shape' (shape)
                              SvgPicture.string(
                            _svg_9a53p,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(236.0, 260.0),
            child:
                // Adobe XD layer: 'Illustration Front' (group)
                SizedBox(
              width: 164.0,
              height: 283.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 164.0, 283.0),
                    size: Size(164.0, 283.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'Woman Illustration' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(78.0, 224.0, 30.0, 38.0),
                          size: Size(164.0, 283.0),
                          pinBottom: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 38.0),
                                size: Size(30.0, 38.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_pue9eo,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 38.0),
                                size: Size(30.0, 38.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_989czl,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(43.0, 226.0, 42.0, 32.0),
                          size: Size(164.0, 283.0),
                          pinBottom: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (shape)
                              SvgPicture.string(
                            _svg_9xalu1,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(36.0, 183.0, 36.0, 19.0),
                          size: Size(164.0, 283.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (shape)
                              SvgPicture.string(
                            _svg_orccce,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 38.0, 102.0),
                          size: Size(164.0, 283.0),
                          pinLeft: true,
                          pinTop: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 38.0, 102.0),
                                size: Size(38.0, 102.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_8vcrvl,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 38.0, 102.0),
                                size: Size(38.0, 102.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_utix5v,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(12.0, 61.0, 85.0, 85.0),
                          size: Size(164.0, 283.0),
                          pinLeft: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 85.0, 85.0),
                                size: Size(85.0, 85.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_2tn1dk,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 85.0, 85.0),
                                size: Size(85.0, 85.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_in1hnd,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(25.0, 105.0, 59.0, 87.0),
                          size: Size(164.0, 283.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 59.0, 87.0),
                                size: Size(59.0, 87.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_s4adwp,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 59.0, 87.0),
                                size: Size(59.0, 87.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_pdzn90,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(40.0, 104.0, 23.0, 19.0),
                          size: Size(164.0, 283.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (shape)
                              SvgPicture.string(
                            _svg_p1iz59,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(45.0, 77.0, 26.0, 35.0),
                          size: Size(164.0, 283.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 26.0, 35.0),
                                size: Size(26.0, 35.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_usqjnp,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 26.0, 35.0),
                                size: Size(26.0, 35.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_2v1xkz,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(71.0, 26.0, 92.0, 92.0),
                          size: Size(164.0, 283.0),
                          pinRight: true,
                          pinTop: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 92.0, 92.0),
                                size: Size(92.0, 92.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_8jomso,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 92.0, 92.0),
                                size: Size(92.0, 92.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_8rspuu,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(72.0, 25.0, 92.0, 98.0),
                          size: Size(164.0, 283.0),
                          pinRight: true,
                          pinTop: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (shape)
                              SvgPicture.string(
                            _svg_ovzsmd,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(4.0, 197.0, 82.0, 86.0),
                          size: Size(164.0, 283.0),
                          pinLeft: true,
                          pinBottom: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 82.0, 86.0),
                                size: Size(82.0, 86.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_unz8mu,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 82.0, 86.0),
                                size: Size(82.0, 86.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_agk6ni,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(80.0, 239.0, 26.0, 41.0),
                          size: Size(164.0, 283.0),
                          pinBottom: true,
                          fixedWidth: true,
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Path' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 26.0, 41.0),
                                size: Size(26.0, 41.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_r4zuuk,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 26.0, 41.0),
                                size: Size(26.0, 41.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Path' (shape)
                                    SvgPicture.string(
                                  _svg_oacz7v,
                                  allowDrawingOutsideViewBox: true,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(74.5, 127.0),
            child:
                // Adobe XD layer: 'Title' (group)
                SizedBox(
              width: 226.0,
              height: 63.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 226.0, 32.0),
                    size: Size(226.0, 63.0),
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Track your Shippment' (text)
                        Text(
                      'Track your Shippment',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        color: const Color(0xffffffff),
                        letterSpacing: -0.500000015258789,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(47.0, 42.0, 132.0, 21.0),
                    size: Size(226.0, 63.0),
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Enter tracking code' (text)
                        Text(
                      'Enter tracking code',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: const Color(0xffffffff),
                        letterSpacing: -0.25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(30.0, 40.0),
            child:
                // Adobe XD layer: 'Header' (group)
                SizedBox(
              width: 315.0,
              height: 37.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(295.0, 9.0, 20.0, 20.0),
                    size: Size(315.0, 37.0),
                    pinRight: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'ios-settings' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 20.0, 20.0),
                          size: Size(20.0, 20.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Shape' (shape)
                              SvgPicture.string(
                            _svg_z7vau7,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 4.0, 30.0, 30.0),
                    size: Size(315.0, 37.0),
                    pinLeft: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'Avatar' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
                          size: Size(30.0, 30.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Mask' (shape)
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xffd8d8d8),
                            ),
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
                          size: Size(30.0, 30.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child:
                              // Adobe XD layer: 'Avatar' (group)
                              Stack(
                            children: <Widget>[
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
                                size: Size(30.0, 30.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Avatar' (shape)
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: const AssetImage(''),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Pinned.fromSize(
                                bounds: Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
                                size: Size(30.0, 30.0),
                                pinLeft: true,
                                pinRight: true,
                                pinTop: true,
                                pinBottom: true,
                                child:
                                    // Adobe XD layer: 'Mask' (shape)
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: const Color(0xffd8d8d8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(106.0, 0.0, 104.0, 37.0),
                    size: Size(315.0, 37.0),
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'Title' (group)
                        Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(14.5, 0.0, 74.0, 19.0),
                          size: Size(104.0, 37.0),
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Tracker App' (text)
                              Text(
                            'Tracker App',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14,
                              color: const Color(0xffffffff),
                              letterSpacing: -0.25000000762939456,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 21.0, 104.0, 16.0),
                          size: Size(104.0, 37.0),
                          fixedHeight: true,
                          child:
                              // Adobe XD layer: 'Powered by Panoply' (text)
                              Text(
                            'Powered by Panoply',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              color: const Color(0xffa8b6ea),
                              letterSpacing: -0.2142857208251953,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_ufmi4r =
    '<svg viewBox="0.0 1.0 21.0 21.0" ><path transform="translate(0.0, 0.97)" d="M 20.33812141418457 0.0470317155122757 L 0.2605700194835663 8.798786163330078 C -0.09493006765842438 8.968352317810059 -0.08399160951375961 9.477047920227051 0.2769777178764343 9.635673522949219 L 5.707925319671631 12.70425701141357 C 6.030610084533691 12.88476181030273 6.429863929748535 12.84647369384766 6.708794593811035 12.60579967498779 L 17.41755104064941 3.372698545455933 C 17.48865127563477 3.312530279159546 17.6581974029541 3.197663545608521 17.72382736206055 3.263301610946655 C 17.7949275970459 3.334409713745117 17.68554306030273 3.498505115509033 17.62538146972656 3.569612979888916 L 8.360503196716309 14.00608062744141 C 8.103448867797852 14.29598236083984 8.065164566040039 14.72263050079346 8.272994995117188 15.05082130432129 L 11.8225269317627 20.74493217468262 C 11.99754238128662 21.08953285217285 12.49524211883545 21.08406257629395 12.65384960174561 20.7339916229248 L 20.95614433288574 0.6541846990585327 C 21.13662910461426 0.2603557407855988 20.72643661499023 -0.138943076133728 20.33812141418457 0.0470317155122757 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_nza7ok =
    '<svg viewBox="0.0 0.0 16.0 23.0" ><path  d="M 8.000100135803223 23.00039291381836 L 7.999320030212402 22.99943351745605 C 7.9169602394104 22.89768409729004 5.959770202636719 20.47159385681152 4.000040054321289 17.35232353210449 C 2.175240039825439 14.44781398773193 1.358032193365943e-07 10.3620138168335 1.358032193365943e-07 7.391703605651855 C 1.358032193365943e-07 3.315903663635254 3.588830232620239 3.678894017866696e-06 8.000100135803223 3.678894017866696e-06 C 12.41137027740479 3.678894017866696e-06 16.00020027160645 3.315903663635254 16.00020027160645 7.391703605651855 C 16.00020027160645 10.36203384399414 13.82495021820068 14.44783401489258 12.00014972686768 17.35234451293945 C 10.04041004180908 20.47161293029785 8.083230018615723 22.89768409729004 8.000880241394043 22.99943351745605 L 8.000100135803223 23.00039291381836 Z M 8.000100135803223 5.368503570556641 C 6.563420295715332 5.368503570556641 5.394599914550781 6.531673908233643 5.394599914550781 7.961403846740723 C 5.394599914550781 9.391133308410645 6.563420295715332 10.5543041229248 8.000100135803223 10.5543041229248 C 9.436779975891113 10.5543041229248 10.60560035705566 9.391133308410645 10.60560035705566 7.961403846740723 C 10.60560035705566 6.531673908233643 9.436779975891113 5.368503570556641 8.000100135803223 5.368503570556641 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_e1lnq5 =
    '<svg viewBox="0.0 3.0 183.0 244.0" ><path transform="translate(0.0, 3.0)" d="M 78.92916107177734 244 L 165.6980590820313 244 C 174.4507598876953 244 185.0642700195313 231.0527801513672 182.6521148681641 222.3065185546875 L 119.1777954101563 21.28027153015137 C 116.6967163085938 12.534010887146 107.5994186401367 5.371718883514404 98.77780151367188 5.371718883514404 L 9.458901405334473 0 C 4.221065044403076 3.787750482559204 -1.912717580795288 12.534010887146 0.5683629512786865 21.41800689697266 L 58.5291633605957 228.1603088378906 C 60.94132232666016 236.8377075195313 70.10753631591797 244 78.92916107177734 244 Z" fill="#8686b7" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ykpyq3 =
    '<svg viewBox="5.0 1.0 178.0 238.0" ><path transform="translate(5.0, 1.0)" d="M 79.03141021728516 238 L 165.8857879638672 238 C 174.6471099853516 238 179.8211212158203 230.8545074462891 177.4065856933594 222.1287536621094 L 119.3886871337891 15.87124729156494 C 116.905158996582 7.145496368408203 107.7989044189453 0 98.96858978271484 0 L 12.1142110824585 0 C 3.352887868881226 0 -1.821122169494629 7.145496368408203 0.5934157967567444 15.87124729156494 L 58.61131286621094 222.1287536621094 C 61.09484100341797 230.8545074462891 70.27008056640625 238 79.03141021728516 238 Z" fill="#e9e9ff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_fv1k6p =
    '<svg viewBox="15.0 27.0 156.0 182.0" ><path transform="translate(15.0, 27.0)" d="M 156 182 L 50.83377456665039 182 L 0 0 L 105.0976257324219 0 L 156 182 Z" fill="#cccaf4" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_42qn70 =
    '<svg viewBox="56.0 14.0 21.0 2.0" ><path transform="translate(56.0, 14.0)" d="M 20.11294555664063 2 L 1.581130743026733 2 C 0.9564629197120667 2 0.2623874843120575 1.588235259056091 0.05416486784815788 1 L 0.05416486784815788 1 C -0.1540577560663223 0.4705882370471954 0.2623874843120575 0 0.8870553970336914 0 L 19.41886901855469 0 C 20.04353713989258 0 20.73761177062988 0.4117647111415863 20.94583511352539 1 L 20.94583511352539 1 C 21.1540584564209 1.529411792755127 20.73761177062988 2 20.11294555664063 2 Z" fill="#8686b7" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_qdut7v =
    '<svg viewBox="0.1 0.0 35.5 21.4" ><path transform="translate(0.15, 0.0)" d="M 21.82280921936035 6.097142696380615 C 22.75384330749512 8.548571586608887 24.11936187744141 10.05714321136475 25.85729217529297 10.68571472167969 C 28.34004974365234 11.62857151031494 32.68487930297852 9.994285583496094 34.60901641845703 12.69714260101318 C 36.65729141235352 15.39999961853027 34.60901641845703 19.92571449279785 32.87108612060547 20.74285697937012 C 31.13315391540527 21.55999946594238 23.93315315246582 22.12571334838867 20.0228099822998 19.54857063293457 C 16.11246490478516 17.03428649902344 2.519361019134521 12.94857120513916 0.5331540703773499 10.30857181549072 C -0.8323631882667542 8.548571586608887 0.4090161323547363 5.154285907745361 4.443499088287354 0 C 6.243498802185059 1.382857084274292 8.850395202636719 3.017142772674561 12.38832664489746 4.274285793304443 C 16.17453384399414 5.657142639160156 19.5262565612793 5.971428394317627 21.82280921936035 6.097142696380615 Z" fill="#fdbc00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_cwexgu =
    '<svg viewBox="0.5 0.0 16.8 22.7" ><path transform="translate(0.53, 0.03)" d="M 0.02841893397271633 1.498912930488586 C 0.3990071713924408 4.059888362884521 1.572536587715149 12.53549861907959 0.52253657579422 13.57208347320557 C -0.1568751782178879 19.73061943054199 1.572536587715149 22.71842575073242 5.587242603302002 22.71842575073242 C 9.601948738098145 22.71842575073242 13.30783081054688 22.53549766540527 16.76665496826172 22.04769325256348 C 15.90194797515869 20.82818031311035 15.22253704071045 19.42574310302734 14.85194873809814 17.96232795715332 C 14.48136043548584 16.43793678283691 14.54312515258789 6.742815494537354 14.72841930389404 5.706230163574219 C 5.525477886199951 -0.757184624671936 -0.4656987190246582 -1.062062740325928 0.02841893397271633 1.498912930488586 Z" fill="#ff83ac" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_mq69ll =
    '<svg viewBox="0.2 0.1 69.3 112.7" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff1b6ac0"  /><stop offset="1.0" stop-color="#ff0c388c"  /></linearGradient></defs><path transform="translate(0.25, 0.06)" d="M 36.47368240356445 4.93989086151123 C 40.95613861083984 22.72349739074707 35.73684310913086 47.66994476318359 32.85087585449219 56.37650299072266 C 30.02631568908691 65.08306121826172 21 75.2098388671875 0 107.1338806152344 C 2.640350818634033 108.4923477172852 6.0789475440979 109.9125671386719 10.19298267364502 110.9622955322266 C 14.85964870452881 112.197265625 18.91228103637695 112.567756652832 22.16666603088379 112.6912536621094 C 39.91228103637695 87.9300537109375 36.10526275634766 95.46338653564453 54.28070068359375 67.36775970458984 C 63 53.90655899047852 69.57017517089844 21.42677688598633 69.32456207275391 0 L 36.47368240356445 4.93989086151123 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_mtzsn1 =
    '<svg viewBox="0.2 0.1 69.3 112.7" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(0.25, 0.06)" d="M 36.47368240356445 4.93989086151123 C 40.95613861083984 22.72349739074707 35.73684310913086 47.66994476318359 32.85087585449219 56.37650299072266 C 30.02631568908691 65.08306121826172 21 75.2098388671875 0 107.1338806152344 C 2.640350818634033 108.4923477172852 6.0789475440979 109.9125671386719 10.19298267364502 110.9622955322266 C 14.85964870452881 112.197265625 18.91228103637695 112.567756652832 22.16666603088379 112.6912536621094 C 39.91228103637695 87.9300537109375 36.10526275634766 95.46338653564453 54.28070068359375 67.36775970458984 C 63 53.90655899047852 69.57017517089844 21.42677688598633 69.32456207275391 0 L 36.47368240356445 4.93989086151123 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_9qngbm =
    '<svg viewBox="0.5 0.3 54.3 44.6" ><path transform="translate(0.52, 0.3)" d="M 2.107067823410034 44.5755729675293 C 0.04456791654229164 17.20057106018066 -0.5179320573806763 3.26307201385498 0.4820679128170013 2.57557201385498 C 1.857067942619324 1.63807201385498 51.5445671081543 -0.7994280457496643 52.9195671081543 0.2630719542503357 C 53.7945671081543 0.9505719542503357 54.2945671081543 14.95057201385498 54.2945671081543 42.2630729675293 L 2.107067823410034 44.5755729675293 Z" fill="#e99d00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_yxwpml =
    '<svg viewBox="0.5 0.3 54.3 44.6" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(0.52, 0.3)" d="M 2.107067823410034 44.5755729675293 C 0.04456791654229164 17.20057106018066 -0.5179320573806763 3.26307201385498 0.4820679128170013 2.57557201385498 C 1.857067942619324 1.63807201385498 51.5445671081543 -0.7994280457496643 52.9195671081543 0.2630719542503357 C 53.7945671081543 0.9505719542503357 54.2945671081543 14.95057201385498 54.2945671081543 42.2630729675293 L 2.107067823410034 44.5755729675293 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_50hdys =
    '<svg viewBox="0.0 0.1 79.8 56.3" ><path transform="translate(0.03, 0.1)" d="M 0.214817151427269 4.064693450927734 C 1.269080758094788 3.145338535308838 74.88148498535156 -0.5933712124824524 76.24582672119141 0.08082231879234314 C 77.61016845703125 0.7550158500671387 80.95899963378906 50.15501403808594 79.34660339355469 51.50340270996094 C 77.61016845703125 52.85179138183594 5.362103939056396 57.0808219909668 3.687685251235962 56.16146850585938 C 1.889235734939575 55.11953353881836 -0.7774308919906616 5.04533863067627 0.214817151427269 4.064693450927734 Z" fill="#fdbc00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_okqjwz =
    '<svg viewBox="0.0 0.1 79.8 56.3" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(0.03, 0.1)" d="M 0.214817151427269 4.064693450927734 C 1.269080758094788 3.145338535308838 74.88148498535156 -0.5933712124824524 76.24582672119141 0.08082231879234314 C 77.61016845703125 0.7550158500671387 80.95899963378906 50.15501403808594 79.34660339355469 51.50340270996094 C 77.61016845703125 52.85179138183594 5.362103939056396 57.0808219909668 3.687685251235962 56.16146850585938 C 1.889235734939575 55.11953353881836 -0.7774308919906616 5.04533863067627 0.214817151427269 4.064693450927734 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_9ggqil =
    '<svg viewBox="0.5 0.0 48.2 99.5" ><path transform="translate(0.53, 0.0)" d="M 9.88040828704834 99.50920104980469 C 3.081658363342285 58.03680801391602 -0.2870916128158569 32.57668685913086 0.01915838569402695 22.88343620300293 C 0.325408399105072 13.3128833770752 5.164158344268799 5.582822322845459 14.53540802001953 0 C 20.10915756225586 3.25153374671936 24.0291576385498 5.521472454071045 26.11165809631348 6.625766754150391 C 28.74540901184082 8.159509658813477 31.44040870666504 8.71165657043457 32.11415863037109 10.06134986877441 C 32.60415649414063 10.98159503936768 37.99415969848633 38.46625900268555 48.22290802001953 92.20858764648438 C 42.46540832519531 94.29447937011719 36.27915954589844 95.88957214355469 29.72540855407715 97.11656188964844 C 23.17165756225586 98.46625518798828 16.5566577911377 99.20245361328125 9.88040828704834 99.50920104980469 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_qeamkn =
    '<svg viewBox="0.2 0.3 73.6 43.5" ><path transform="translate(0.19, 0.26)" d="M 0 5.498691082000732 C 1.368067264556885 14.42263507843018 3.357983112335205 20.18601417541504 6.094117641448975 22.85080337524414 C 10.13613414764404 26.87897300720215 37.55966567993164 32.0846061706543 47.75798416137695 36.4846076965332 C 57.95630264282227 40.88460540771484 57.27227020263672 43.48742294311523 64.61008453369141 43.48742294311523 C 69.39832305908203 43.48742294311523 72.50756072998047 41.19446563720703 73.62689208984375 36.4846076965332 C 70.82857513427734 36.11277389526367 68.15462493896484 35.24517059326172 65.54285430908203 33.81981658935547 C 61.68739318847656 31.71277618408203 61.18991470336914 29.10995864868164 58.82688903808594 28.18038177490234 C 56.52605056762695 27.25080299377441 50.05882263183594 29.10995864868164 47.75798416137695 28.18038177490234 C 45.4571418762207 27.25080299377441 18.90420150756836 12.19164848327637 17.16302490234375 10.51840972900391 C 15.98151302337646 9.340944290161133 15.73277282714844 6.490240573883057 16.23025131225586 1.904324889183044 C 13.36974811553955 0.1071417927742004 10.2605037689209 -0.3886328637599945 7.21344518661499 0.2930572926998138 C 3.855462074279785 0.8508037924766541 1.554621815681458 2.586014986038208 0 5.498691082000732 Z" fill="#fda3a3" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_jxh4kx =
    '<svg viewBox="0.3 0.3 37.4 14.7" ><path transform="translate(0.25, 0.3)" d="M 15.57065296173096 0 C 20.30507850646973 2.880000114440918 23.85589790344238 4.800000190734863 26.2854061126709 5.760000228881836 C 29.83622550964355 7.139999866485596 33.88540649414063 4.380000114440918 36.31491470336914 7.139999866485596 C 38.74442291259766 9.840000152587891 36.62638854980469 13.73999977111816 33.69852066040039 14.27999973297119 C 30.83294677734375 14.81999969482422 3.049341201782227 14.81999969482422 0.8067181706428528 14.27999973297119 C -0.7506588697433472 13.92000007629395 0.4952427446842194 10.26000022888184 0.1214722469449043 4.800000190734863 L 15.57065296173096 0 Z" fill="#fdbc00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_5zad4y =
    '<svg viewBox="38.2 132.1 53.8 117.9" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff2784e0"  /><stop offset="1.0" stop-color="#ff114dbd"  /></linearGradient></defs><path transform="translate(38.19, 132.06)" d="M 0 4.916666507720947 L 32.8344841003418 0 C 45.43448257446289 24.46041679382324 52.32413864135742 40.50104141235352 53.56551742553711 48.24479293823242 C 54.8068962097168 55.92708206176758 50.58620834350586 77.37604522705078 40.77931213378906 112.5302047729492 L 23.46206855773926 117.877082824707 C 24.51724052429199 113.3291702270508 25.94482803344727 106.5687484741211 27.37241363525391 98.45625305175781 C 31.40689659118652 76.02395629882813 33.82758712768555 71.41458129882813 32.77241516113281 61.15104293823242 C 32.21379470825195 53.77604293823242 7.510344982147217 26.67291641235352 0 4.916666507720947 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ruyvve =
    '<svg viewBox="38.2 132.1 53.8 117.9" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(38.19, 132.06)" d="M 0 4.916666507720947 L 32.8344841003418 0 C 45.43448257446289 24.46041679382324 52.32413864135742 40.50104141235352 53.56551742553711 48.24479293823242 C 54.8068962097168 55.92708206176758 50.58620834350586 77.37604522705078 40.77931213378906 112.5302047729492 L 23.46206855773926 117.877082824707 C 24.51724052429199 113.3291702270508 25.94482803344727 106.5687484741211 27.37241363525391 98.45625305175781 C 31.40689659118652 76.02395629882813 33.82758712768555 71.41458129882813 32.77241516113281 61.15104293823242 C 32.21379470825195 53.77604293823242 7.510344982147217 26.67291641235352 0 4.916666507720947 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_9aqj62 =
    '<svg viewBox="31.0 0.0 31.0 35.0" ><path transform="translate(31.0, 0.0)" d="M 10.02178382873535 34.81441116333008 C 10.02178382873535 34.81441116333008 6.585829257965088 35.74008941650391 5.62135124206543 33.45674514770508 C 4.71715259552002 31.17340278625488 3.632114410400391 26.97698593139648 1.703157782554626 23.89138603210449 C -0.2860788702964783 20.8057861328125 -1.069717526435852 15.68369102478027 2.366236686706543 13.64719486236572 C 0.6181195974349976 7.044010639190674 6.404989719390869 4.205258846282959 10.74514198303223 2.97101879119873 C 15.14557456970215 1.736778855323792 17.85816955566406 2.785882711410522 17.85816955566406 2.785882711410522 C 17.85816955566406 2.785882711410522 20.93244552612305 0.1939788311719894 23.52448081970215 0.008842837065458298 C 26.11651611328125 -0.1145811602473259 27.44267463684082 1.057946801185608 27.74407386779785 3.279578685760498 C 29.61275100708008 3.279578685760498 30.93890762329102 5.007514953613281 30.99918746948242 6.426890850067139 C 31.05946731567383 7.846266746520996 27.74407386779785 12.84493827819824 27.74407386779785 12.84493827819824 L 16.17033386230469 26.29815483093262 L 10.02178382873535 34.81441116333008 Z" fill="#0c3a8e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_9j8yg4 =
    '<svg viewBox="31.0 0.0 31.0 35.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(31.0, 0.0)" d="M 10.02178382873535 34.81441116333008 C 10.02178382873535 34.81441116333008 6.585829257965088 35.74008941650391 5.62135124206543 33.45674514770508 C 4.71715259552002 31.17340278625488 3.632114410400391 26.97698593139648 1.703157782554626 23.89138603210449 C -0.2860788702964783 20.8057861328125 -1.069717526435852 15.68369102478027 2.366236686706543 13.64719486236572 C 0.6181195974349976 7.044010639190674 6.404989719390869 4.205258846282959 10.74514198303223 2.97101879119873 C 15.14557456970215 1.736778855323792 17.85816955566406 2.785882711410522 17.85816955566406 2.785882711410522 C 17.85816955566406 2.785882711410522 20.93244552612305 0.1939788311719894 23.52448081970215 0.008842837065458298 C 26.11651611328125 -0.1145811602473259 27.44267463684082 1.057946801185608 27.74407386779785 3.279578685760498 C 29.61275100708008 3.279578685760498 30.93890762329102 5.007514953613281 30.99918746948242 6.426890850067139 C 31.05946731567383 7.846266746520996 27.74407386779785 12.84493827819824 27.74407386779785 12.84493827819824 L 16.17033386230469 26.29815483093262 L 10.02178382873535 34.81441116333008 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_kbtf5x =
    '<svg viewBox="38.0 8.0 27.0 31.0" ><path transform="translate(38.0, 8.0)" d="M 7.493813991546631 21.93540000915527 C 7.493813991546631 21.93540000915527 8.652707099914551 28.11609268188477 10.60452842712402 29.63096809387207 C 12.61734390258789 31.0246524810791 19.93667030334473 31.32762908935547 22.13246917724609 30.66108322143555 C 24.32826805114746 29.9339427947998 24.93821144104004 26.9041919708252 25.24318313598633 24.11681938171387 C 25.54815673828125 21.32944869995117 25.24318313598633 18.84505271911621 26.28008842468262 17.99672317504883 C 27.31699371337891 17.14839172363281 27.31699371337891 15.75470638275146 25.73113822937012 13.87626075744629 C 24.14528465270996 11.99781513214111 24.69423484802246 9.574013710021973 24.32826805114746 7.513782978057861 C 23.96230125427246 5.45355224609375 20.24164390563965 0 20.24164390563965 0 C 20.24164390563965 0 18.83877182006836 1.514875650405884 17.19192314147949 1.939040780067444 C 15.54507446289063 2.363205909729004 9.567623138427734 0.7877353429794312 9.567623138427734 0.7877353429794312 C 9.567623138427734 0.7877353429794312 11.33646106719971 6.059502601623535 7.98176908493042 8.483304023742676 C 10.17756748199463 12.11900520324707 8.896685600280762 14.9669713973999 8.896685600280762 14.9669713973999 L 6.700886726379395 15.69411182403564 C 6.700886726379395 15.69411182403564 3.590172529220581 12.48257541656494 2.187301397323608 12.6037654876709 C 0.784430205821991 12.72495555877686 -0.3744633793830872 14.78518676757813 0.1134918034076691 16.66363143920898 C 0.6014469861984253 18.54207801818848 2.736250877380371 21.45063972473145 4.74906587600708 21.75361442565918 C 6.761881351470947 22.05658912658691 7.188841819763184 21.39004325866699 7.188841819763184 21.39004325866699 L 7.493813991546631 21.93540000915527 Z" fill="#fda3a3" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_vez6m5 =
    '<svg viewBox="38.0 8.0 27.0 31.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(38.0, 8.0)" d="M 7.493813991546631 21.93540000915527 C 7.493813991546631 21.93540000915527 8.652707099914551 28.11609268188477 10.60452842712402 29.63096809387207 C 12.61734390258789 31.0246524810791 19.93667030334473 31.32762908935547 22.13246917724609 30.66108322143555 C 24.32826805114746 29.9339427947998 24.93821144104004 26.9041919708252 25.24318313598633 24.11681938171387 C 25.54815673828125 21.32944869995117 25.24318313598633 18.84505271911621 26.28008842468262 17.99672317504883 C 27.31699371337891 17.14839172363281 27.31699371337891 15.75470638275146 25.73113822937012 13.87626075744629 C 24.14528465270996 11.99781513214111 24.69423484802246 9.574013710021973 24.32826805114746 7.513782978057861 C 23.96230125427246 5.45355224609375 20.24164390563965 0 20.24164390563965 0 C 20.24164390563965 0 18.83877182006836 1.514875650405884 17.19192314147949 1.939040780067444 C 15.54507446289063 2.363205909729004 9.567623138427734 0.7877353429794312 9.567623138427734 0.7877353429794312 C 9.567623138427734 0.7877353429794312 11.33646106719971 6.059502601623535 7.98176908493042 8.483304023742676 C 10.17756748199463 12.11900520324707 8.896685600280762 14.9669713973999 8.896685600280762 14.9669713973999 L 6.700886726379395 15.69411182403564 C 6.700886726379395 15.69411182403564 3.590172529220581 12.48257541656494 2.187301397323608 12.6037654876709 C 0.784430205821991 12.72495555877686 -0.3744633793830872 14.78518676757813 0.1134918034076691 16.66363143920898 C 0.6014469861984253 18.54207801818848 2.736250877380371 21.45063972473145 4.74906587600708 21.75361442565918 C 6.761881351470947 22.05658912658691 7.188841819763184 21.39004325866699 7.188841819763184 21.39004325866699 L 7.493813991546631 21.93540000915527 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_6bidgc =
    '<svg viewBox="0.0 0.0 375.0 530.0" ><path  d="M 29.99970054626465 530.0001220703125 C 13.43160057067871 530.0001220703125 0 516.5685424804688 0 500.0004272460938 L 0 29.99970054626465 L 0 0 L 29.99970054626465 0 L 344.9996948242188 0 L 375.0003051757813 0 L 375.0003051757813 70.00019836425781 L 375.0003051757813 500.0004272460938 C 375.0003051757813 516.5685424804688 361.5686950683594 530.0001220703125 344.9996948242188 530.0001220703125 L 29.99970054626465 530.0001220703125 Z" fill="#4e73ff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_wvi8el =
    '<svg viewBox="0.0 0.0 16.0 15.0" ><path  d="M 14.46119976043701 15.00030040740967 L 1.538100123405457 15.00030040740967 C 0.6899901628494263 15.00030040740967 1.358032193365943e-07 14.29940986633301 1.358032193365943e-07 13.43790054321289 L 1.358032193365943e-07 1.562400221824646 C 1.358032193365943e-07 0.7008901834487915 0.6899901628494263 2.037048290048915e-07 1.538100123405457 2.037048290048915e-07 L 14.46119976043701 2.037048290048915e-07 C 15.30980968475342 2.037048290048915e-07 16.00020027160645 0.7008901834487915 16.00020027160645 1.562400221824646 L 16.00020027160645 13.43790054321289 C 16.00020027160645 14.29940986633301 15.30980968475342 15.00030040740967 14.46119976043701 15.00030040740967 Z M 1.692000150680542 1.093500256538391 C 1.353050112724304 1.093500256538391 1.077300190925598 1.374100208282471 1.077300190925598 1.719000220298767 L 1.077300190925598 6.875100135803223 C 1.077300190925598 7.219510078430176 1.353050112724304 7.49970006942749 1.692000150680542 7.49970006942749 L 5.031000137329102 7.49970006942749 C 5.294189929962158 7.49970006942749 5.527470111846924 7.666069984436035 5.611500263214111 7.913700103759766 C 5.778520107269287 8.405980110168457 6.191180229187012 8.749799728393555 6.615000247955322 8.749799728393555 L 9.384300231933594 8.749799728393555 C 9.804750442504883 8.749799728393555 10.21777057647705 8.405980110168457 10.38870048522949 7.913700103759766 C 10.47630977630615 7.666069984436035 10.7096004486084 7.49970006942749 10.96920013427734 7.49970006942749 L 14.30730056762695 7.49970006942749 C 14.6467399597168 7.49970006942749 14.92290019989014 7.219510078430176 14.92290019989014 6.875100135803223 L 14.92290019989014 1.719000220298767 C 14.92290019989014 1.374100208282471 14.6467399597168 1.093500256538391 14.30730056762695 1.093500256538391 L 1.692000150680542 1.093500256538391 Z" fill="#a8adc0" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_6d3q5k =
    '<svg viewBox="3.0 3.0 11.0 3.0" ><path transform="translate(3.0, 3.0)" d="M 10.46520042419434 2.99970006942749 L 0.5346003174781799 2.99970006942749 C 0.2398203462362289 2.99970006942749 3.410339388665307e-07 2.795000076293945 3.410339388665307e-07 2.543400049209595 C 3.410339388665307e-07 2.291800022125244 0.2398203462362289 2.087100028991699 0.5346003174781799 2.087100028991699 L 10.46520042419434 2.087100028991699 C 10.75998020172119 2.087100028991699 10.99980068206787 2.291800022125244 10.99980068206787 2.543400049209595 C 10.99980068206787 2.795000076293945 10.75998020172119 2.99970006942749 10.46520042419434 2.99970006942749 Z M 10.46520042419434 0.912600040435791 L 0.5346003174781799 0.912600040435791 C 0.2398203462362289 0.912600040435791 3.410339388665307e-07 0.7079000473022461 3.410339388665307e-07 0.4563000202178955 C 3.410339388665307e-07 0.2047000378370285 0.2398203462362289 3.471374654395731e-08 0.5346003174781799 3.471374654395731e-08 L 10.46520042419434 3.471374654395731e-08 C 10.75998020172119 3.471374654395731e-08 10.99980068206787 0.2047000378370285 10.99980068206787 0.4563000202178955 C 10.99980068206787 0.7079000473022461 10.75998020172119 0.912600040435791 10.46520042419434 0.912600040435791 Z" fill="#a8adc0" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_9a53p =
    '<svg viewBox="0.0 0.0 16.0 16.0" ><path  d="M 8.000100135803223 16.00020027160645 C 3.588830232620239 16.00020027160645 1.358032193365943e-07 12.41137027740479 1.358032193365943e-07 8.000100135803223 C 1.358032193365943e-07 3.588830232620239 3.588830232620239 1.358032193365943e-07 8.000100135803223 1.358032193365943e-07 C 12.41137027740479 1.358032193365943e-07 16.00020027160645 3.588830232620239 16.00020027160645 8.000100135803223 C 16.00020027160645 12.41137027740479 12.41137027740479 16.00020027160645 8.000100135803223 16.00020027160645 Z M 6.778800010681152 3.614400148391724 C 6.579730033874512 3.614400148391724 6.393380165100098 3.691110134124756 6.254100322723389 3.830400228500366 C 6.114220142364502 3.970280170440674 6.037270069122314 4.157110214233398 6.037430286407471 4.356480121612549 C 6.037580013275146 4.555390357971191 6.114530086517334 4.741559982299805 6.254100322723389 4.88070011138916 L 9.40410041809082 8.000100135803223 L 6.330600261688232 11.11499977111816 C 6.190550327301025 11.25504970550537 6.113420009613037 11.44155025482178 6.113420009613037 11.64015007019043 C 6.113420009613037 11.83874988555908 6.190550327301025 12.02525043487549 6.330600261688232 12.1653003692627 C 6.467299938201904 12.30200004577637 6.657900333404541 12.38039970397949 6.853500366210938 12.38039970397949 C 7.051700115203857 12.38039970397949 7.23900032043457 12.30273056030273 7.380899906158447 12.16170024871826 L 10.99620056152344 8.534700393676758 C 11.26469039916992 8.24254035949707 11.25442981719971 7.793030261993408 10.97280025482178 7.51140022277832 L 7.303500175476074 3.830400228500366 C 7.164220333099365 3.691110134124756 6.977869987487793 3.614400148391724 6.778800010681152 3.614400148391724 Z" fill="#f7b701" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_pue9eo =
    '<svg viewBox="78.0 224.0 30.0 38.0" ><path transform="translate(78.0, 224.0)" d="M 6.786102170648622e-13 3.746088266372681 C 6.786102170648622e-13 3.746088266372681 3.283015251159668 -0.3548892140388489 4.6260666847229 0.02483094297349453 C 5.894504547119141 0.404551088809967 8.879063606262207 1.61965548992157 11.93823719024658 6.859793663024902 C 14.99740982055664 12.17587566375732 18.65349578857422 15.06174850463867 21.41421318054199 19.84622192382813 C 24.10031509399414 24.63069534301758 29.7709789276123 30.93405151367188 29.99481964111328 35.33880615234375 C 30.21866226196289 39.81950378417969 23.13033485412598 37.3892936706543 19.84731864929199 36.93362808227539 C 16.56430435180664 36.47796630859375 0 13.61881160736084 0 13.61881160736084 L 0 3.746088266372681 L 6.786102170648622e-13 3.746088266372681 Z" fill="#e99d00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_989czl =
    '<svg viewBox="78.0 224.0 30.0 38.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(78.0, 224.0)" d="M 6.786102170648622e-13 3.746088266372681 C 6.786102170648622e-13 3.746088266372681 3.283015251159668 -0.3548892140388489 4.6260666847229 0.02483094297349453 C 5.894504547119141 0.404551088809967 8.879063606262207 1.61965548992157 11.93823719024658 6.859793663024902 C 14.99740982055664 12.17587566375732 18.65349578857422 15.06174850463867 21.41421318054199 19.84622192382813 C 24.10031509399414 24.63069534301758 29.7709789276123 30.93405151367188 29.99481964111328 35.33880615234375 C 30.21866226196289 39.81950378417969 23.13033485412598 37.3892936706543 19.84731864929199 36.93362808227539 C 16.56430435180664 36.47796630859375 0 13.61881160736084 0 13.61881160736084 L 0 3.746088266372681 L 6.786102170648622e-13 3.746088266372681 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_9xalu1 =
    '<svg viewBox="43.0 226.0 42.0 32.0" ><path transform="translate(43.0, 226.0)" d="M 28.6406307220459 2.696873426437378 C 31.1019344329834 1.515890955924988 35.80078887939453 -0.7722625732421875 36.91956329345703 0.2610970735549927 C 38.03833770751953 1.294456720352173 42.21509552001953 12.88284683227539 41.99134063720703 14.28526306152344 C 41.76758575439453 15.6876802444458 0 32 0 32 L 28.6406307220459 2.696873426437378 Z" fill="#0c3a8e" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8vcrvl =
    '<svg viewBox="0.0 0.0 38.0 102.0" ><path  d="M 38 90.694091796875 C 35.30355453491211 85.45294952392578 30.5098762512207 74.67115783691406 30.43497657775879 68.75614929199219 C 30.2851734161377 62.84113693237305 26.91461753845215 54.904541015625 22.49544525146484 43.37401580810547 C 18.07627296447754 31.91836166381836 18.07627296447754 27.50082206726074 16.57824897766113 23.98176574707031 C 15.00532245635986 20.46270942687988 10.06184101104736 18.66574478149414 10.28654479980469 14.39795207977295 C 10.66105175018311 10.2799072265625 10.58615016937256 4.065402507781982 10.21164417266846 1.070460915565491 C 9.837138175964355 -1.92448091506958 3.545434474945068 1.894069910049438 1.897607445716858 6.012115001678467 C 0.3246816396713257 10.13016033172607 -0.4992319047451019 15.52105522155762 0.3246816396713257 19.93859481811523 C 1.148595094680786 24.35613441467285 6.841088771820068 25.4792366027832 8.638717651367188 28.54905128479004 C 10.43634796142578 31.61886787414551 14.93042182922363 59.92106628417969 16.95275497436523 69.43000793457031 C 18.97508811950684 78.78919982910156 27.28912353515625 102 27.28912353515625 102 L 38 90.694091796875 Z" fill="#fda3a3" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_utix5v =
    '<svg viewBox="0.0 0.0 38.0 102.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path  d="M 38 90.694091796875 C 35.30355453491211 85.45294952392578 30.5098762512207 74.67115783691406 30.43497657775879 68.75614929199219 C 30.2851734161377 62.84113693237305 26.91461753845215 54.904541015625 22.49544525146484 43.37401580810547 C 18.07627296447754 31.91836166381836 18.07627296447754 27.50082206726074 16.57824897766113 23.98176574707031 C 15.00532245635986 20.46270942687988 10.06184101104736 18.66574478149414 10.28654479980469 14.39795207977295 C 10.66105175018311 10.2799072265625 10.58615016937256 4.065402507781982 10.21164417266846 1.070460915565491 C 9.837138175964355 -1.92448091506958 3.545434474945068 1.894069910049438 1.897607445716858 6.012115001678467 C 0.3246816396713257 10.13016033172607 -0.4992319047451019 15.52105522155762 0.3246816396713257 19.93859481811523 C 1.148595094680786 24.35613441467285 6.841088771820068 25.4792366027832 8.638717651367188 28.54905128479004 C 10.43634796142578 31.61886787414551 14.93042182922363 59.92106628417969 16.95275497436523 69.43000793457031 C 18.97508811950684 78.78919982910156 27.28912353515625 102 27.28912353515625 102 L 38 90.694091796875 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_orccce =
    '<svg viewBox="36.0 183.0 36.0 19.0" ><path transform="translate(36.0, 183.0)" d="M 0 3.976744174957275 L 2.330449342727661 19 C 2.330449342727661 19 18.71642112731934 15.39147281646729 23.66862678527832 16.05426406860352 C 28.6208324432373 16.71705436706543 35.68500518798828 18.26356506347656 35.97631454467773 15.61240291595459 C 36.41327285766602 13.03488349914551 30.65997505187988 0 30.65997505187988 0 L 0 3.976744174957275 Z" fill="#fda3a3" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_2tn1dk =
    '<svg viewBox="12.0 61.0 85.0 85.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff1c6cc1"  /><stop offset="1.0" stop-color="#ff0c3a8e"  /></linearGradient></defs><path transform="translate(12.0, 61.0)" d="M 37.83081436157227 51.42264175415039 C 37.83081436157227 51.42264175415039 31.5655632019043 53.87625503540039 27.95383071899414 53.43014526367188 C 24.34209632873535 52.98403167724609 23.31017303466797 50.23300933837891 20.50923728942871 50.75347137451172 C 17.70830154418945 51.1995849609375 10.26370811462402 53.43014526367188 9.452910423278809 52.31486511230469 C 8.64211368560791 51.2739372253418 12.0327205657959 48.89467239379883 11.44304943084717 47.40763092041016 C 10.85337829589844 45.99494171142578 6.799392223358154 47.55633544921875 2.67169713973999 45.84623718261719 C -1.455997824668884 44.13614273071289 -0.2766564190387726 43.1695671081543 2.67169713973999 41.45946884155273 C 5.62005090713501 39.82372665405273 2.524279594421387 37.66751480102539 2.524279594421387 35.66001129150391 C 2.524279594421387 33.65250778198242 12.10642910003662 33.65250778198242 13.94915008544922 30.15796279907227 C 15.79187107086182 26.51471328735352 14.90736484527588 19.82303047180176 18.29797172546387 15.95672607421875 C 21.76228713989258 12.09042072296143 18.07684516906738 7.108835697174072 24.12096977233887 5.101331233978271 C 30.16509437561035 3.093826770782471 33.11344909667969 4.060402870178223 37.90452194213867 2.12725043296814 C 42.69559860229492 0.1197458505630493 51.39324188232422 -0.846830427646637 53.30967330932617 0.9376180768013 C 55.29980850219727 2.722066640853882 57.3636589050293 5.17568302154541 61.49135208129883 7.778004169464111 C 65.69275665283203 10.3803243637085 73.13735198974609 17.51811790466309 74.98007202148438 24.95332145690918 C 76.82279205322266 32.23981857299805 81.83499145507813 39.67502212524414 83.38288116455078 50.15865707397461 C 84.78334808349609 60.64229202270508 86.18381500244141 58.70913696289063 83.38288116455078 66.29304504394531 C 80.58193969726563 73.95130157470703 80.43452453613281 74.17435455322266 79.77114868164063 78.04066467285156 C 79.10776519775391 81.90696716308594 80.95048522949219 88.37559509277344 74.39040374755859 82.87354278564453 C 67.83031463623047 77.44584655761719 62.00731658935547 69.71323394775391 55.59464645385742 66.51609802246094 C 49.25568389892578 63.31896209716797 37.83081436157227 51.42264175415039 37.83081436157227 51.42264175415039 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_in1hnd =
    '<svg viewBox="12.0 61.0 85.0 85.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(12.0, 61.0)" d="M 37.83081436157227 51.42264175415039 C 37.83081436157227 51.42264175415039 31.5655632019043 53.87625503540039 27.95383071899414 53.43014526367188 C 24.34209632873535 52.98403167724609 23.31017303466797 50.23300933837891 20.50923728942871 50.75347137451172 C 17.70830154418945 51.1995849609375 10.26370811462402 53.43014526367188 9.452910423278809 52.31486511230469 C 8.64211368560791 51.2739372253418 12.0327205657959 48.89467239379883 11.44304943084717 47.40763092041016 C 10.85337829589844 45.99494171142578 6.799392223358154 47.55633544921875 2.67169713973999 45.84623718261719 C -1.455997824668884 44.13614273071289 -0.2766564190387726 43.1695671081543 2.67169713973999 41.45946884155273 C 5.62005090713501 39.82372665405273 2.524279594421387 37.66751480102539 2.524279594421387 35.66001129150391 C 2.524279594421387 33.65250778198242 12.10642910003662 33.65250778198242 13.94915008544922 30.15796279907227 C 15.79187107086182 26.51471328735352 14.90736484527588 19.82303047180176 18.29797172546387 15.95672607421875 C 21.76228713989258 12.09042072296143 18.07684516906738 7.108835697174072 24.12096977233887 5.101331233978271 C 30.16509437561035 3.093826770782471 33.11344909667969 4.060402870178223 37.90452194213867 2.12725043296814 C 42.69559860229492 0.1197458505630493 51.39324188232422 -0.846830427646637 53.30967330932617 0.9376180768013 C 55.29980850219727 2.722066640853882 57.3636589050293 5.17568302154541 61.49135208129883 7.778004169464111 C 65.69275665283203 10.3803243637085 73.13735198974609 17.51811790466309 74.98007202148438 24.95332145690918 C 76.82279205322266 32.23981857299805 81.83499145507813 39.67502212524414 83.38288116455078 50.15865707397461 C 84.78334808349609 60.64229202270508 86.18381500244141 58.70913696289063 83.38288116455078 66.29304504394531 C 80.58193969726563 73.95130157470703 80.43452453613281 74.17435455322266 79.77114868164063 78.04066467285156 C 79.10776519775391 81.90696716308594 80.95048522949219 88.37559509277344 74.39040374755859 82.87354278564453 C 67.83031463623047 77.44584655761719 62.00731658935547 69.71323394775391 55.59464645385742 66.51609802246094 C 49.25568389892578 63.31896209716797 37.83081436157227 51.42264175415039 37.83081436157227 51.42264175415039 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_s4adwp =
    '<svg viewBox="25.0 105.0 59.0 87.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff11dcb7"  /><stop offset="1.0" stop-color="#ff07b781"  /></linearGradient></defs><path transform="translate(25.0, 105.0)" d="M 6.583324909210205 7.724209308624268 C 6.583324909210205 7.724209308624268 8.421098709106445 12.78657341003418 8.935675621032715 15.46664905548096 C 9.376741409301758 18.14672470092773 6.142259120941162 20.9012451171875 4.745551109313965 23.35798072814941 C 3.348842859268188 25.96360969543457 -1.870434880256653 29.68593597412109 0.7024484872817993 38.1728401184082 C 3.348842859268188 46.5108528137207 5.333638668060303 45.09636688232422 5.554171562194824 50.97764587402344 C 5.774704456329346 56.85892105102539 5.186616897583008 79.49066925048828 7.318434715270996 84.32968902587891 C 9.303230285644531 89.16871643066406 9.744296073913574 85.96751403808594 11.36153697967529 85.89306640625 C 12.97877788543701 85.81861877441406 31.50353813171387 85.22305297851563 36.79632568359375 84.70192718505859 C 42.16262817382813 84.25524139404297 44.14742279052734 85.14860534667969 44.9560432434082 84.47858428955078 C 45.76466369628906 83.65967559814453 39.51623153686523 70.25930023193359 40.10432052612305 64.37802124023438 C 40.69240951538086 58.49674606323242 54.07140350341797 26.4847354888916 56.35024261474609 22.53907012939453 C 58.70259094238281 18.66785049438477 59.80525588989258 11.66987609863281 58.33503723144531 7.724209308624268 C 56.79130554199219 3.704096794128418 49.88127899169922 -0.5393556952476501 48.11701583862305 0.05621659010648727 C 46.35275268554688 0.6517888307571411 45.54413223266602 1.247361063957214 43.55933380126953 3.108524322509766 C 41.72156143188477 4.969687938690186 37.60494995117188 7.203083515167236 36.72281646728516 7.798655986785889 C 35.47312927246094 8.617568016052246 35.69366455078125 6.830851078033447 34.66450881958008 7.426423072814941 C 33.63535690307617 8.021995544433594 27.09288215637207 12.93546676635742 24.81404113769531 11.07430362701416 C 22.46169090270996 9.213140487670898 20.9914722442627 5.193027496337891 15.84570503234863 5.044134140014648 C 10.69993877410889 4.895241260528564 6.583324909210205 7.724209308624268 6.583324909210205 7.724209308624268 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_pdzn90 =
    '<svg viewBox="25.0 105.0 59.0 87.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(25.0, 105.0)" d="M 6.583324909210205 7.724209308624268 C 6.583324909210205 7.724209308624268 8.421098709106445 12.78657341003418 8.935675621032715 15.46664905548096 C 9.376741409301758 18.14672470092773 6.142259120941162 20.9012451171875 4.745551109313965 23.35798072814941 C 3.348842859268188 25.96360969543457 -1.870434880256653 29.68593597412109 0.7024484872817993 38.1728401184082 C 3.348842859268188 46.5108528137207 5.333638668060303 45.09636688232422 5.554171562194824 50.97764587402344 C 5.774704456329346 56.85892105102539 5.186616897583008 79.49066925048828 7.318434715270996 84.32968902587891 C 9.303230285644531 89.16871643066406 9.744296073913574 85.96751403808594 11.36153697967529 85.89306640625 C 12.97877788543701 85.81861877441406 31.50353813171387 85.22305297851563 36.79632568359375 84.70192718505859 C 42.16262817382813 84.25524139404297 44.14742279052734 85.14860534667969 44.9560432434082 84.47858428955078 C 45.76466369628906 83.65967559814453 39.51623153686523 70.25930023193359 40.10432052612305 64.37802124023438 C 40.69240951538086 58.49674606323242 54.07140350341797 26.4847354888916 56.35024261474609 22.53907012939453 C 58.70259094238281 18.66785049438477 59.80525588989258 11.66987609863281 58.33503723144531 7.724209308624268 C 56.79130554199219 3.704096794128418 49.88127899169922 -0.5393556952476501 48.11701583862305 0.05621659010648727 C 46.35275268554688 0.6517888307571411 45.54413223266602 1.247361063957214 43.55933380126953 3.108524322509766 C 41.72156143188477 4.969687938690186 37.60494995117188 7.203083515167236 36.72281646728516 7.798655986785889 C 35.47312927246094 8.617568016052246 35.69366455078125 6.830851078033447 34.66450881958008 7.426423072814941 C 33.63535690307617 8.021995544433594 27.09288215637207 12.93546676635742 24.81404113769531 11.07430362701416 C 22.46169090270996 9.213140487670898 20.9914722442627 5.193027496337891 15.84570503234863 5.044134140014648 C 10.69993877410889 4.895241260528564 6.583324909210205 7.724209308624268 6.583324909210205 7.724209308624268 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_usqjnp =
    '<svg viewBox="45.0 77.0 26.0 35.0" ><path transform="translate(45.0, 77.0)" d="M 10.81040000915527 0 C 8.070777893066406 1.26166307926178 5.849462985992432 3.859204769134521 3.998367309570313 7.34733247756958 C 0.9625698924064636 12.76506233215332 0 19.07337760925293 0 23.30365943908691 C 0 27.53394317626953 1.628964424133301 31.02206993103027 4.590717792510986 32.58059310913086 C 7.55247163772583 34.13911819458008 10.58826923370361 35.40078353881836 13.40193462371826 34.88127517700195 C 16.80795097351074 34.21333694458008 22.87954521179199 30.50256156921387 25.98938751220703 22.85836791992188 C 26.28556251525879 12.31976985931396 20.3620548248291 1.929602384567261 10.81040000915527 0 Z" fill="#fda3a3" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_2v1xkz =
    '<svg viewBox="45.0 77.0 26.0 35.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(45.0, 77.0)" d="M 10.81040000915527 0 C 8.070777893066406 1.26166307926178 5.849462985992432 3.859204769134521 3.998367309570313 7.34733247756958 C 0.9625698924064636 12.76506233215332 0 19.07337760925293 0 23.30365943908691 C 0 27.53394317626953 1.628964424133301 31.02206993103027 4.590717792510986 32.58059310913086 C 7.55247163772583 34.13911819458008 10.58826923370361 35.40078353881836 13.40193462371826 34.88127517700195 C 16.80795097351074 34.21333694458008 22.87954521179199 30.50256156921387 25.98938751220703 22.85836791992188 C 26.28556251525879 12.31976985931396 20.3620548248291 1.929602384567261 10.81040000915527 0 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_p1iz59 =
    '<svg viewBox="40.0 104.0 23.0 19.0" ><path transform="translate(40.0, 104.0)" d="M 7.924269676208496 1.108219146728516 C 7.924269676208496 1.108219146728516 7.469724655151367 9.504238128662109 5.651546478271484 11.93466472625732 C 3.757610321044922 14.36509132385254 -0.4848062992095947 15.17523288726807 0.04549578204751015 17.09011459350586 C 0.5000404119491577 18.93134689331055 6.636393070220947 20.25703430175781 11.40911197662354 17.09011459350586 C 16.18183135986328 13.92319583892822 23 8.62044620513916 23 8.62044620513916 C 23 8.62044620513916 20.87879180908203 7.442058086395264 20.95454978942871 4.64338493347168 C 21.2575798034668 1.697413444519043 9.590932846069336 -1.837752461433411 7.924269676208496 1.108219146728516 Z" fill="#e49292" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8jomso =
    '<svg viewBox="71.0 26.0 92.0 92.0" ><path transform="translate(71.0, 26.0)" d="M 37 57 C 50.86898422241211 44.94533920288086 56.22097015380859 28.17684936523438 69.13092803955078 17.0836009979248 C 72.81948852539063 13.38585186004639 80.19660949707031 15.23472690582275 82.99991607666016 12.42443752288818 C 87.20487213134766 9.614148139953613 90.37703704833984 5.176848888397217 92 0 C 90.672119140625 0.0739549845457077 87.7950439453125 1.700964689254761 85.5819091796875 4.215434074401855 C 82.63105773925781 7.46945333480835 74.14736938476563 10.64951801300049 70.53258514404297 12.49839210510254 C 66.91779327392578 14.34726715087891 59.90953063964844 19.74598121643066 50.61435699462891 29.95176887512207 C 41.39295959472656 40.15755462646484 29.14694023132324 53.61736297607422 26.19609069824219 58.12861633300781 C 23.24524307250977 62.56591796875 0.8925705552101135 79.79742431640625 0.3024009466171265 81.20257568359375 C -0.2877686321735382 82.60771942138672 0.08108735084533691 88.59806823730469 0.5974857211112976 92 C 7 91 11.70487213134766 87.78939056396484 16.5 83.5 C 24.76237487792969 76.99195861816406 29.62288093566895 65.35691070556641 37 57 Z" fill="#fda3a3" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_8rspuu =
    '<svg viewBox="71.0 26.0 92.0 92.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(71.0, 26.0)" d="M 37 57 C 50.86898422241211 44.94533920288086 56.22097015380859 28.17684936523438 69.13092803955078 17.0836009979248 C 72.81948852539063 13.38585186004639 80.19660949707031 15.23472690582275 82.99991607666016 12.42443752288818 C 87.20487213134766 9.614148139953613 90.37703704833984 5.176848888397217 92 0 C 90.672119140625 0.0739549845457077 87.7950439453125 1.700964689254761 85.5819091796875 4.215434074401855 C 82.63105773925781 7.46945333480835 74.14736938476563 10.64951801300049 70.53258514404297 12.49839210510254 C 66.91779327392578 14.34726715087891 59.90953063964844 19.74598121643066 50.61435699462891 29.95176887512207 C 41.39295959472656 40.15755462646484 29.14694023132324 53.61736297607422 26.19609069824219 58.12861633300781 C 23.24524307250977 62.56591796875 0.8925705552101135 79.79742431640625 0.3024009466171265 81.20257568359375 C -0.2877686321735382 82.60771942138672 0.08108735084533691 88.59806823730469 0.5974857211112976 92 C 7 91 11.70487213134766 87.78939056396484 16.5 83.5 C 24.76237487792969 76.99195861816406 29.62288093566895 65.35691070556641 37 57 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_unz8mu =
    '<svg viewBox="4.0 197.0 82.0 86.0" ><defs><linearGradient id="gradient" x1="0.5" y1="0.0" x2="0.5" y2="1.0"><stop offset="0.0" stop-color="#ff2784e0"  /><stop offset="1.0" stop-color="#ff114dbd"  /></linearGradient></defs><path transform="translate(4.0, 197.0)" d="M 38.38951110839844 1.886657238006592 C 38.38951110839844 1.886657238006592 65.85328674316406 -0.5011433362960815 67.62039184570313 0.09580680727958679 C 69.38749694824219 0.6927569508552551 72.40630340576172 1.961275935173035 73.65800476074219 10.24395847320557 C 75.05696105957031 18.52664184570313 77.04496002197266 28.30170059204102 65.48513793945313 38.00214004516602 C 53.92531967163086 47.70257949829102 48.10859680175781 55.08983612060547 48.10859680175781 55.08983612060547 C 48.10859680175781 55.08983612060547 70.49193572998047 46.210205078125 73.5107421875 44.34473419189453 C 76.52954864501953 42.47926712036133 78.51754760742188 42.77774047851563 80.35828399658203 47.18024826049805 C 82.19902038574219 51.58275604248047 82.19902038574219 62.99942779541016 81.75724029541016 65.23799133300781 C 81.31546020507813 67.47655487060547 71.30186462402344 68.29735565185547 60.99374389648438 72.69986724853516 C 50.61199569702148 77.10237121582031 21.74926376342773 88.96675872802734 8.937745094299316 85.31044006347656 C -3.873773336410522 81.80335235595703 -2.474814414978027 69.04354858398438 10.33670425415039 48.97109985351563 C 23.14822387695313 29.04788780212402 31.39471817016602 24.42152404785156 32.13101196289063 19.49668502807617 C 32.86730575561523 14.5718469619751 31.91012382507324 5.542976856231689 32.49916076660156 4.274457454681396 C 33.23545455932617 2.782082319259644 37.06418228149414 1.961275935173035 38.38951110839844 1.886657238006592 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_agk6ni =
    '<svg viewBox="4.0 197.0 82.0 86.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(4.0, 197.0)" d="M 38.38951110839844 1.886657238006592 C 38.38951110839844 1.886657238006592 65.85328674316406 -0.5011433362960815 67.62039184570313 0.09580680727958679 C 69.38749694824219 0.6927569508552551 72.40630340576172 1.961275935173035 73.65800476074219 10.24395847320557 C 75.05696105957031 18.52664184570313 77.04496002197266 28.30170059204102 65.48513793945313 38.00214004516602 C 53.92531967163086 47.70257949829102 48.10859680175781 55.08983612060547 48.10859680175781 55.08983612060547 C 48.10859680175781 55.08983612060547 70.49193572998047 46.210205078125 73.5107421875 44.34473419189453 C 76.52954864501953 42.47926712036133 78.51754760742188 42.77774047851563 80.35828399658203 47.18024826049805 C 82.19902038574219 51.58275604248047 82.19902038574219 62.99942779541016 81.75724029541016 65.23799133300781 C 81.31546020507813 67.47655487060547 71.30186462402344 68.29735565185547 60.99374389648438 72.69986724853516 C 50.61199569702148 77.10237121582031 21.74926376342773 88.96675872802734 8.937745094299316 85.31044006347656 C -3.873773336410522 81.80335235595703 -2.474814414978027 69.04354858398438 10.33670425415039 48.97109985351563 C 23.14822387695313 29.04788780212402 31.39471817016602 24.42152404785156 32.13101196289063 19.49668502807617 C 32.86730575561523 14.5718469619751 31.91012382507324 5.542976856231689 32.49916076660156 4.274457454681396 C 33.23545455932617 2.782082319259644 37.06418228149414 1.961275935173035 38.38951110839844 1.886657238006592 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ovzsmd =
    '<svg viewBox="72.0 25.0 92.0 98.0" ><path transform="translate(72.0, 25.0)" d="M 91.40203857421875 0 C 89.71543121337891 5.29713249206543 86.63553619384766 9.698974609375 82.45568084716797 12.53405952453613 C 79.66910552978516 15.36914443969727 72.33602142333984 13.50395679473877 68.66947937011719 17.23433113098145 C 55.83658218383789 28.42545700073242 49.38346862792969 44.31685256958008 35.67060089111328 56.40326690673828 C 28.33751487731934 64.83391571044922 24.67097282409668 76.02503967285156 16.38458824157715 82.51589202880859 C 11.69141387939453 86.91773223876953 5.866467475891113 90.44244384765625 0 92.75527191162109 C 0 92.82987976074219 0 93.15633392333984 0 93.23094177246094 C 0.439985066652298 95.84220123291016 3.111705303192139 98.78032684326172 6.998239994049072 97.8104248046875 C 10.95810508728027 96.76592254638672 30.17078590393066 73.11534881591797 35.30394744873047 65.95302581787109 C 40.43710327148438 58.6414909362793 39.11714935302734 56.47787475585938 47.69685745239258 49.76319885253906 C 56.27656555175781 43.04852676391602 65.29625701904297 25.4411563873291 67.27619171142578 22.15842628479004 C 69.25612640380859 18.87569618225098 77.6158447265625 19.92020225524902 83.18898773193359 17.45815467834473 C 88.76213073730469 14.84689235687256 92.13535308837891 1.492149949073792 91.98868560791016 0.3730374872684479 C 92.06201934814453 0.07460749894380569 91.76869201660156 0 91.40203857421875 0 Z" fill="#e49292" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_r4zuuk =
    '<svg viewBox="80.0 239.0 26.0 41.0" ><path transform="translate(80.0, 239.0)" d="M 0 3.390825986862183 C 0 3.390825986862183 5.594797611236572 0 8.845829010009766 0 C 12.17246532440186 0 13.60896778106689 3.022258043289185 14.59183692932129 5.749661445617676 C 15.57470703125 8.477065086364746 22.37919044494629 20.19752883911133 24.49614143371582 28.01117134094238 C 26.61309242248535 35.82481384277344 26.38627624511719 39.87906265258789 24.49614143371582 40.68991088867188 C 22.60600662231445 41.50076293945313 19.35497665405273 40.68991088867188 17.46484184265137 38.62593078613281 C 15.57470703125 36.56195068359375 10.4335412979126 27.05289459228516 8.467802047729492 25.94719123840332 C 6.577667713165283 24.91519927978516 1.738923668861389 21.96665573120117 1.738923668861389 21.96665573120117 L 0 3.390825986862183 Z" fill="#fdbc00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_oacz7v =
    '<svg viewBox="80.0 239.0 26.0 41.0" ><defs><pattern id="image" patternUnits="userSpaceOnUse" width="184.0" height="184.0"><image xlink:href="null" x="0" y="0" width="184.0" height="184.0" /></pattern></defs><path transform="translate(80.0, 239.0)" d="M 0 3.390825986862183 C 0 3.390825986862183 5.594797611236572 0 8.845829010009766 0 C 12.17246532440186 0 13.60896778106689 3.022258043289185 14.59183692932129 5.749661445617676 C 15.57470703125 8.477065086364746 22.37919044494629 20.19752883911133 24.49614143371582 28.01117134094238 C 26.61309242248535 35.82481384277344 26.38627624511719 39.87906265258789 24.49614143371582 40.68991088867188 C 22.60600662231445 41.50076293945313 19.35497665405273 40.68991088867188 17.46484184265137 38.62593078613281 C 15.57470703125 36.56195068359375 10.4335412979126 27.05289459228516 8.467802047729492 25.94719123840332 C 6.577667713165283 24.91519927978516 1.738923668861389 21.96665573120117 1.738923668861389 21.96665573120117 L 0 3.390825986862183 Z" fill="url(#image)" fill-opacity="0.1" stroke="none" stroke-width="1" stroke-opacity="0.1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_z7vau7 =
    '<svg viewBox="0.0 0.0 20.0 20.0" ><path  d="M 7.603785514831543 20.00061988830566 L 7.602935791015625 20.00041007995605 C 6.551525592803955 19.74736022949219 5.551455497741699 19.33201026916504 4.630495548248291 18.76589965820313 C 5.05754566192627 17.80018997192383 4.843955516815186 16.6519889831543 4.09859561920166 15.90750026702881 C 3.610805749893188 15.42405033111572 2.965475559234619 15.15779972076416 2.281495571136475 15.15779972076416 C 1.922285676002502 15.15779972076416 1.571645617485046 15.23137950897217 1.239295601844788 15.37650012969971 C 0.6699556708335876 14.45028972625732 0.2552356421947479 13.44995975494385 0.005395642016083002 12.40289974212646 C 1.005055665969849 12.01424980163574 1.650595664978027 11.07252979278564 1.650595664978027 10.00259971618652 C 1.650595664978027 8.92926025390625 1.002695679664612 7.98708963394165 -4.357910256658215e-06 7.602299690246582 C 0.2501256465911865 6.557739734649658 0.66396564245224 5.556149959564209 1.229395627975464 4.624199867248535 C 1.55724561214447 4.772170066833496 1.908985614776611 4.847399711608887 2.276095628738403 4.847399711608887 C 2.96500563621521 4.847399711608887 3.610645532608032 4.581150054931641 4.094095706939697 4.097699642181396 C 4.843375682830811 3.348419904708862 5.056765556335449 2.197549819946289 4.625095844268799 1.233899831771851 C 5.551325798034668 0.6645598411560059 6.551655769348145 0.2498398572206497 7.598695755004883 -1.358032193365943e-07 C 7.978015422821045 0.9875198602676392 8.94251537322998 1.650599837303162 9.999896049499512 1.650599837303162 C 11.05690574645996 1.650599837303162 12.02186584472656 0.9872798919677734 12.40109539031982 -1.358032193365943e-07 C 13.45624542236328 0.2530498504638672 14.45479583740234 0.6683998703956604 15.37019538879395 1.233899831771851 C 14.93729591369629 2.218459844589233 15.14557552337646 3.342069864273071 15.90119552612305 4.097699642181396 C 16.38898658752441 4.581150054931641 17.03431510925293 4.847399711608887 17.71829605102539 4.847399711608887 C 18.07426643371582 4.847399711608887 18.42672538757324 4.77230978012085 18.76589584350586 4.624199867248535 C 19.33508491516113 5.549249649047852 19.74981498718262 6.549279689788818 19.99980545043945 7.59689998626709 C 18.99685478210449 7.985579967498779 18.34919548034668 8.927299499511719 18.34919548034668 9.997200012207031 C 18.34919548034668 11.0678596496582 18.99497604370117 12.01214981079102 19.9943962097168 12.40289974212646 C 19.74196624755859 13.45547008514404 19.32661628723145 14.45553970336914 18.76049613952637 15.37650012969971 C 18.43845558166504 15.23355960845947 18.07849502563477 15.15779972076416 17.71829605102539 15.15779972076416 C 17.02910614013672 15.15779972076416 16.38378524780273 15.42405033111572 15.90119552612305 15.90750026702881 C 15.14645576477051 16.66663932800293 14.93802547454834 17.78862953186035 15.37019538879395 18.76589965820313 C 14.44461536407471 19.3348503112793 13.44426536560059 19.7495002746582 12.39654541015625 19.99959945678711 C 12.01715564727783 19.01543045043945 11.05448532104492 18.35459899902344 9.999896049499512 18.35459899902344 C 8.944875717163086 18.35459899902344 7.982085704803467 19.01574897766113 7.604095458984375 19.99979972839355 L 7.603785514831543 20.00061988830566 Z M 10.04669570922852 5.826600074768066 C 7.749495506286621 5.826600074768066 5.880595684051514 7.695099830627441 5.880595684051514 9.991800308227539 C 5.880595684051514 12.28899955749512 7.749495506286621 14.15789985656738 10.04669570922852 14.15789985656738 C 12.34438610076904 14.15789985656738 14.21369552612305 12.28899955749512 14.21369552612305 9.991800308227539 C 14.21369552612305 7.695099830627441 12.34438610076904 5.826600074768066 10.04669570922852 5.826600074768066 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
