import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shariqq_multivendor_ecom_userapp/data/model/response/category.dart';

import 'package:shariqq_multivendor_ecom_userapp/localization/language_constrants.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/category_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/splash_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/theme_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/color_resources.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/custom_themes.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/dimensions.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/images.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/basewidget/custom_app_bar.dart';
import 'package:shariqq_multivendor_ecom_userapp/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';

class AllCategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body: Column(
        children: [
          CustomAppBar(title: getTranslated('CATEGORY', context)),
          Expanded(child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return categoryProvider.categoryList.length != 0
                  ? Padding(padding: EdgeInsets.all(10), child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Text("Categories", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 100,
                      // width: 400,
                      child: Scrollbar(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryProvider.categoryList.length,
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            Category _category =
                            categoryProvider.categoryList[index];
                            return InkWell(
                              onTap: () {
                                Provider.of<CategoryProvider>(context,
                                    listen: false)
                                    .changeSelectedIndex(index);
                              },
                              child: CategoryItem(
                                title: _category.name,
                                icon: _category.icon,
                                isSelected:
                                categoryProvider.categorySelectedIndex ==
                                    index,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text("Sub Categories", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                            itemCount: categoryProvider
                                .categoryList[
                            categoryProvider.categorySelectedIndex]
                                .subCategories
                                .length +
                                1,
                            itemBuilder: (context, index) {
                              SubCategory _subCategory;
                              if (index != 0) {
                                _subCategory = categoryProvider
                                    .categoryList[
                                categoryProvider.categorySelectedIndex]
                                    .subCategories[index - 1];
                              }
                              if (index == 0) {
                                return Ink(
                                  // color: Theme.of(context).highlightColor,
                                  child: ListTile(
                                    title: Text('Show All',
                                        style: titilliumSemiBold,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    trailing: Icon(Icons.navigate_next),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BrandAndCategoryProductScreen(
                                                    isBrand: false,
                                                    id: categoryProvider
                                                        .categoryList[categoryProvider
                                                        .categorySelectedIndex]
                                                        .id
                                                        .toString(),
                                                    name: categoryProvider
                                                        .categoryList[categoryProvider
                                                        .categorySelectedIndex]
                                                        .name,
                                                  )));
                                    },
                                  ),
                                );
                              } else if (_subCategory.subSubCategories.length !=
                                  0) {
                                return Ink(
                                  // color: Theme.of(context).highlightColor,
                                  child: Theme(
                                    data: Provider.of<ThemeProvider>(context)
                                        .darkTheme
                                        ? ThemeData.dark()
                                        : ThemeData.light(),
                                    child: ExpansionTile(
                                      key: Key(
                                          '${Provider.of<CategoryProvider>(context).categorySelectedIndex}$index'),
                                      title: Text(_subCategory.name,
                                          style: titilliumSemiBold.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  .color),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                      children: _getSubSubCategories(
                                          context, _subCategory),
                                    ),
                                  ),
                                );
                              } else {
                                return Ink(
                                  // color: Theme.of(context).highlightColor,
                                  child: ListTile(
                                    title: Text(_subCategory.name,
                                        style: titilliumSemiBold,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    trailing: Icon(Icons.navigate_next,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BrandAndCategoryProductScreen(
                                                    isBrand: false,
                                                    id: _subCategory.id.toString(),
                                                    name: _subCategory.name,
                                                  )));
                                    },
                                  ),
                                );
                              }
                            },
                          )
                      ),

                  ]),)
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor)));
            },
          )),
        ],
      ),
    );
  }

  List<Widget> _getSubSubCategories(
      BuildContext context, SubCategory subCategory) {
    List<Widget> _subSubCategories = [];
    _subSubCategories.add(Container(
      color: Colors.white,
      margin:
          EdgeInsets.symmetric(horizontal: 0),
      child: ListTile(
        title: Row(
          children: [
            Icon(Icons.arrow_right),
            SizedBox(width: 10,),
            Flexible(
                child: Text(
              getTranslated('all', context),
              style: titilliumSemiBold.copyWith(
                  color: Theme.of(context).textTheme.bodyText1.color),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BrandAndCategoryProductScreen(
                        isBrand: false,
                        id: subCategory.id.toString(),
                        name: subCategory.name,
                      )));
        },
      ),
    ));
    for (int index = 0; index < subCategory.subSubCategories.length; index++) {
      _subSubCategories.add(Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        child: ListTile(
          title: Row(
            children: [
              Icon(Icons.arrow_right),
              SizedBox(width: 10,),
              Flexible(
                  child: Text(
                subCategory.subSubCategories[index].name,
                style: titilliumSemiBold.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BrandAndCategoryProductScreen(
                          isBrand: false,
                          id: subCategory.subSubCategories[index].id.toString(),
                          name: subCategory.subSubCategories[index].name,
                        )));
          },
        ),
      ));
    }
    return _subSubCategories;
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  final bool isSelected;
  CategoryItem(
      {@required this.title, @required this.icon, @required this.isSelected});

  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelected ? Theme.of(context).primaryColor : null,
      ),
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: isSelected
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                fit: BoxFit.cover,
                image:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/$icon',
                imageErrorBuilder: (c, o, s) =>
                    Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  color: isSelected
                      ? Theme.of(context).highlightColor
                      : Theme.of(context).primaryColor,
                )),
          ),
        ]),
      ),
    );
  }
}
