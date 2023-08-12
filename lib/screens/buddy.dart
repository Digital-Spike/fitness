import 'package:flutter/material.dart';
class Buddy extends StatefulWidget {
  const Buddy({super.key});

  @override
  State<Buddy> createState() => _BuddyState();
}

class _BuddyState extends State<Buddy> {
  List<String> session1 = ['2', '4', '8', '12', '24', '48', '96'];
  List<String> price1 = ['398', '796', '1552', '2328', '4296', '6240', '9600'];
  List<String> persession1 = ['199', '199', '194', '194', '179', '130', '100'];
  List<String> validity1 = [
    '15 days',
    '30 days',
    '60 days',
    '90 days',
    '160 days',
    '180 days',
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
          
          itemCount: session1.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 120,
            crossAxisCount: 2), itemBuilder: ((context, index) {
          return Container(
            
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
             color: colors[index]
           
            ),
            child: Column(
              children: [
               Text(session1[index],style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
              
               Text('Sessions',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
                
              
            
          );
        })),
      ),
    );
  }
}