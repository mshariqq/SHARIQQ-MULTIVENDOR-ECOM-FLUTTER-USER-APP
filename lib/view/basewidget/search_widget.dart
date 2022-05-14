import 'package:flutter/material.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/search_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/provider/theme_provider.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/color_resources.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/custom_themes.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/dimensions.dart';
import 'package:shariqq_multivendor_ecom_userapp/utill/images.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final Function onTextChanged;
  final Function onClearPressed;
  final Function onSubmit;
  SearchWidget(
      {@required this.hintText,
      this.onTextChanged,
      @required this.onClearPressed,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController(
        text: Provider.of<SearchProvider>(context).searchText);
    return Stack(
        children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Container(color: Colors.white,),
      ),
      Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
        height: 80,
        alignment: Alignment.center,
        child: Row(children: [
          // IconButton(
          //   icon: Icon(Icons.arrow_back_ios, size: 20, color: Theme.of(context).primaryColor),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8.0)),
              child: TextFormField(
                controller: _controller,
                onFieldSubmitted: (query) {
                  onSubmit(query);
                },
                onChanged: (query) {
                  onTextChanged(query);
                },
                textInputAction: TextInputAction.search,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: hintText,
                  isDense: true,
                  hintStyle: robotoRegular.copyWith(
                      color: Theme.of(context).primaryColor),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,
                      color: Colors.black,
                      size: Dimensions.ICON_SIZE_DEFAULT),
                  suffixIcon: Provider.of<SearchProvider>(context)
                          .searchText
                          .isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear,
                              color: ColorResources.getChatIcon(context)),
                          onPressed: () {
                            onClearPressed();
                            _controller.clear();
                          },
                        )
                      : _controller.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(Icons.clear,
                                  color: ColorResources.getChatIcon(context)),
                              onPressed: () {
                                onClearPressed();
                                _controller.clear();
                              },
                            )
                          : null,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ]),
      ),
    ]);
  }
}
