

import 'package:fitness/screens/packagedetail.dart';

import 'package:flutter/material.dart';

class Single extends StatefulWidget {
  const Single({super.key});

  @override
  State<Single> createState() => _SingleState();
}

class _SingleState extends State<Single> {
  List<int> session = [2, 4, 8, 12, 24, 48, 96];
  List<int> price = [359, 652, 1248, 1788, 3096, 4800, 7599];
  List<int> perSession = [169, 163, 156, 149, 129, 100, 79];
  List<int> validity = [
   15 ,
    15 ,
    30 ,
    30 ,
    60 ,
    120 ,
    365 
  ];
  int _selectedValidity=0;
int _selectedSession=0;
 int _selectedPrice=0;
 int _selectedPersession=0;  
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
              setState(() {
    _selectedPersession = index;
    _selectedPrice=index;
    _selectedSession=index;
    _selectedValidity=index;
  });
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PackageDetail(gradient: gridGradients[index], persession: perSession[_selectedPersession], price: price[_selectedPrice], session: session[_selectedSession], validity: validity[_selectedValidity],)));
            },
            child: Container(
              
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient:
                  
                   gridGradients[index]
              // color: colors[index],
            
             
              
            ),
            
            
              child: Column(
                children: [
                 Text(session[index].toString(),style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
                
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






