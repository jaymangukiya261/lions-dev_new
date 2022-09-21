import 'package:flutter/material.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color primary;
  final Color mainTextColor;

  final bool autoSelected;

  final double searchFontSize;

  final String searchHint;

  final AppBarController appBarController;

  final Function(String search) onChange;
  final Function() onTap;

  final AppBar mainAppBar;

  SearchAppBar(
      {@required this.primary,
      @required this.appBarController,
      @required this.onChange,
      @required this.onTap,
      @required this.mainAppBar,
      this.autoSelected = false,
      this.mainTextColor = Colors.white,
      this.searchFontSize = 20,
      this.searchHint = "Search..."});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: appBarController.stream.stream,
        builder: (BuildContext context, AsyncSnapshot<bool> snap) {
          bool _show = autoSelected;

          if (snap.hasData) {
            _show = snap.data;
          }

          if (_show) {
            return searchAppBar(
              context: context,
            );
          } else {
            return showMainAppBar();
          }
        });
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(60.0);
  }

  Widget showMainAppBar() {
    return mainAppBar;
  }

  Widget searchAppBar({@required BuildContext context}) {
    return AppBar(
      leading: InkWell(
        child: Icon(
          Icons.close,
          color: mainTextColor,
        ),
        onTap: () {
          appBarController.stream.add(false);
          onTap();
        },
      ),
      backgroundColor: primary,
      title: Container(
        child: TextField(
          autofocus: true,
          onChanged: (String value) {
            onChange(value);
          },
          style: TextStyle(fontSize: searchFontSize, color: mainTextColor),
          cursorColor: mainTextColor,
          decoration: InputDecoration(
              hintText: searchHint,
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: mainTextColor.withAlpha(100),
              ),
              suffixIcon: Icon(
                Icons.search,
                color: mainTextColor.withAlpha(100),
              )),
        ),
      ),
    );
  }
}
