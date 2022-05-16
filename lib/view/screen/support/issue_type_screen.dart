import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shariqq_multivendor_ecom_userapp/localization/language_constrants.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/color_resources.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/custom_themes.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/dimensions.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/custom_expanded_app_bar.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/support/add_ticket_screen.dart';

class IssueTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> issueTypeList = [
      'Website Problem',
      'Partner request',
      'Complaint',
      'Info inquiry'
    ];

    return CustomExpandedAppBar(
      title: getTranslated('support_ticket', context),
      isGuestCheck: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_LARGE,
              left: Dimensions.PADDING_SIZE_LARGE),
          child: Text("You can create a ticket",
              style: titilliumSemiBold.copyWith(fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_LARGE,
              bottom: Dimensions.PADDING_SIZE_LARGE),
          child: Text("Please select issue type",
              style: titilliumRegular),
        ),
        Expanded(
            child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE,
              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          itemCount: issueTypeList.length,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
              child: ListTile(
                leading: Icon(Icons.arrow_right,
                    color: ColorResources.getPrimary(context)),
                title: Text(issueTypeList[index], style: robotoBold),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              AddTicketScreen(type: issueTypeList[index])));
                },
              ),
            );
          },
        )),
      ]),
    );
  }
}
