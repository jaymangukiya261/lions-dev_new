class LionsCategory {
  static const int CATEGORY_INTERNATIONAL = 0;
  static const int CATEGORY_MULTIPLE = 1;
  static const int CATEGORY_DISTRICTS = 2;
  static const int CATEGORY_REGION = 3;
  static const int CATEGORY_ZONE = 4;
  static const int CATEGORY_CLUBS = 5;
  static const int CATEGORY_DG_TEAM = 6;
  static const int CATEGORY_PAST_GOVERNERS = 7;
  static const int CATEGORY_CABINET = 8;
  static const int CATEGORY_CITY = 9;
  static const int CATEGORY_MJF_MEMBERS = 10;
  static const int CATEGORY_NEWSLETTER = 11;
  //static const int CATEGORY_PROJECTS = 12;
  static const int CATEGORY_DOWNLOADABLE = 13;

  const LionsCategory({this.id, this.title, this.icon});
  final int id;
  final String title;
  final String icon;
}
