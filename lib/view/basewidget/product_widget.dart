import 'package:flutter/material.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/model/response/product_model.dart';
import 'package:shariqq_multivendor_ecom_userapp/helper/price_converter.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/splash_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/theme_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/color_resources.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/custom_themes.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/dimensions.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/images.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final Product productModel;
  ProductWidget({@required this.productModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) =>
                  ProductDetails(product: productModel),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).highlightColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Container(
              height: 140,
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
              decoration: BoxDecoration(
                color: ColorResources.getIconBg(context),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                fit: BoxFit.cover,
                image:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}/${productModel.thumbnail}',
                imageErrorBuilder: (c, o, s) =>
                    Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Container(
                height: 66,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(productModel.name ?? '',
                        style: robotoRegular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Row(children: [
                      Text(
                        PriceConverter.convertPrice(
                            context, productModel.unitPrice ?? 0.0,
                            discountType: productModel.discountType,
                            discount: productModel.discount),
                        style: robotoBold.copyWith(
                            color: ColorResources.getPrimary(context)),
                      ),
                      Expanded(child: SizedBox.shrink()),
                      Text(
                          productModel.rating != null
                              ? productModel.rating.length != 0
                                  ? double.parse(productModel.rating[0].average)
                                      .toStringAsFixed(1)
                                  : '0.0'
                              : '0.0',
                          style: robotoRegular.copyWith(
                            color: Provider.of<ThemeProvider>(context).darkTheme
                                ? Colors.white
                                : Colors.orange,
                            fontSize: Dimensions.FONT_SIZE_SMALL,
                          )),
                      Icon(Icons.star,
                          color: Provider.of<ThemeProvider>(context).darkTheme
                              ? Colors.white
                              : Colors.orange,
                          size: 15),
                    ]),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    productModel.discount > 0 && productModel.discount != null
                        ? Text(
                            PriceConverter.convertPrice(
                                context, productModel.unitPrice),
                            style: robotoBold.copyWith(
                              color: Theme.of(context).hintColor,
                              decoration: TextDecoration.lineThrough,
                              fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ]),

          // Off

          productModel.discount >= 1
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                      color: ColorResources.getPrimary(context),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        PriceConverter.percentageCalculation(
                            context,
                            productModel.unitPrice,
                            productModel.discount,
                            productModel.discountType),
                        style: robotoRegular.copyWith(
                            color: Theme.of(context).highlightColor,
                            fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ]),
      ),
    );
  }
}
