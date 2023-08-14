import 'package:fitness/screens/buddy.dart';
import 'package:fitness/screens/main_screen.dart';
import 'package:fitness/screens/single.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<Packages>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? selectedplans;

  final List<String> options = ['Standard', 'Special'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      mainAppBar: AppBar(
        //  backgroundColor: const Color(0xffF5E6C2),
        elevation: 0,
     
        title: const Text(
          'Our Packages',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      mainChild: Container(
        height: double.infinity,
        width: double.infinity,
         decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade700,Colors.black54])
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: DropdownButtonFormField<String>(
                    value: selectedplans,
                    items: options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedplans = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an option';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      // labelText: 'Select a plan',
                      hintText: 'Select a plan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10,right: 10,top: 5),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white54,
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color:
                      Colors.deepOrange, // Set the indicator color to deep orange
                ),
                tabs: [
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Single',
                        style: TextStyle(
                         
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: _tabController.index == 0
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Buddy',
                        style: TextStyle(
                         
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: _tabController.index == 1
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.black, // Set background color to black
                child: TabBarView(
                  controller: _tabController,
                  children: const [Single(),Buddy()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
