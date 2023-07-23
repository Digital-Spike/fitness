
import 'package:fitness/screens/homepage.dart';
import 'package:flutter/material.dart';

class FreetrialSlot extends StatefulWidget {
  final bool isBranch;
  final Map<String, dynamic> trainer;
  const FreetrialSlot(
      {required this.isBranch, required this.trainer, super.key});

  @override
  State<FreetrialSlot> createState() => _FreetrialSlotState();
}

class _FreetrialSlotState extends State<FreetrialSlot> {

TimeOfDay _timeOfDay =const TimeOfDay(hour: 10, minute: 30);

  void _showTimePicker(){
    showTimePicker(
      
      context: context, initialTime: TimeOfDay.now()).then((value) {
        setState(() {
          _timeOfDay=value!;
        });
      });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5E6C2),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5E6C2),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.black,
          ),
        ),
        title: const Text('Book Trial Session',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              const SizedBox(height: 5),
              const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter Your Name',
        ),
        
              ),
              const SizedBox(height: 10),
              const Text('Phone Number',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              const SizedBox(height: 5),
              const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter Phone Number',
        ),
        
              ),
              const SizedBox(height: 10),
              const Text('Email',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              const SizedBox(height: 5),
              const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter Your Email',
        ),
        
              ),
              const SizedBox(height: 10),
              const Text('City',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              const SizedBox(height: 5),
              const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Enter Your City',
        ),
        
              ),
              const SizedBox(height: 15),
              const Text('Select a Time so Our Team can Contact You',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: _showTimePicker,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5,color: Colors.black),
                    borderRadius: BorderRadius.circular(10),color: Colors.white
                  ),
                  child: Row(
                    children: [
                     const Icon(Icons.access_time_filled_outlined,size: 30,),const SizedBox(width: 20),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        const Text('Time',style: TextStyle(fontWeight: FontWeight.w500),),
                        const SizedBox(height: 2),
                         Text(_timeOfDay.format(context).toString(),style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
                       ],
                     )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20
              ),
              Center(child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.deepOrange,
                onPressed: _showDialog,child: const Text('Confirm',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),))
            ],
          ),
        ),
      ),
    );
  }
void _showDialog(){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: const Text('Thank You For Choosing\nFitness journey',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.deepOrange),textAlign: TextAlign.center,),
      content: const Text('Our Team Will Contact You Shortly Please Explore Our Other features in mean time',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
      actions: [
        Center(
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.deepOrange,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
            },
            child: const Text('OK',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),),
        )
      ],
    );
  });
}
  
}
