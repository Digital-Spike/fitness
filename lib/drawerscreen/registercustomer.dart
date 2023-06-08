import 'package:flutter/material.dart';

class RegisterCustomer extends StatefulWidget {
  const RegisterCustomer({super.key});

  @override
  State<RegisterCustomer> createState() => _RegisterCustomerState();
}

class _RegisterCustomerState extends State<RegisterCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Customer'),
      ),
      body: Container(),
    );
  }
}
