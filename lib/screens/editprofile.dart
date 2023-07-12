import 'package:flutter/material.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE2EEFF),
      appBar: AppBar(
        backgroundColor: const Color(0xffE2EEFF),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
        ),
        leading: const BackButton(color: Colors.black),
        elevation: 0,
        bottom: PreferredSize(child: Container(height: 1.0,color: Colors.black,), preferredSize: const Size.fromHeight(1.0)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
                Center(
                  child: SizedBox(
                                height: 115,
                                width: 115,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    const CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                        radius: 55,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          "Upload Image",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 5,
                                        bottom: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            
                                          },
                                          child: Image.asset('assets/camera.png',scale: 1.5,)))
                                  ],
                                ),
                              ),
                ),
              SizedBox(height: 15),
              Divider(height: 1.0,color: Colors.black,thickness: 1.0,),
              SizedBox(height: 15),
              Text(' Username',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              SizedBox(height: 5),
            TextFormField(
                              
                              decoration: InputDecoration(
                                  label: const Text('User Name'),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter user name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
              Text(' Name',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                                  label: const Text('Name'),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Name';
                                }
                                return null;
                              },
                            ),
                           SizedBox(height: 15),
              Text(' Email',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                                  label: const Text('Email'),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email';
                                }
                                return null;
                              },
                            ),
                          SizedBox(height: 15),
              Text(' Phone Number',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                                  label: const Text('Phone Number'),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Phone Number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
              Text(' Weight',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                                 
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                             
                            ),
                           SizedBox(height: 15),
              Text(' Height',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                               
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                             
                            ),
                           SizedBox(height: 15),
              Text(' Do You Have Any Previous Injuries?',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                                  
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              
                            ),
                            SizedBox(height: 25),
                            Center(
                              child: GestureDetector(
                                onTap: (){},
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [Colors.deepOrangeAccent,Colors.amberAccent])),
                                  padding: EdgeInsets.all(10),
                                  child: Center(child: Text('Submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),))),
                              ),
                            ),
                            SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}