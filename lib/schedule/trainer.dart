import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class Trainer extends StatefulWidget {
  const Trainer({super.key});

 

 

  @override
  State<Trainer> createState() => _TrainerState();
}

class _TrainerState extends State<Trainer> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F2),
       appBar: AppBar(
        backgroundColor: const Color(0xffF1F1F2),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.black,
          ),
        ),
        title: const Text(
          'Our Trainers',
          style: TextStyle(
            fontSize:18,fontWeight:FontWeight.w900,color: Colors.black),
        ),
        centerTitle: true,
        leading: BackButton(color: Colors.black),
      ),
      body: 
        
        Container(
          padding: EdgeInsets.all(10),
          child: GridView.builder(
           
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 280,
            
             crossAxisSpacing: 10,
              crossAxisCount: 2,
              ),
           
           
                  itemCount: 6,
                  
                  itemBuilder: (context, index) {
                    return  Stack(
                      children: [
                        Container(
                       
                          height: 270,
                         
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                           image: DecorationImage(image: AssetImage('assets/IMG_9750.png'),fit: BoxFit.cover)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            
                            children: [
                              Row(
                                children: [
                                  Container(height: 30,width: 5,color: Colors.deepOrange,),SizedBox(width: 20),Text('Trainer Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
                                  
                                ],
                              ),
                              SizedBox(height: 20,)
                            ],
                          ),
                        )
                          
                      ],
                    );
                   } ),
        ),
        
 
    );
  }
}