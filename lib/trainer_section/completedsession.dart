import 'package:flutter/material.dart';
class CompletedSession extends StatefulWidget {
  const CompletedSession({super.key});

  @override
  State<CompletedSession> createState() => _CompletedSessionState();
}

class _CompletedSessionState extends State<CompletedSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Sessions'),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context , index){
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white24),
          child: const Column(
            children: [
              Row(
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Date :')
                    ],
                  ),
                  Row(
                    children: [
                      Text('Time :')
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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