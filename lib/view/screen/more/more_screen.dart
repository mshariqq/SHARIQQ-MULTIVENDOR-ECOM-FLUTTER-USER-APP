import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/cart_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/localization_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/wishlist_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/chat/inbox_screen.dart';

import 'package:shariqq_multivendor_ecom_userapp/localization/language_constrants.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/auth_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/profile_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/splash_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/theme_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/color_resources.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/custom_themes.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/dimensions.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/images.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/animated_custom_dialog.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/guest_dialog.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/cart/cart_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/category/all_category_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/more/web_view_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/more/widget/app_info_dialog.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/more/widget/html_view_Screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/more/widget/sign_out_confirmation_dialog.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/notification/notification_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/offer/offers_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/order/order_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/profile/address_list_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/profile/profile_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/setting/settings_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/support/support_ticket_screen.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'faq_screen.dart';

class MoreScreen extends StatefulWidget {
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool isGuestMode;
  @override
  void initState() {
    isGuestMode =
        !Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if (!isGuestMode) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
      Provider.of<WishListProvider>(context, listen: false).initWishList(
        context,
        Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .countryCode,
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).highlightColor,
      body: Stack(
          children: [
        // Background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            // decoration: BoxDecoration(color: Theme.of(context).highlightColor),
            // Images.more_page_header,
            height: 50,
            // fit: BoxFit.fill,
            color: Theme.of(context).highlightColor
          ),
          // child: Image.asset(
          //   Images.more_page_header,
          //   height: 150,
          //   fit: BoxFit.fill,
          //   color: Provider.of<ThemeProvider>(context).darkTheme
          //       ? Colors.black
          //       : null,
          // ),
        ),

        // AppBar
        Positioned(
          height: 50,
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Consumer<ProfileProvider>(
            builder: (context, profile, child) {
              return Row(children: [
                InkWell(
                  onTap: () {
                    if (isGuestMode) {
                      showAnimatedDialog(context, GuestDialog(), isFlip: true);
                    } else {
                      if (Provider.of<ProfileProvider>(context, listen: false)
                          .userInfoModel !=
                          null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                      }
                    }
                  },
                  child: Row(children: [
                    isGuestMode
                        ? CircleAvatar(child: Icon(Icons.person, size: 35))
                        : profile.userInfoModel == null
                        ? CircleAvatar(child: Icon(Icons.person, size: 35))
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage.assetNetwork(
                        placeholder: Images.logo_image,
                        width: 35,
                        height: 35,
                        fit: BoxFit.fill,
                        image:
                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/${profile.userInfoModel.image}',
                        imageErrorBuilder: (c, o, s) => CircleAvatar(
                            child: Icon(Icons.person, size: 35)),
                      ),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Text(
                        !isGuestMode
                            ? profile.userInfoModel != null
                            ? '${profile.userInfoModel.fName} ${profile.userInfoModel.lName}'
                            : 'Full Name'
                            : 'Guest',
                        style: titilliumRegular.copyWith(
                            color: ColorResources.getPrimary(context), fontWeight: FontWeight.bold, fontSize: 21),),

                  ]),
                ),
                Expanded(child: SizedBox.shrink()),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.close, color: Colors.black, size: 32,))

              ]);
            },
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            color: ColorResources.getIconBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  // Top Row Items
                  Padding(padding: EdgeInsets.all(15), child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        SquareButton(
                          icon: Icons.shopping_cart,
                          title: "My Cart",
                          navigateTo: CartScreen(),
                          count:
                          Provider.of<CartProvider>(context, listen: false)
                              .cartList
                              .length,
                          hasCount: false,
                        ),
                        SquareButton(
                          icon: Icons.shopping_bag,
                          title: "My Orders",
                          navigateTo: OrderScreen(),
                          count: 1,
                          hasCount: false,
                        ),
                        SquareButton(
                          icon: Icons.find_in_page,
                          title: "Browse Categories",
                          navigateTo: AllCategoryScreen(),
                          count: 0,
                          hasCount: false,
                        ),

                      ]),),
                  Padding(padding: EdgeInsets.all(15), child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        SquareButton(
                          icon: Icons.favorite,
                          title: getTranslated('wishlist', context),
                          navigateTo: WishListScreen(),
                          count:
                          Provider.of<AuthProvider>(context, listen: false)
                              .isLoggedIn() &&
                              Provider.of<WishListProvider>(context,
                                  listen: false)
                                  .wishList !=
                                  null &&
                              Provider.of<WishListProvider>(context,
                                  listen: false)
                                  .wishList
                                  .length >
                                  0
                              ? Provider.of<WishListProvider>(context,
                              listen: false)
                              .wishList
                              .length
                              : 0,
                          hasCount: false,
                        ),
                        SquareButton(
                          icon: Icons.star,
                          title: getTranslated('offers', context),
                          navigateTo: OffersScreen(),
                          count: 0,
                          hasCount: false,
                        ),
                        SquareButton(

                          icon: Icons.home,
                          title: "My Addresses",
                          navigateTo: OffersScreen(),
                          count: 0,
                          hasCount: false,
                        ),


                      ]),),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                  getButton(Icons.notifications_active, "My Notifications", false, "0",  MaterialPageRoute(builder: (_) => NotificationScreen())),
                  getButton(Icons.inbox_rounded, "My Inbox", false, "0",  MaterialPageRoute(builder: (_) => InboxScreen())),
                  getButton(Icons.settings, "Settings", false, "0",  MaterialPageRoute(builder: (_) => SettingsScreen())),
                  getButton(
                    Icons.phone,
                    "Contact Us",
                    false,
                    "0",
                      MaterialPageRoute(builder: (_) => WebViewScreen(
                        title: getTranslated('contact_us', context),
                        url: Provider.of<SplashProvider>(context, listen: false)
                            .configModel
                            .staticUrls
                            .contactUs,
                      ))

                  ),
                  // getButton(Icons.account_box_rounded, "About Us", false, "0",  MaterialPageRoute(builder: (_) => OffersScreen())),
                  getButton(Icons.question_answer, "FAQ's", false, "0",  MaterialPageRoute(builder: (_) => FaqScreen(
                    title: getTranslated('faq', context),
                    // url: Provider.of<SplashProvider>(context, listen: false).configModel.staticUrls.faq,
                  ))),
                  getButton(Icons.label_important, "Terms, Conditions", false, "0",  MaterialPageRoute(builder: (_) => HtmlViewScreen(
                    title: getTranslated('terms_condition', context),
                    url: Provider.of<SplashProvider>(context, listen: false)
                        .configModel
                        .termsConditions,
                  ))),
                  getButton(Icons.pending_actions, "Policies", false, "0",  MaterialPageRoute(builder: (_) => HtmlViewScreen(
                    title: getTranslated('privacy_policy', context),
                    url: Provider.of<SplashProvider>(context, listen: false)
                        .configModel
                        .termsConditions,
                  ))),
                  getButton(Icons.help_outline, "Help Centre", false, "0",  MaterialPageRoute(builder: (_) => SupportTicketScreen())),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
                      onPressed: (){
                        showAnimatedDialog(
                            context, SignOutConfirmationDialog(),
                            isFlip: true);
                      },
                      child: Padding(padding: EdgeInsets.all(10),child: Row(children: [
                    Icon(Icons.logout, color: Colors.white,),
                    SizedBox(width: 30,),
                    Text("Logout", style: TextStyle(color: Colors.white),)
                  ],),)),
                  // Buttons
                  // TitleButton(
                  //     image: Images.fast_delivery,
                  //     title: "My Address",
                  //     navigateTo: AddressListScreen()),

                ]),
          ),
        ),
      ]),
    );
  }

  getButton(IconData icon, String text, bool count, String dcount, Route screen){
    return TextButton(

        onPressed: (){
      Navigator.push(context,
          screen);
    }, child: Padding(padding: EdgeInsets.only(left: 28, bottom: 10), child: Row(
      children: [
        Icon(icon, size: 28,color: Theme.of(context).primaryColor),
        SizedBox(width: 20,),
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Theme.of(context).primaryColor),)
      ],
    ),));
  }

}

class SquareButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget navigateTo;
  final int count;
  final bool hasCount;

  SquareButton(
      {
        @required this.icon,
      @required this.title,
      @required this.navigateTo,
      @required this.count,
      @required this.hasCount});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 100;
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigateTo)),
      child: Column(children: [
        Container(
          width: width / 4,
          height: width / 4,
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorResources.getPrimary(context),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: Colors.white,size: 21,),
              // Image.asset(image, color: Theme.of(context).highlightColor),
              hasCount
                  ? Positioned(
                      top: -4,
                      right: -4,
                      child: Consumer<CartProvider>(
                          builder: (context, cart, child) {
                        return CircleAvatar(
                          radius: 7,
                          backgroundColor: ColorResources.RED,
                          child: Text(count.toString(),
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.WHITE,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              )),
                        );
                      }),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(title, style: titilliumRegular),
        ),
      ]),
    );
  }
}

class TitleButton extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;
  TitleButton(
      {@required this.image, @required this.title, @required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(image,
          width: 25,
          height: 25,
          fit: BoxFit.fill,
          color: ColorResources.getPrimary(context)),
      title: Text(title,
          style:
              titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () => Navigator.push(
        context,
        /*PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(parent: animation, curve: Curves.bounceInOut);
              return ScaleTransition(scale: animation, child: child, alignment: Alignment.center);
            },
          ),*/
        MaterialPageRoute(builder: (_) => navigateTo),
      ),
      /*onTap: () => Navigator.push(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => navigateTo,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: Duration(milliseconds: 500),
      )),*/
    );
  }
}
