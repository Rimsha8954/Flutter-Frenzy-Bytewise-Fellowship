import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('List_tile Widget'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                  itemBuilder: (context,index){
                    return const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            'https://tse3.mm.bing.net/th?id=OIP.xLxr0q5UsemPgxRlOTlMdAHaLG&pid=Api&P=0'),
                      ),
                      title: Text('Company'),
                      subtitle: Text('Hi, Saba how are you'),
                      trailing: Text('1:05 PM'),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   home: Scaffold(
//   appBar: AppBar(
//     title: Text('Rich_Text_Widget & Text_Form_Feild '),
//   ),
//   body: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Center(
//         child: RichText(
//             text: TextSpan(
//               text: 'Hi I am',
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
//               children: const [
//                 TextSpan(
//                   text: ' Rimsha Ashraf',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold ),
//                 ),
//               ],
//             )
//         ),
//       ),
//       const SizedBox(
//         height: 40,
//       ),
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TextFormField(
//           style: TextStyle(fontSize: 18, color: Colors.black),
//           enabled: true,
//           keyboardType: TextInputType.emailAddress,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white70,
//             prefixIcon: Icon(Icons.email),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.black, width: 2),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.red, width: 2),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.blue, width: 2),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             hintText: 'Email',
//             labelText   : 'Email',
//             hintStyle: TextStyle(fontSize: 14, color: Colors.black),
//           ),
//           onChanged: (value){
//             print(value);
//           },
//         ),
//       ),
//     ],
//   ),
// ),

//***********************************************

//   home: Scaffold(
//   appBar: AppBar(
//     title: Text('Learn about Widgets'),
//   ),
//   body: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       const Center(child: Text('Rimsha Ashraf', style: TextStyle(fontSize: 40),)),
//       const CircleAvatar(
//         radius: 90,
//         backgroundColor: Colors.grey,
//         backgroundImage: NetworkImage('https://tse3.mm.bing.net/th?id=OIP.xLxr0q5UsemPgxRlOTlMdAHaLG&pid=Api&P=0'),
//       ),
//       const Divider(color: Colors.black,thickness: 2,),
//       const SizedBox(
//         height: 20,
//         child: VerticalDivider(color: Colors.black, thickness: 2,),
//       ),
//       const Divider(color: Colors.black,thickness: 2,),
//       SizedBox(
//         child: Stack(
//           alignment: Alignment.bottomLeft,
//           children: [
//             Container(
//               width: 500,
//               height: 500,
//               color: Colors.blue,
//             ),
//             Container(
//               width: 500,
//               height: 400,
//               color: Colors.blue.shade300,
//             ),
//
//             Container(
//                 width: 500,
//                 height: 300,
//                 color: Colors.blue.shade200,
//               ),
//           ],
//         ),
//       ),
//     ],
//   ),
// ),

// ************************************************

//   home: Scaffold(
//   appBar: AppBar(
//     title: Center(child: Text('Lottery App')),
//   ),
//   body: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//
//     children: [
//       Row(
//           children: [
//             Expanded(
//               child: Center(
//                 child: Container(
//                   height: 100,
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:BorderRadius.circular(10),
//                       // border: Border.all(
//                       //   color: Colors.pink,
//                       //   width: 10,
//                       // ),
//                       // image: const DecorationImage(
//                       //   fit: BoxFit.fill,
//                       //   image: NetworkImage('https://tse3.mm.bing.net/th?id=OIP.8M-MuPfGTpFaY8vB04hkYwHaNK&pid=Api&P=0'),
//                       // ),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black,
//                           blurRadius: 20,
//                         ),
//                       ]
//                   ),
//                   child: Center(child: Text('Box1')),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Center(
//                 child: Container(
//                   height: 100,
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:BorderRadius.circular(10),
//                       // border: Border.all(
//                       //   color: Colors.pink,
//                       //   width: 10,
//                       // ),
//                       // image: const DecorationImage(
//                       //   fit: BoxFit.fill,
//                       //   image: NetworkImage('https://tse3.mm.bing.net/th?id=OIP.8M-MuPfGTpFaY8vB04hkYwHaNK&pid=Api&P=0'),
//                       // ),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black,
//                           blurRadius: 20,
//                         ),
//                       ]
//                   ),
//                   child: Center(child: Text('Box2')),
//                 ),
//               ),
//             ),
//           ],
//
//       ),
//       Expanded(
//         flex: 1,
//         child: Center(
//           child: Container(
//
//             // transform: Matrix4.rotationX(.5),
//             padding: EdgeInsets.all(5),
//             decoration: const BoxDecoration(
//               color: Colors.cyan,
//               borderRadius:BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20)
//               ),
//               // border: Border.all(
//               //   color: Colors.pink,
//               //   width: 10,
//               // ),
//                 image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: NetworkImage('https://tse3.mm.bing.net/th?id=OIP.8M-MuPfGTpFaY8vB04hkYwHaNK&pid=Api&P=0'),
//                 ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black,
//                   blurRadius: 20,
//                 ),
//               ]
//             ),
//             child: Center(child: Text('Sign up')),
//           ),
//         ),
//       )
//     ],
//   ),
// ),
