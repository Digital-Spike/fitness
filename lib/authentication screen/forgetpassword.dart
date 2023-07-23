import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset ()async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
     showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text('Password reset link sent! Check your email',textAlign: TextAlign.center,),
        );
      });
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString(),textAlign: TextAlign.center,),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5E6C2),
      appBar: AppBar(
        backgroundColor: Color(0xffF5E6C2),
        elevation: 0,
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: Size.fromHeight(1.0)),
        title: Text('Forgot Password',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.black),),
leading: BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Enter your Email and we will send you a password reset link',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
            SizedBox(height: 15),
            TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                                label: const Text('Email'),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Email';
                              } else if (!value.contains('@')) {
                                return 'Please Enter Valid Email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          MaterialButton(onPressed: passwordReset,
                          child: Text('Reset Password',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
                          minWidth: 150,
                          height: 45,
                          color: Colors.deepOrange,)
          ],
        ),
      ),
    );
  }
}