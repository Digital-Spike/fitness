import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class Slotbooking1 extends StatefulWidget {
  const Slotbooking1({super.key});

  @override
  State<Slotbooking1> createState() => _Slotbooking1State();
}

class _Slotbooking1State extends State<Slotbooking1> {
  final items = ['Free solo Training', 'Free duo Training'];
  String? value;

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
                  hint: const Text('Select Training'),
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
              SizedBox(
                height: 20,
              ),
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
              Wrap(spacing: 10, runSpacing: 10, children: [
                InkWell(
                  onTap: () {
                    setState(() => pressAttention = !pressAttention);
                  },
                  child: Container(
                    height: 100,
                    width: 190,
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
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() => pressAttention1 = !pressAttention1);
                  },
                  child: Container(
                    height: 100,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: pressAttention1
                            ? Colors.blueGrey.shade200
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(-4.0, -4.0),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ]),
                    child: Column(
                      children: [],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() => pressAttention2 = !pressAttention2);
                  },
                  child: Container(
                    height: 100,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: pressAttention2
                            ? Colors.blueGrey.shade200
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(-4.0, -4.0),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() => pressAttention3 = !pressAttention3);
                  },
                  child: Container(
                    height: 100,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: pressAttention3
                            ? Colors.blueGrey.shade200
                            : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.grey.shade100,
                            offset: const Offset(-4.0, -4.0),
                            blurRadius: 12,
                            spreadRadius: 1,
                          ),
                        ]),
                  ),
                ),
              ]),
              SizedBox(height: 20),
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
                onTap: () {},
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )),
                ),
              )
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
}
