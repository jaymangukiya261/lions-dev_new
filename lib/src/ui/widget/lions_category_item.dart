import 'package:flutter/material.dart';
import 'package:lions/src/common_methods.dart';
import 'package:lions/src/constants.dart';
import 'package:lions/src/ui/screens/authentication_page.dart';
import 'package:lions/src/ui/screens/cabinet_member_list.dart';
import 'package:lions/src/ui/screens/city_list.dart';
import 'package:lions/src/ui/screens/club_list.dart';
import 'package:lions/src/ui/screens/dg_team_member_list.dart';
import 'package:lions/src/ui/screens/district_list.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/screens/download_list.dart';
import 'package:lions/src/ui/screens/international_member_list.dart';
import 'package:lions/src/ui/screens/mjf_member_list.dart';
import 'package:lions/src/ui/screens/multiple_member_list.dart';
import 'package:lions/src/ui/screens/newsletter_list.dart';
import 'package:lions/src/ui/screens/past_governer_list.dart';
import 'package:lions/src/ui/screens/region_list.dart';
import 'package:lions/src/ui/screens/zone_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LionsCategoryItem extends StatefulWidget {
  LionsCategory category;

  LionsCategoryItem({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _LionsCategoruItemState createState() => _LionsCategoruItemState();
}

class _LionsCategoruItemState extends State<LionsCategoryItem> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    //final SharedPreferences prefs = await _prefs;
    //prefs.setBool("is_authenticated", true);
    _prefs.then((SharedPreferences prefs) {
      _isAuthenticated = prefs.getBool("is_authenticated") ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!_isAuthenticated) {
          CommonMethods.displayAlertToAuthenticate(
              context, Constants.ALERT_LOGIN);
          return;
        }
        var router = new MaterialPageRoute(builder: (BuildContext context) {
          if (widget.category.id == LionsCategory.CATEGORY_INTERNATIONAL) {
            return InternationalMemberList(category: widget.category);
          } else if (widget.category.id == LionsCategory.CATEGORY_MULTIPLE) {
            return MultipleMemberList(category: widget.category);
          } else if (widget.category.id == LionsCategory.CATEGORY_DISTRICTS) {
            return DistrictList(category: widget.category);
          } else if (widget.category.id == LionsCategory.CATEGORY_REGION) {
            return RegionList(category: widget.category);
          } else if (widget.category.id == LionsCategory.CATEGORY_ZONE) {
            return ZoneList(category: widget.category, regionId: 0);
          } else if (widget.category.id == LionsCategory.CATEGORY_CITY) {
            return CityList(category: widget.category);
          } else if (widget.category.id == LionsCategory.CATEGORY_CLUBS) {
            return ClubList(category: widget.category, regionId: 0, zoneId: 0);
          } else if (widget.category.id == LionsCategory.CATEGORY_CABINET) {
            return CabinetMemberList(category: widget.category);
          } else if (widget.category.id == LionsCategory.CATEGORY_DG_TEAM) {
            return DgTeamMemberList(category: widget.category);
          } else if (widget.category.id ==
              LionsCategory.CATEGORY_PAST_GOVERNERS) {
            return PastGovernerList(category: widget.category);
          } else if (widget.category.id == LionsCategory.CATEGORY_NEWSLETTER) {
            return NewsletterList(category: widget.category);
          } else if (widget.category.id == LionsCategory.CATEGORY_MJF_MEMBERS) {
            return MjfMemberList(category: widget.category);
          } else if (widget.category.id ==
              LionsCategory.CATEGORY_DOWNLOADABLE) {
            return DownloadList(
              category: widget.category,
            );
          }
          // else if (category.id == LionsCategory.CATEGORY_PROJECTS) {
          //   return ProjectsList(category: category);
          // }
          else {
            return MultipleMemberList(
              category: widget.category,
            );
          }
        });

        Navigator.of(context).push(router);
      },
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Icon(
              category.icon,
              size: 25,
              color: Colors.white,
            ),*/
            Image.asset(
              widget.category.icon,
              height: 60,
              width: 60,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.category.title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateToAuthenticate() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthenticationPage()));
  }
}
