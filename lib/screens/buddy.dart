import 'package:fitness/screens/packagedetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Buddy extends StatefulWidget {
  const Buddy({super.key});

  @override
  State<Buddy> createState() => _BuddyState();
}

class _BuddyState extends State<Buddy> {
   List<int> session = [2, 4, 8, 12, 24, 48, 96];
  List<int> price = [398, 796, 1552, 2328, 4296, 6240, 9600];
  List<int> perSession = [199, 199, 194, 194, 179, 130, 100];
  List<int> validity = [
   15 ,
    30 ,
    60 ,
    90 ,
    160 ,
    180 ,
    365 
  ];
  final List<Gradient> gridGradients = [
    LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [ Colors.red.shade900,  Colors.red.shade200,]),
    LinearGradient(
       begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [  Colors.green.shade900,Colors.green.shade200]),
 LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [  Colors.cyan.shade900,  Colors.cyan.shade200,]),
    LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [ Colors.orange.shade900,  Colors.orange.shade200,]),
    LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [ Colors.purple.shade900,  Colors.purple.shade200,]),
    LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [ Colors.yellow.shade900,  Colors.yellow.shade200,]),
       LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [ Colors.teal.shade900,  Colors.teal.shade200,]),
       LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [ Colors.pink.shade900,  Colors.pink.shade200,]),
  ];
 List<int> specialsession = [24, 48, 96, ];
  List<int> specialprice = [3866, 5616, 8640, ];
  List<String> specialperSession = ['NA'];
  List<String> specialvalidity = [
   '3 months',
    '6 months',
    '12 months'
    
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
          return Container(
            
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
             gradient: gridGradients[index]
           
            ),
            child: Column(
              children: [
               Text(session[index].toString(),style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
              
               Text('Sessions',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
                
              
            
          );
        })),
      ),
    );
  }

 
}
