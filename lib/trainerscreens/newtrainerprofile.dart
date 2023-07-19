import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness/Slotscreens/slotBookingPage.dart';
import 'package:fitness/constants/api_list.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
class NewTrainerProfile extends StatefulWidget {
  final Map<String, dynamic> trainer;
  final bool isBranch;
  const NewTrainerProfile(
      {super.key, required this.trainer, required this.isBranch});
  @override
  State<NewTrainerProfile> createState() => _NewTrainerProfileState();
}

class _NewTrainerProfileState extends State<NewTrainerProfile> {
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
      backgroundColor: const Color(0xffE2EEFF),
      appBar: AppBar(
         backgroundColor: const Color(0xffE2EEFF),
        title: const Text('Trainer profile',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
        elevation: 0,
        centerTitle: true,
       leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           CircleAvatar(
                    minRadius: 60,
                    backgroundColor: Colors.grey,
                    child: CachedNetworkImage(
                      height: 120,
                      imageUrl:ApiList.imageUrl + (widget.trainer['image'] ?? ""),
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Card(
                      elevation: 5,
                      
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     margin: EdgeInsets.all(15),
                    
                     child:  Padding(
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
                              SizedBox(height: 5,),
                              Text('EMS Trainer',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                              SizedBox(height: 10,),
                             Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async{
                                    launch('tel://$number');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(border: Border.all(width: 0.5,color: Colors.black),borderRadius: BorderRadius.circular(20)),
                                    child: Icon(Icons.phone),
                                  ),
                                ),
                                 Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(border: Border.all(width: 0.5,color: Colors.black),borderRadius: BorderRadius.circular(20)),
                                  child: Icon(Icons.message),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launchWhatsApp();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(border: Border.all(width: 0.5,color: Colors.black),borderRadius: BorderRadius.circular(20)),
                                    child: Image.asset('assets/whatsapp.png',height: 26,),
                                  ),
                                ),
                               
                              ],
                             ),
                              SizedBox(height: 15),
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
                                           Text('Experience : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
Expanded(child: Text(widget.trainer['description'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)),                                      ],
                                       ),
                                       SizedBox(height: 10),
                                       Row(
                                        children: [
                                          Text('Speak         :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),SizedBox(width: 5,),
                                          Text('Arabic & English',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),)
                                        ],
                                       ),
                                       SizedBox(height: 10),
                                       Row(
                                        children: [
                                          Text('Qualifiction:',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),)
                                        ],
                                       ),
                                       SizedBox(height: 20,),
                                       MaterialButton(
                                        color: Colors.deepOrange,
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SlotBookingPage(isBranch: false, trainer: widget.trainer)));
                                        },child: Text('Book Session',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),)
                                       
                           ],
                         ),
                     ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('    Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600))
        ],
      )
    );
  }
}