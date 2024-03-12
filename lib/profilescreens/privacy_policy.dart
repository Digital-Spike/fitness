import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'SpaceGrotesk',
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: const Color(0xff142129),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Who We Are?',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Fitness Journey is committed to respecting the privacy concerns of its visitors to Fitness Journey application Fitness Journey has created this privacy policy to establish guidelines that will govern the collection, use, protection and disclosure of the personal and non-personal information of its visitors.',
                style: TextStyle(fontSize: 16, fontFamily: 'SpaceGrotesk'),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Personal Information',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Fitness journey does not automatically collect personal information, such as name, address, phone number, email address and other personally identifiable information, from its visitors (“Personal Information”). From time to time, Fitness journey will collect Personal Information that is voluntarily provided by its visitors in filling out contest entry forms and subscribing to newsletters and other activities carried out on the Mobile Application.',
                style: TextStyle(fontSize: 16, fontFamily: 'SpaceGrotesk'),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                'Fitness Journey also sometimes use email addresses that have been voluntarily provided by its visitors to respond to visitors who communicate with us, to inform winners of contests or to subscribe to newsletters. All emails from Fitness Journey to its visitors include instructions on how to discontinue receipt of emails, newsletters and other communication from Fitness Journey and visitors can discontinue such communication at any time. Email addresses from visitors who wish to discontinue receipt of Fitness Journey emails will be removed from Fitness Journey distribution list and databases.',
                style: TextStyle(fontSize: 16, fontFamily: 'SpaceGrotesk'),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                'All Personal Information that may identify a visitor and has been collected with the visitor’s consent by Fitness Journey is not disclosed in any identifiable form to any other party outside the company except for the fulfillment of the specific purpose identified to the visitor at the time of collection. However, Fitness Journey may disclose such information in anonymous, aggregated and non-personally identifiable form to other parties for marketing, advertising or other purposes and to better understand visitor’s use of the Mobile Application. At any time, a visitor may send an email to hello@fitnessjourni.com to request that Personal Information be changed, removed or updated in Fitness Journey databases.',
                style: TextStyle(fontSize: 16, fontFamily: 'SpaceGrotesk'),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Anonymous Non-Personal Information',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'When visitors visit the Mobile Application, anonymous, non-personal information about their visit is automatically collected. Such information may include the length and date of the visit, how the visitor navigated the Mobile Application, what pages the visitor viewed, the type of browser being used by the visitor, the type of operating system used by the visitor and the domain name of the visitor’s Internet service provider. Fitness Journey uses this Anonymous Non-Personal Information to track the success of its Mobile Application with its visitors and to better tailor the Mobile Application to visitors’ needs and interests. This Anonymous Non-Personal Information may be shared with other parties, such as broadcasters, advertisers, sponsors and partners.',
                style: TextStyle(fontSize: 16, fontFamily: 'SpaceGrotesk'),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Visitor Consent To Privacy Policy',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'By visiting and using this Mobile Application, the visitor agrees to the Privacy Policy and the terms of use (“Terms of Use”) linked to this Privacy Policy. If you do not agree to the Privacy Policy do not use this Mobile Application or provide Personal Information to Fitness Journey. If you wish to amend, update or remove the Personal Information already provided, contact number provided',
                style: TextStyle(fontSize: 16, fontFamily: 'SpaceGrotesk'),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Accountability',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'SpaceGrotesk',
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Fitness journey takes its commitment to securing privacy very seriously. From time to time, Fitness journey may amend or update this Privacy Policy to comply with visitor concerns, best practices and/or the law. Fitness Journey has appointed a member of its management team as the Privacy Officer, who is responsible for reviewing, approving, and administering this Privacy Policy.',
                style: TextStyle(fontSize: 16, fontFamily: 'SpaceGrotesk'),
                textAlign: TextAlign.justify,
              )
            ],
          ),
        ),
      ),
    );
  }
}
