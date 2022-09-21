import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class Utils {
  static Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static String formatDate(String strDate, String format) {
    if (strDate == null || strDate.isEmpty) {
      return '';
    }
    DateFormat formatter = DateFormat(format);
    DateTime date = DateTime.parse(strDate);
    return formatter.format(date);
  }
}
