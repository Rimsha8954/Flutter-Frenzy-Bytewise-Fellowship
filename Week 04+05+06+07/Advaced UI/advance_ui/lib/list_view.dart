import 'package:advance_ui/screen_one.dart';
import 'package:flutter/material.dart';
import 'package:advance_ui/model.dart';

class Gridview extends StatefulWidget {
  const Gridview({Key? key}) : super(key: key);

  @override
  State<Gridview> createState() => _GridviewState();
}

class _GridviewState extends State<Gridview> {
  List<GridModel> _gridlist = <GridModel>[
    GridModel(title: "Horses", image: "images/Horse1.jpg"),
    GridModel(title: "Sky view", image: "images/Image2.jpeg"),
    GridModel(title: "Night view", image: "images/Image1.jpg"),
    GridModel(title: "Sky view", image: "images/Image2.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter GridView'),
      ),
      body: Container(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: _gridlist.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        _gridlist[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => ScreenOne(title: _gridlist[index].title, image: _gridlist[index].image)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${_gridlist[index].title}",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              })),
    );
  }
}

/// ListView & List Tile

// class ListViewGrid extends StatefulWidget {
//   const ListViewGrid({Key? key}) : super(key: key);
//
//   @override
//   State<ListViewGrid> createState() => _ListViewGridState();
// }
//
// class _ListViewGridState extends State<ListViewGrid> {
//   List<ItemModel> _items = <ItemModel>[
//     ItemModel(
//         title: "Item1",
//         subtitle: "Most Purchased"
//     ),
//     ItemModel(
//         title: "Item2",
//         subtitle: "For sale"
//     ),
//     ItemModel(
//         title: "Item3",
//         subtitle: "Double XL sizes available"
//     ),
//     ItemModel(
//         title: "Item4",
//         subtitle: "Out of Stock"
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter List/View Grid'),
//       ),
//
//       /// ListView Concept
//       body: Container(
//         child: ListView(
//           children: List.generate(_items.length, (index){
//                 return ListTile(
//                 title: Text(_items[index].title),
//                 subtitle: Text(_items[index].subtitle),
//                 trailing: Icon(_items[index].icon),
//                 onTap: () {
//                    print('$_items[index].title here');
//                    },
//           );
//           // [
//           //   ListTile(
//           //     title: Text('Item 1'),
//           //     subtitle: Text('Most purchased item'),
//           //     trailing: Icon(Icons.arrow_forward),
//           //     onTap: () {
//           //       print('Item 1 pressed');
//           //     },
//           //   ),
//           //   ListTile(
//           //     title: Text('Item 2'),
//           //     subtitle: Text('Beautiful packaging'),
//           //     trailing: Icon(Icons.arrow_forward),
//           //   ),
//           //   ListTile(
//           //     title: Text('Item 3'),
//           //     subtitle: Text('For sale'),
//           //     trailing: Icon(Icons.arrow_forward),
//           //   ),
//           // ],
//       },
//       ),
//     ),
//     ),
//     );
//   }
// }
