import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/Slotscreens/slotBookingPage.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class TrainerProfile extends StatefulWidget {
  final Map<String, dynamic> trainer;
  const TrainerProfile({super.key, required this.trainer});
  @override
  State<TrainerProfile> createState() => _TrainerProfileState();
}

class _TrainerProfileState extends State<TrainerProfile> {
  final number = '+971588340905';
  launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+971588340905',
      text: "Hi",
    );
    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: const Color(0xffF5E6C2),
        appBar: AppBar(
        // backgroundColor: const Color(0xffF5E6C2),
          title: const Text(
            'Trainer profile',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600,),
          ),
          elevation: 0,
          centerTitle: true,
         // leading: const BackButton(color: Colors.black,),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            CircleAvatar(
              minRadius: 60,
              backgroundColor: Colors.grey,
              child: CachedNetworkImage(
                height: 120,
                imageUrl: ApiList.imageUrl + (widget.trainer['image'] ?? ""),
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        widget.trainer['name'],
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepOrange),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'EMS Trainer',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              launch('tel://$number');
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Icon(Icons.phone),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              launchWhatsApp();
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Image.asset(
                                'assets/whatsapp.png',
                                height: 26,color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      /*   Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                        Container(


                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 1,color: Colors.black)
                          ),
                          child:  Text(widget.trainer['description'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                        ),SizedBox(width: 10),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.black),borderRadius: BorderRadius.circular(5)),
                          child: Row(
                          children: [
                            Icon(Icons.star,color: Colors.yellow,), Text(
                                      widget.trainer['rating'],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                          ],
                        ),)
                                         ],
                                       )*/
                      Row(
                        children: [
                          const Text(
                            'Experience : ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                              child: Text(
                            widget.trainer['description'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Text(
                            'Speak         :',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Arabic & English',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: const [
                          Text(
                            'Qualification:',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' Certified EMS Personal Trainer',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        color: Colors.deepOrange,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SlotBookingPage(
                                      isBranch: false,
                                      trainer: widget.trainer, )));
                        },
                        child: const Text(
                          'Book Session',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('    Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))
          ],
        ));
  }
}
