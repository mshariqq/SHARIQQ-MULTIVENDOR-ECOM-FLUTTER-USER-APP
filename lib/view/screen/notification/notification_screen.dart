import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shariqq_multivendor_ecom_userapp/helper/date_converter.dart';

import 'package:shariqq_multivendor_ecom_userapp/localization/language_constrants.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/notification_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/splash_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/color_resources.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/custom_themes.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/dimensions.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/images.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/custom_app_bar.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/no_internet_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/notification/widget/notification_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  final bool isBacButtonExist;
  NotificationScreen({this.isBacButtonExist = true});

  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: false)
        .initNotificationList(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(children: [
        // CustomAppBar(
        //     title: getTranslated('notification', context),
        //     isBackButtonExist: isBacButtonExist),
        Expanded(
          child: Consumer<NotificationProvider>(
            builder: (context, notification, child) {
              return notification.notificationList != null
                  ? notification.notificationList.length != 0
                      ? RefreshIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                          onRefresh: () async {
                            await Provider.of<NotificationProvider>(context,
                                    listen: false)
                                .initNotificationList(context);
                          },
                          child: ListView.builder(
                            itemCount:
                                Provider.of<NotificationProvider>(context)
                                    .notificationList
                                    .length,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => showDialog(
                                    context: context,
                                    builder: (context) => NotificationDialog(
                                        notificationModel: notification
                                            .notificationList[index])),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.PADDING_SIZE_SMALL),
                                  color: ColorResources.getGrey(context),
                                  child: ListTile(
                                    leading: ClipOval(
                                        child: FadeInImage.assetNetwork(
                                      placeholder: Images.placeholder,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      image:
                                          '${Provider.of<SplashProvider>(context, listen: false).baseUrls.notificationImageUrl}/${notification.notificationList[index].image}',
                                      imageErrorBuilder: (c, o, s) =>
                                          Image.asset(Images.placeholder,
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover),
                                    )),
                                    title: Text(
                                        notification
                                            .notificationList[index].title,
                                        style: titilliumRegular.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL,
                                        )),
                                    subtitle: Text(
                                      DateFormat('hh:mm  dd/MM/yyyy').format(
                                          DateConverter.isoStringToLocalDate(
                                              notification
                                                  .notificationList[index]
                                                  .createdAt)),
                                      style: titilliumRegular.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL,
                                          color:
                                              ColorResources.getHint(context)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : NoInternetOrDataScreen(isNoInternet: false)
                  : NotificationShimmer();
            },
          ),
        ),
      ]),
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:
                Provider.of<NotificationProvider>(context).notificationList ==
                    null,
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.WHITE),
              subtitle:
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
            ),
          ),
        );
      },
    );
  }
}
