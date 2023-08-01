import 'package:fitness/screens/main_screen.dart';
import 'package:flutter/material.dart';
class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5E6C2),
      body: FutureBuilder<bool>(
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
         if (snapshot.connectionState == ConnectionState.done){
          return ListView.builder(
            itemCount:2,
            itemBuilder: (context, index){
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Trainer Name:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      Text('name',style: TextStyle(fontSize: 18),)
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Booking Id:',style: TextStyle(),)
                    ],
                  )
                ],
              ),
            );
          });
         }return Center(child: CircularProgressIndicator());
      })
      
     );
     
     }
     }
  
