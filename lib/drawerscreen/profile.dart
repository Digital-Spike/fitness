import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  final picker = ImagePicker();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _selectImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _editProfile() {
    if (_formKey.currentState!.validate()) {
      // Perform edit profile functionality here
      // Retrieve the updated values from the text controllers
      String firstName = firstNameController.text;
      String lastName = lastNameController.text;
      String email = emailController.text;
      String mobileNumber = mobileNumberController.text;
      String country = countryController.text;
      String state = stateController.text;
      String city = cityController.text;
      String zipCode = zipCodeController.text;

      // Use the updated values as required
      // For example, you can save the changes to a database or update a user object

      // Show a success message or navigate to another screen
      // after successfully editing the profile
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Profile Updated'),
            content: Text('Your profile has been successfully updated.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: _selectImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.deepOrange,
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.person, size: 60)
                            : null,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter yourfirst name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email abcd1234@gmail.com';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: mobileNumberController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: countryController,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: stateController,
                  decoration: InputDecoration(
                    labelText: 'State',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: zipCodeController,
                  decoration: InputDecoration(
                    labelText: 'Zip Code',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your zip code';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _editProfile,
                  child: Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
