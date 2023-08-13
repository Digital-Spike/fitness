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
    Colors.red.shade900,
    Colors.green.shade900,
    Colors.cyan.shade900,
    Colors.orange.shade900,
    Colors.purple.shade900,
    Colors.yellow.shade900,
    Colors.teal.shade900,
    Colors.pink.shade900,
  ];
   final List<Color> colorss = [
    Colors.red.shade200,
    Colors.green.shade200,
    Colors.cyan.shade200,
    Colors.orange.shade200,
    Colors.purple.shade200,
    Colors.yellow.shade200,
    Colors.teal.shade200,
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
            child: AnimatedContainer(
              
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colorss[index],colors[index]]),
              // color: colors[index],
            
             
              
            ),
            
              duration: Duration(seconds: 5),
              child: Column(
                children: [
                 Text(session[index],style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                
                 Text('Sessions',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  
                
              
            ),
          );
        })),
      ),
    );
  }
}