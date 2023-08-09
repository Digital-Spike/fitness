import 'package:flutter/material.dart';
class UpdatedSession extends StatefulWidget {
  const UpdatedSession({super.key});

  @override
  State<UpdatedSession> createState() => _UpdatedSessionState();
}

class _UpdatedSessionState extends State<UpdatedSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updated Sessions'),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Updated Date'),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(4),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Updated Time'),
                      const SizedBox(height: 6),
                       Container(
                        padding: const EdgeInsets.all(4),
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
               
            ],
          ),
        );
      }),
    );
  }
}