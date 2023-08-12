import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class TrainerLogin extends StatefulWidget {
  const TrainerLogin({super.key});

  @override
  State<TrainerLogin> createState() => _TrainerLoginState();
}

class _TrainerLoginState extends State<TrainerLogin> {
  bool _isSecurePassword = true;

  final _passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   SafeArea(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage('assets/ems jacket.webp'),
                  fit: BoxFit.contain,
                  opacity: 0.98,
                )),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.2)),
                    child: Column(
                      children: const [
                      
                        Text(
                          'Transform your body\nand mind',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'with the ultimate EMS fitness journey app for anyone who wants to take control of their health and fitness',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
           
                 
                  const SizedBox(height: 80),
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.2)),
                    child: Column(
                      children: [
                        TextFormField(
                        
                          
                          decoration: InputDecoration(
                              
                              isDense: true,
                              filled: true,
                              fillColor: Colors.black54,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Fill this';
                            } 
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          // style: const TextStyle(color: Colors.black),
                          controller: _passwordController,
                          obscureText: _isSecurePassword,
                          decoration: InputDecoration(
                              //   label: const Text('Password',style: TextStyle(color: Colors.grey),),
                              hintText: 'Password',
                              // hintStyle: const TextStyle(color: Colors.grey),
                              isDense: true,
                              filled: true,
                              fillColor: Colors.black54,
                              suffixIcon: togglepassword(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter Password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                       
                        const SizedBox(height: 20),
                        GestureDetector(
                            onTap: (){},
                            child: SvgPicture.asset('assets/login.svg')),
                        const SizedBox(height: 20),
                      
                       
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
  Widget togglepassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
}
}