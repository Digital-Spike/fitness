import 'package:flutter/material.dart';
class Single extends StatefulWidget {
  const Single({super.key});

  @override
  State<Single> createState() => _SingleState();
}

class _SingleState extends State<Single> {
  List<String> session = ['2', '4', '8', '12', '24', '48', '96'];
  List<int> price = [359, 652, 1248, 1788, 3096, 4800, 7599];
  List<String> perSession = ['169', '163', '156', '149', '129', '100', '79'];
  List<String> validity = [
    '15 days',
    '15 days',
    '30 days',
    '30 days',
    '60 days',
    '120 days',
    '365 days'
  ];
  

   final List<Color> colors = [
    Colors.red.shade400,
    Colors.green,
    Color(0xff00e6f6),
    Color(0xffff8c00),
    Colors.purple.shade400,
    Color(0xfff1c40f),
    Colors.teal,
    Colors.pink,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          
          itemCount: session.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 120,
            crossAxisCount: 2), itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              
            },
            child: Container(
              
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
               color: colors[index]
             
              ),
              child: Column(
                children: [
                 Text(session[index],style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                
                 Text('Sessions',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  
                
              
            ),
          );
        })),
      ),
    );
  }
}