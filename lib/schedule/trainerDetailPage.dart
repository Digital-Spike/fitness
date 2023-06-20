import 'package:fitness/screens/mainScreen.dart';
import 'package:flutter/material.dart';

class TrainerDetailPage extends StatefulWidget {
  final Map<String, dynamic> trainer;

  const TrainerDetailPage({Key? key, required this.trainer}) : super(key: key);

  @override
  State<TrainerDetailPage> createState() => _TrainerDetailPageState();
}

class _TrainerDetailPageState extends State<TrainerDetailPage> {
  Map<String, dynamic> trainer = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      backgroundColor: Colors.black,
      mainAppBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Trainer",
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
      ),
      mainChild: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/IMG_9573.jpg'),
                      Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: const Size(400, 60),
                                  backgroundColor: Colors.orange),
                              onPressed: () {},
                              child: const Text(
                                'Book Your Slot Now',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ))),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Name:',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('Experience:',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('Skills:',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text('About Trainer:',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
