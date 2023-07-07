import 'package:flutter/material.dart';
class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xffF1F1F2),
     body: Center(
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 340,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
     
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/booking.png'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Your Session With ',style: TextStyle(fontSize: 18),),Text('Trainer Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.deepOrange),)
                  ],
                ),
                Text('was successfully booked',style: TextStyle(fontSize: 18),)
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(10),
            height: 210,
            width: 340,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(image: AssetImage('assets/IMG_9750.jpg'),fit: BoxFit.cover)
                        ),
                       
                      ),SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Trainer Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.deepOrange),),
                          SizedBox(height: 20),
                          Text('9:00AM - 9:45AM',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('07/07/2023',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),)
                    ,SizedBox(width: 20), Text('Id',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),)
                    ],
                  )
                ],
              ),
          )
        ],
       ),
     ),
    );
  }
}