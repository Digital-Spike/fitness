import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0xffFEF6E4),
      appBar: AppBar(
     //   backgroundColor:  Color(0xffF5E6C2),
        title: Text('Offers',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,),),
        leading: BackButton(),
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: Size.fromHeight(1.0)),
      ),
      body: SizedBox(
        child: Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: ((context, index) {
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Trainer :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Booking Id :',style: TextStyle(fontSize: 16,color: Colors.black),)
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      children: [
                        Text('Date :',style: TextStyle(fontSize: 16,color: Colors.black),),
                      ],
                    ),
                     Row(children: [
                    Text('Time :',style: TextStyle(fontSize: 16,color: Colors.black),)
                  ],),
                  ],),
                  
                 
                   SizedBox(height: 5),
                  Row(children: [
                    Text('Branch :',style: TextStyle(fontSize: 16,color: Colors.black),)
                  ],),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(onPressed: (){},child: Text('Postpone',style: TextStyle(color: Colors.greenAccent,fontSize: 16),),),
                       MaterialButton(onPressed: (){},child: Text('Prepone',style: TextStyle(color: Colors.green,fontSize: 16),),),
                        MaterialButton(onPressed: (){},child: Text('Cancel',style: TextStyle(color: Colors.redAccent,fontSize: 16),),)
                    ],
                  )
                ],
              ),
            );
          })),
        ),
      ),
    );
  }
}