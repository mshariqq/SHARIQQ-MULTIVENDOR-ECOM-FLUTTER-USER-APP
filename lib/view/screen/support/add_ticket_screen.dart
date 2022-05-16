import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/model/body/support_ticket_body.dart';

import 'package:shariqq_multivendor_ecom_userapp/localization/language_constrants.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/support_ticket_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/color_resources.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/custom_themes.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/dimensions.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/button/custom_button.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/show_custom_snakbar.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/custom_expanded_app_bar.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/textfield/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddTicketScreen extends StatefulWidget {
  final String type;
  AddTicketScreen({@required this.type});

  @override
  _AddTicketScreenState createState() => _AddTicketScreenState();
}

class _AddTicketScreenState extends State<AddTicketScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _subjectNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomExpandedAppBar(
      title: getTranslated('support_ticket', context),
      isGuestCheck: true,
      child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          children: [
            Text("Please enter details",
                style: titilliumSemiBold.copyWith(fontSize: 20)),
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_LARGE),
              child: ListTile(
                leading: Icon(Icons.query_builder,
                    color: Theme.of(context).primaryColor),
                title: Text(widget.type, style: robotoBold),
                onTap: () {},
              ),
            ),
            CustomTextField(
              focusNode: _subjectNode,
              nextNode: _descriptionNode,
              textInputAction: TextInputAction.next,
              hintText: "Subject",
              controller: _subjectController,
            ),
            SizedBox(height: 10),
            CustomTextField(
              focusNode: _descriptionNode,
              textInputAction: TextInputAction.newline,
              hintText: "Description",
              textInputType: TextInputType.multiline,
              controller: _descriptionController,
              maxLine: 5,
            ),
            SizedBox(height: 10),
            Provider.of<SupportTicketProvider>(context).isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor)))
                : Builder(
                    key: _scaffoldKey,
                    builder: (context) => CustomButton(
                        buttonText: "Create Now",
                        onTap: () {
                          if (_subjectController.text.isEmpty) {
                            showCustomSnackBar(
                                'Subject required', context);
                          } else if (_descriptionController.text.isEmpty) {
                            showCustomSnackBar(
                                'Description required', context);
                          } else {
                            SupportTicketBody supportTicketModel =
                                SupportTicketBody(
                                    widget.type,
                                    _subjectController.text,
                                    _descriptionController.text);
                            Provider.of<SupportTicketProvider>(context,
                                    listen: false)
                                .sendSupportTicket(
                                    supportTicketModel, callback, context);
                          }
                        }),
                  ),
          ]),
    );
  }

  void callback(bool isSuccess, String message) {
    print(message);
    if (isSuccess) {
      _subjectController.text = '';
      _descriptionController.text = '';
      Navigator.of(context).pop();
    } else {}
  }
}
