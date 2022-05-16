import 'package:flutter/material.dart';

import 'package:shariqq_multivendor_ecom_userapp/localization/language_constrants.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/splash_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/theme_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/color_resources.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/custom_themes.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/dimensions.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/images.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/custom_expanded_app_bar.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/animated_custom_dialog.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/setting/widget/currency_dialog.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return WillPopScope(
      onWillPop: () {
        Provider.of<SplashProvider>(context, listen: false)
            .setFromSetting(false);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Additional Settings"), backgroundColor: Theme.of(context).primaryColor,elevation: 0,),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(
                top: Dimensions.PADDING_SIZE_LARGE,
                left: Dimensions.PADDING_SIZE_LARGE),
            child: Text(getTranslated('settings', context),
                style: titilliumSemiBold.copyWith(
                    fontSize: Dimensions.FONT_SIZE_LARGE)),
          ),
          Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                children: [
                  SwitchListTile(
                    value: Provider.of<ThemeProvider>(context).darkTheme,
                    onChanged: (bool isActive) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(),
                    title: Text(getTranslated('dark_theme', context),
                        style: titilliumRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_LARGE)),
                  ),
                  TitleButton(
                    image: Icons.flag,
                    title: getTranslated('choose_language', context),
                    onTap: () => showAnimatedDialog(
                        context, CurrencyDialog(isCurrency: false)),
                  ),
                  TitleButton(
                    image: Icons.monetization_on_outlined,
                    title:
                    '${getTranslated('currency', context)} (${Provider.of<SplashProvider>(context).myCurrency.name})',
                    onTap: () => showAnimatedDialog(context, CurrencyDialog()),
                  ),
                  /*TitleButton(
                image: Images.preference,
                title: Strings.preference,
                onTap: () => showAnimatedDialog(context, PreferenceDialog()),
              ),*/
                ],
              )),
        ]),
      )
    );
  }
}

class TitleButton extends StatelessWidget {
  final IconData image;
  final String title;
  final Function onTap;
  TitleButton(
      {@required this.image, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(image),
      title: Text(title,
          style:
              titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap,
    );
  }
}
