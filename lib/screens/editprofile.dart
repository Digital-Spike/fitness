import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final items = ['Kgs', 'Lbs'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5E6C2),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5E6C2),
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
                                        backgroundColor: Colors.grey,
                                        child: Text(
                                          "Upload Image",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: GestureDetector(
                                          onTap: 
                                          _showDialog,
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.white),
                                            child: Image.asset('assets/camera.png',scale: 1.5,))))
                                  ],
                                ),
                              ),
                ),
              const SizedBox(height: 15),
              const Divider(height: 1.0,color: Colors.black,thickness: 1.0,),
              const SizedBox(height: 15),
              const Text(' Username',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              const SizedBox(height: 5),
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
                            const SizedBox(height: 15),
              const Text(' Name',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              const SizedBox(height: 5),
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
                           const SizedBox(height: 15),
              const Text(' Email',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              const SizedBox(height: 5),
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
                          const SizedBox(height: 15),
              const Text(' Phone Number',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              const SizedBox(height: 5),
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
                            const SizedBox(height: 15),
              const Text(' Weight',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              const SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                                  prefix: DropdownButton<String>(
                                    elevation: 0,
                                    value: value,
                                    borderRadius: BorderRadius.circular(5),
                                    isDense: true,
                                    hint: const Text('Kgs'),
                                    items: items.map(buildMenuItem).toList(), onChanged: (value)=>setState((){ this.value=value;
                                    }
                              )),
                             
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                             
                            ),
                           const SizedBox(height: 15),
              const Text(' Height',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              const SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                              prefix: DropdownButton(items: [], onChanged: (value)=>setState(() {
                                
                              })),
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                             
                            ),
                           const SizedBox(height: 15),
              const Text(' Do You Have Any Previous Injuries?',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16),),
              const SizedBox(height: 5),
                            TextFormField(
                              
                              decoration: InputDecoration(
                                  
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              
                            ),
                            const SizedBox(height: 25),
                            Center(
                              child: GestureDetector(
                                onTap: (){},
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(colors: [Colors.deepOrangeAccent,Colors.amberAccent])),
                                  padding: const EdgeInsets.all(10),
                                  child: const Center(child: Text('Submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),))),
                              ),
                            ),
                            const SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
  void _showDialog() {
    showDialog(context: context, builder: (context){
      return CupertinoAlertDialog(
        title: Image.asset('assets/CameraIcon.png',height: 60,),
        content: const Text('Choose from',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
       actions: [
         MaterialButton(onPressed: () {
          
        },
        child: const Text('Camera',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
        ),
        MaterialButton(onPressed: () {
          
        },
        child: const Text('Gallery',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),)
       ],
      );
    });
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
      );
}