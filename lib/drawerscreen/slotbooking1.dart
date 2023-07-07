import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../schedule/trainer.dart';

class Slotbooking1 extends StatefulWidget {
  const Slotbooking1({super.key});

  @override
  State<Slotbooking1> createState() => _Slotbooking1State();
}

class _Slotbooking1State extends State<Slotbooking1> {
  final items = ['Free Trail Session', 'Pay Per Session','Single Plan Subscription','Buddy Plan Subscription'];
  String? value;
  final items1 = ['EMS Fitness Training', 'Personal Training','Injury Rehab','Body Building'];
  String? value1;

  bool pressAttention = false;
  bool pressAttention1 = false;
  bool pressAttention2 = false;
  bool pressAttention3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Book Your Session',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        centerTitle: true,
        leading: BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: DropdownButton<String>(
                  hint: const Text('Select Session'),
                  value: value,
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(
                    () => this.value = value,
                  ),
                ),
              ),
              
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(),
                child: DropdownButton<String>(
                  hint: const Text('Select Training'),
                  value: value1,
                  isExpanded: true,
                  underline: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                  items: items1.map(buildMenuItem1).toList(),
                  onChanged: (value1) => setState(
                    () => this.value1 = value1,
                  ),
                ),
              ),SizedBox(height: 20),
              Text(
                '  Preffered Date',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.black,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  // New date selected
                  setState(() {});
                },
              ),
              SizedBox(height: 20),
              Text(
                '  Preffered Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              SizedBox(
                 height: MediaQuery.of(context).size.height * 0.70,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                 mainAxisExtent: 100,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                
                ), itemBuilder:(context, index){
                 return InkWell(
                    onTap: () {
                      setState(() => pressAttention = !pressAttention);
                    },
                    child: Container(
                      height: 100,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: pressAttention
                            ? Colors.blueGrey.shade200
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 12,
                            spreadRadius: 4,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(-4.0, -4.0),
                            blurRadius: 12,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('9:00 AM - 9:45 AM'),
                          SizedBox(height: 10),
                          Text('Available',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.green),)
                        ],
                      ),
                    ),
                  );
                } ),
              ),
                
                 Center(
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5, backgroundColor: Colors.white),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Location',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Icon(Icons.pin_drop)
                      ],
                    )),
              ),
              
             
             
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Trainer()));
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [Color(0xffFA812F), Color(0xffFFFA08)])),
                  child: Center(
                      child: Text(
                    'Personal Trainer',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )),
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );
       DropdownMenuItem<String> buildMenuItem1(String item1) => DropdownMenuItem(
        value: item1,
        child: Text(
          item1,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );
}
