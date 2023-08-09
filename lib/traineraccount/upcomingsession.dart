import 'package:flutter/material.dart';
class UpcomingSession extends StatefulWidget {
  const UpcomingSession({super.key});

  @override
  State<UpcomingSession> createState() => _UpcomingSessionState();
}

class _UpcomingSessionState extends State<UpcomingSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Sessions"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context , index){
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white24),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Name :'),
                      Text(' User Name',style: TextStyle(color: Colors.deepOrange),)
                    ],
                  ),
                
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                   
                    children: [
                      const Text('Date'),
                      const SizedBox(width: 6),
                       Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),color: Colors.white,border: Border.all(width: 1.0,color: Colors.black)),
                        child: Row(
                          children: [
                            const Text('07/08/2023 ',style: TextStyle(color: Colors.black),),
                            Icon(Icons.calendar_month_outlined,color: Colors.grey[700],)
                          ],
                        ),
                      )
                    
                    ],
                  ),
                  Row(
                   
                    children: [
                      const Text('Time'),
                      const SizedBox(width: 6),
                       Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),color: Colors.white,border: Border.all(width: 1.0,color: Colors.black)),
                        child: Row(
                          children: [
                           const Text('1:04 PM ',style: TextStyle(color: Colors.black),),
                            Icon(Icons.access_time_outlined,color: Colors.grey[700],)
                          ],
                        ),
                      )
                    
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Branch :')
                    ],
                  ),
                  Row(
                    children: [
                      Text('Id:'),
                    ],
                  )
                ],
              ),
                MaterialButton(onPressed: (){
                  _showDialog();
                },color: Colors.black, child: const Text('Session Done'),)
            ],
          ),
        );
      }),
    );
  }
   void _showDialog (){
     showDialog(context: context, builder: (context){
      return const AlertDialog(
        title: Text('data'),
      );
     });
  }
}