import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('WhatsApp'),
            bottom: const TabBar(tabs: [
              Tab(
                child: Icon(Icons.people),
              ),
              Tab(
                child: Text('Chats'),
              ),
              Tab(
                child: Text('Status'),
              ),
              Tab(
                child: Text('Call'),
              ),
            ]),
            actions: [


              Icon(Icons.camera_alt_outlined),
              SizedBox(width: 15),
              Icon(Icons.search_off_outlined),
              SizedBox(width: 10),
              PopupMenuButton(
                  icon: Icon(Icons.more_vert_outlined),
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 1,
                      child: Text('New Group'),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text('New broadcast'),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text('Linked devices'),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text('Starred messages'),
                    ),
                    PopupMenuItem(
                      value: 1,
                      child: Text('Settings'),
                    ),
                  ]
              ),
            ],
          ),
          body: TabBarView(
            children: [
              Text('Community'),
              ListView.builder(
                itemCount: 1,
                  itemBuilder: (context, index){
                return const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://tse3.mm.bing.net/th?id=OIP._0Z9MuT1QfzumjSaMkX5PAHaHa&pid=Api&P=0'),
                  ),
                  title: Text('Neha'),
                  subtitle: Text('Hey, Whatsup'),
                  trailing: Text('12:48 AM'),
                );
              }),
              ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index){
                    if(index /2 == 0){
                      return const ListTile(
                        leading: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        title: Text('My Status'),
                        subtitle: Text('Tap to status update'),

                      );
                    }
                    else{
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage('https://tse4.mm.bing.net/th?id=OIP.rvSWtRd_oPRTwDoTCmkP5gHaE8&pid=Api&P=0'),
                              ),
                              title: Text('Mates'),
                              subtitle: Text('40 minutes ago'),
                            ),
                          ],
                        ),
                      );
                    }

                  }),
              ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('https://tse3.mm.bing.net/th?id=OIP.tobxvjVp0Xep_vMvvjtoowHaGE&pid=Api&P=0'),
                      ),
                      title: Text('Lala'),
                      subtitle: Text(index / 2 == 0 ? 'you missed audio call' : '7:01 PM'),
                      trailing: Icon( index / 2 == 0 ? Icons.call: Icons.video_call, color: Colors.teal,),
                    );
                  }),
            ],
          ),
        ));
  }
}
