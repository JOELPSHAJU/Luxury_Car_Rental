import 'package:flutter/material.dart';

import 'package:luxurycars/Universaltools.dart';
import 'package:luxurycars/UserPanel/UserHomePage.dart';

class PrivacyPolicies extends StatefulWidget {
  const PrivacyPolicies({super.key});

  @override
  State<PrivacyPolicies> createState() => _PrivacyPoliciesState();
}

Widget item({required headingtext, required context, required bodytext}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        headingtext,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * .022,
            fontWeight: FontWeight.w500,
            color: ProjectColors.secondarycolor1),
      ),
      sizedboc,
      Text(
        bodytext,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * .02,
            fontWeight: FontWeight.w400),
      )
    ],
  );
}

heading({required headingtext, required context}) {
  return Text(
    headingtext,
    style: TextStyle(
        fontSize: MediaQuery.of(context).size.height * .022,
        fontWeight: FontWeight.w600,
        color: ProjectColors.primarycolor2),
  );
}

const div2 = Divider(
  thickness: 2,
  color: Colors.black,
);
const div1 = Divider(thickness: 1);

class _PrivacyPoliciesState extends State<PrivacyPolicies> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          centerTitle: true,
          title: Text(
            'Privacy Policies',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * .019,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          backgroundColor: ProjectColors.primarycolor1,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 23,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heading(
                  headingtext: 'Information We Collect:',
                  context: context,
                ),
                div1,
                item(
                    headingtext: 'Personal Information:',
                    context: context,
                    bodytext:
                        '''When you create an account, we collect your name, email address, phone number, and other information you provide.\nWhen you make a reservation, we collect details such as pick-up/drop-off locations, dates, and preferences.'''),
                div2,
                sizedboc,
                heading(
                    headingtext: 'How We Use Your Information:',
                    context: context),
                div1,
                item(
                    headingtext: 'Providing Services:',
                    context: context,
                    bodytext:
                        'We use your personal information to provide car rental services, process reservations, and facilitate communication.'),
                div1,
                item(
                    headingtext: 'Improving User Experience:',
                    context: context,
                    bodytext:
                        'We use information to enhance and personalize your experience, such as suggesting rental options based on your preferences.'),
                div1,
                item(
                    headingtext: 'Marketing and Communication:',
                    context: context,
                    bodytext:
                        'We may send you promotional offers, updates, and important information about our services.'),
                div1,
                item(
                    headingtext: 'Legal Compliance:',
                    context: context,
                    bodytext:
                        'We use your information to comply with legal obligations and resolve disputes.'),
                div2,
                heading(headingtext: 'Your Choices:', context: context),
                div1,
                item(
                    headingtext: 'Account Information:',
                    context: context,
                    bodytext:
                        'You can review and update your account information at any time.'),
                div1,
                item(
                    headingtext: 'Security',
                    context: context,
                    bodytext:
                        'We employ industry-standard security measures to protect your information from unauthorized access, disclosure, alteration, and destruction.'),
                div1,
                item(
                    headingtext: 'Changes to this Privacy Policy:',
                    context: context,
                    bodytext:
                        'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page.'),
                div2,
                item(
                    headingtext: 'Contact Us:',
                    context: context,
                    bodytext:
                        'If you have any questions or concerns about this Privacy Policy, please contact us at on any of the below details\nBy using our car rental application, you agree to the terms outlined in this Privacy Policy.'),
                const Center(
                  child: SelectableText(
                    'joelpshaju@gmail.com',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                ProjectUtils().sizedbox10,
                const Center(
                  child: SelectableText(
                    '+91 8590182736',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                ProjectUtils().sizedbox20
              ],
            ),
          ),
        )),
      ),
    );
  }
}
