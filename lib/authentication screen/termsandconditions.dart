import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5E6C2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF5E6C2),
        title: const Text(
          'Terms And Conditions',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Legal Notice',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'Please read these Terms and Conditions carefully. By accessing this site and any pages thereof, you agree to be bound by the Terms and Conditions below and/or any such Terms and Conditions as are communicated on the pages thereof. If you do not agree to the Terms and conditions below and/or any such Terms and Conditions as are communicated on the pages thereof, do not access the site, or any pages thereof. This website uses cookies. By using this website and agreeing to these terms and conditions, you consent to our Fitness Journey use of cookies in accordance with the terms of Fitness Journey Privacy Policy / Cookies Policy.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              Text(
                'Use Of Information and Materials',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'The information and materials contained in these pages, and the terms, conditions, and descriptions that appear, are subject to change. Unauthorized use of Fitness Journey websites and systems including but not limited to unauthorized entry into Fitness Journey systems, misuse of passwords, or misuse of any information posted on a site is strictly prohibited. Your eligibility for particular services is subject to final determination by Fitness Journey.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              Text(
                'License To Use Website',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'Unless otherwise stated, Fitness Journey and/or its licensors own the intellectual property rights in the website and material on the website. Subject to the license below, all these intellectual property rights are reserved.You may view, download for caching purposes only, and print pages from the website for your own personal use, subject to the restrictions set out below and elsewhere in these terms and conditions.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              Text(
                'You must not:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                  '* Republish material from this website (including republication on another website);'),
              Text('* Sell, rent or sub-license material from the website;'),
              Text('* Show any material from the website in public;'),
              Text(
                  '* Reproduce, duplicate, copy or otherwise exploit material on this website for a commercial purpose;'),
              Text(
                  '* Edit or otherwise modify any material on the website; or'),
              Text(
                  '* Redistribute material from this website except for content specifically and expressly made available for redistribution.'),
              SizedBox(height: 10),
              Text(
                'Acceptable Use',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'You must not use this website in any way that causes, or may cause, damage to the website or impairment of the availability or accessibility of the website; or in any way which is unlawful, illegal, fraudulent or harmful, or in connection with any unlawful, illegal, fraudulent or harmful purpose or activity.You must not use this website to copy, store, host, transmit, send, use, publish or distribute any material which consists of (or is linked to) any spyware, computer virus, Trojan horse, worm, keystroke logger, rootkit or other malicious computer software.You must not conduct any systematic or automated data collection activities (including without limitation scraping, data mining, data extraction and data harvesting) on or in relation to this website without Fitness Journey express written consent.You must not use this website to transmit or send unsolicited commercial communications. You must not use this website for any purposes related to marketing without Fitness Journey express written consent.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'User Content',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'In these terms and conditions, “your user content” means material (including without limitation text, images, audio material, video material and audio-visual material) that you submit to this website, for whatever purpose. You grant to Fitness Journey a worldwide, irrevocable, non-exclusive, royalty-free license to use, reproduce, adapt, publish, translate and distribute your user content in any existing or future media. You also grant to Fitness Journey the right to sub-license these rights, and the right to bring an action for infringement of these rights.\nYour user content must not be illegal or unlawful, must not infringe any third party’s legal rights, and must not be capable of giving rise to legal action whether against you or Fitness Journey or a third party (in each case under any applicable law).You must not submit any user content to the website that is or has ever been the subject of any threatened or actual legal proceedings or other similar complaint.Fitness Journey reserves the right to edit or remove any material submitted to this website, or stored on Fitness Journey servers, or hosted or published upon this website.\nFitness Journey rights under these terms and conditions in relation to user content, Fitness Journey does not undertake to monitor the submission of such content to, or the publication of such content on, this website.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'No Warranty',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'The information and materials contained in this site, including text, graphics, links or other items are provided “as is”, “as available” Fitness Journey does not warrant the accuracy, adequacy, or completeness of this information and materials and expressly disclaims liability for errors or omissions in this information and materials. No warranty of any kind, implied, express or statutory including but not limited to the warranties of non-infringement of third-party rights, title, merchantability, fitness for a particular purpose and freedom from computer virus, is given in conjunction with the information and materials.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Limitations Of Liability',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'In no event will Fitness Journey be liable for any damages, including without limitation direct or indirect, special, incidental, or consequential damages, losses or expenses arising in connection with this site or any linked site or use thereof or inability to use by any party or in connection with any failure of performance, error, omission, interruption, defect, delay in operation or transmission, computer virus or line or system failure, even if Fitness Journey, or representatives thereof are advised of the possibility of such damages, losses or expenses.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Exceptions',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'Nothing in this website disclaimer will exclude or limit any warranty implied by law that it would be unlawful to exclude or limit.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'BREACHES OF THESE TERMS AND CONDITIONS',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Without Prejudice To',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'Fitness Journey other rights under these terms and conditions, if you breach these terms and conditions in any way, Fitness Journey may take such action as it deems appropriate to deal with the breach, including suspending your access to the website, prohibiting you from accessing the website, blocking computers using your IP address from accessing the website, contacting your internet service provider to request that they block your access to the website and/or bringing court proceedings against you.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Variation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'Fitness Journey may revise these terms and conditions from time-to-time. Revised terms and conditions will apply to the use of this website from the date of the publication of the revised terms and conditions on this website. Please check this page regularly to ensure you are familiar with the current version.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Assignment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'Fitness Journey may transfer, sub-contract or otherwise deal with Fitness Journey rights and/or obligations under these terms and conditions without notifying you or obtaining your consent.You may not transfer, sub-contract or otherwise deal with your rights and/or obligations under these terms and conditions.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Severability',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'If a provision of these terms and conditions is determined by any court or other competent authority to be unlawful and/or unenforceable, the other provisions will continue in effect. If any unlawful and/or unenforceable provision would be lawful or enforceable if part of it were deleted, that part will be deemed to be deleted, and the rest of the provision will continue in effect.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Entire Agreement',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'These terms and conditions constitute the entire agreement between you and Fitness Journey in relation to your use of this website, and supersede all previous agreements in respect of your use of this website.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Law And Jurisdiction',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'These terms and conditions will be governed by and construed in accordance with laws of United Arab Emirates and any disputes relating to these terms and conditions will be subject to the exclusive jurisdiction of the courts of Dubai, United Arab Emirates.',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
