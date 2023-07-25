import 'package:fitness/Slotscreens/freetrialslot.dart';
import 'package:flutter/material.dart';
class FreeTrialSession extends StatefulWidget {
 final Map<String, dynamic> trainer;
  final bool isBranch;
  const FreeTrialSession(
      {super.key, required this.trainer, required this.isBranch});

  @override
  State<FreeTrialSession> createState() => _FreeTrialSessionState();
}

class _FreeTrialSessionState extends State<FreeTrialSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5E6C2),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5E6C2),
        title: const Text('Free Trial Session',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: const Size.fromHeight(1.0)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/Freetrial.png'),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Reasons To Start EMS',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.deepOrange),),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('*  Get ready to transform your body with our 20 minutes Ems training in Dubai. Experience the benefits of this highly-effective training method for yourself!',textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('*  Personal Ems fitness trainers in Dubai are here to guide and motivate you every step of the way. Book your session now and take that first step towards a stronger, healthier you',textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text("*  Start before you're ready with our EMS Fitness Training! Don't just wait to step out of your comfort zone, push yourself with EMS today!",textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('*  Elevate your fitness routine with the latest technology: Electrical stimulation workout in Dubai! Improve muscle strength, endurance, and tone with personalized sessions designed to maximize your results.',textAlign: TextAlign.left,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> FreetrialSlot(isBranch: widget.isBranch, trainer: widget.trainer)));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: const Text('Book Trial Session',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
                      decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(colors: [Colors.green,Colors.blue])
                      ),
              ),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}