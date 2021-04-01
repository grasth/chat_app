// import 'package:flutter/material.dart';

// class ChatRoomsTile extends StatelessWidget {
//   final String userName;
//   final String chatRoomId;

//   ChatRoomsTile({this.userName,@required this.chatRoomId});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(
//           builder: (context) => Chat(
//             chatRoomId: chatRoomId,
//           )
//         ));
//       },
//       child: Container(
//         color: Colors.black26,
//         padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//         child: Row(
//           children: [
//             Container(
//               height: 30,
//               width: 30,
//               decoration: BoxDecoration(
//                   color: Colors.amber,
//                   borderRadius: BorderRadius.circular(30)),
//               child: Text(userName.substring(0, 1),
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontFamily: 'OverpassRegular',
//                       fontWeight: FontWeight.w300)),
//             ),
//             SizedBox(
//               width: 12,
//             ),
//             Text(userName,
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontFamily: 'OverpassRegular',
//                     fontWeight: FontWeight.w300))
//           ],
//         ),
//       ),
//     );
//   }
