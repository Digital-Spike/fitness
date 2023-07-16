import 'package:flutter/material.dart';

class TrainerCard1 extends StatelessWidget {
  final String name;
  final String experience;
  final String skills;
  final String image;

  TrainerCard1(
      {required this.name,
      required this.experience,
      required this.skills,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    minRadius: 40,
                    foregroundImage: AssetImage(image),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        skills,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        experience,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Available',
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }
}
