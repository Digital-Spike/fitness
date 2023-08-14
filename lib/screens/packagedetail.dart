
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fitness/util/string_util.dart';
class PackageDetail extends StatefulWidget {
 final Gradient gradient;
final int session;
final int price;
final int persession;
final int validity;
   PackageDetail({required this.gradient,required this.session,required this.price,required this.persession,required this.validity});

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
late final WebViewController controller;

  String paymentUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black38
          ),
          Container(
         
            height: 340,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: widget.gradient
            ),
            // color: Color(0xfff26f14),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                
                  Row(
                    children: [
                      Text(
                        'Number of Sessions : ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      Text(widget.session.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text('Per Session',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(widget.persession.toString(),style: TextStyle(fontWeight: FontWeight.bold),),Text('/Session',style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Text('AED',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20) ,),SizedBox(width: 10,),
                      Text(
                        widget.price.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                
                  Row(
                    children: [
                      Text('Duration ',style: TextStyle(fontWeight: FontWeight.bold),),Text(widget.validity.toString(),style: TextStyle(fontWeight: FontWeight.bold),),Text(' Days',style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
           
          top: 315,
            child: MaterialButton(
              elevation: 10,
              height: 50,
              minWidth: 200,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: Colors.white,
            onPressed: () async {
               showProgress();
                                      await trainerList(widget.price);
                                      controller = WebViewController()
                                        ..setJavaScriptMode(
                                            JavaScriptMode.unrestricted)
                                        ..setBackgroundColor(
                                            const Color(0x00000000))
                                        ..loadRequest(Uri.parse(paymentUrl));
                                      if (!mounted) {
                                        return;
                                      }
                                      Navigator.of(context).pop();
                                      _showBottomSheet(context);
            },
            child: const Text('Subscribe',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.deepOrange),),
            
            )),
            
        ],
      ),
    );
  }

  Future<bool> trainerList(int amount) async {
    try {
      Response? response = await http.post(
          Uri.parse("https://fitnessjourni.com/getPaymentUrl.php"),
          body: {
            'bookingId': StringUtil().generateRandomNumber(length: 8),
            'amount': amount.toString()
          });
      paymentUrl = jsonDecode(response.body)['paymentUrl'];
      return true;
    } catch (e) {
      return false;
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
       return  Padding(
           padding:  EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom)
                       ,
           child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.001),
              child: GestureDetector(
                onTap: () {},
                child: DraggableScrollableSheet(
                  expand: true,
              initialChildSize: 1,
                  builder: (BuildContext context, controller) {
                    return SingleChildScrollView(
                    
                      controller: controller,
                      child: Container(
                        height: 1500,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                        ),
                        child: WebViewWidget(controller: this.controller),
                      ),
                    );
                  },
                ),
              ),
            ),
                 ),
         );
      },
    );
  }

  void showProgress() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      'Loading...',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}