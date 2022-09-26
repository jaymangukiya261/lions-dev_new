import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:lions/src/models/advertisement_response.dart';
import 'package:lions/src/models/alert_response.dart';
import 'package:lions/src/models/auth_response.dart';
import 'package:lions/src/models/cabinet_response.dart';
import 'package:lions/src/models/city_response.dart';
import 'package:lions/src/models/club_response.dart';
import 'package:lions/src/models/dg_team_response.dart';
import 'package:lions/src/models/dowonload_response.dart';
import 'package:lions/src/models/governer_response.dart';
import 'package:lions/src/models/member_response.dart';
import 'package:lions/src/models/mjf_member_response.dart';
import 'package:lions/src/models/newsletter_response.dart';
import 'package:lions/src/models/popup.dart';
import 'package:lions/src/models/project_response.dart';
import 'package:lions/src/models/search_response.dart';
import 'dart:convert';

import 'package:lions/src/models/user_response.dart';
import 'package:lions/src/models/district_response.dart';
import 'package:lions/src/models/region_response.dart';
import 'package:lions/src/models/zone_response.dart';
import 'package:lions/src/resources/logging_interceptor.dart';

class UserApiProvider {
  //static const String BASE_URL = "http://lc.doonitrix.com/api/";
  //static const String IMAGE_BASE_URL = "http://lc.doonitrix.com";

  static const String BASE_URL = "https://app.lions321a2.com/api/";
  static const String IMAGE_BASE_URL = "https://app.lions321a2.com";

  //Client client = Client();
  Client client = HttpClientWithInterceptor.build(interceptors: [
    LoggingInterceptor(),
  ]);

  Future<AuthResponse> authenticate(
      String membershipNumber, String phone) async {
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      //"Content-type": "application/json"
    };

    var params = new Map<String, dynamic>();
    params['membership_number'] = membershipNumber;
    params['number'] = phone;
    final response = await client.post(Uri.parse(BASE_URL + "authenticate"),
        headers: headers, body: params);

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to authenticate.');
    }
  }

  Future<DistrictResponse> fetchDistrictList() async {
    final response = await client.get(Uri.parse(BASE_URL + "getDistricts"));
    if (response.statusCode == 200) {
      return DistrictResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load districts');
    }
  }

  Future<RegionResponse> fetchRegionList() async {
    try {
      final response = await client.get(Uri.parse(BASE_URL + "getRegions"));
      if (response.statusCode == 200) {
        return RegionResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load regions');
      }
    } catch (e, t) {
      print('Failed to load regions $e');
      print('Failed to load regions $t');
    }
  }

  Future<ZoneResponse> fetchZoneList(int regionId) async {
    try {
      final response =
          await client.get(Uri.parse(BASE_URL + "getZones/$regionId"));
      if (response.statusCode == 200) {
        return ZoneResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load zones ${response.statusCode}');
      }
    } catch (e, t) {
      print('Failed to load zones$e');
      print('Failed to load zones$t');
    }
  }

  Future<CityResponse> fetchCityList() async {
    final response = await client.get(Uri.parse(BASE_URL + "getCities"));
    if (response.statusCode == 200) {
      return CityResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<ClubResponse> fetchClubList(int regionId, int zoneId) async {
    print('Hello clubs 11 $regionId');
    print('Hello clubs 22 $zoneId');
    try {
      final response =
          await client.get(Uri.parse(BASE_URL + "getClubs/$regionId/$zoneId"));
      if (response.statusCode == 200) {
        return ClubResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load clubs ${response.statusCode}');
      }
    } catch (e, t) {
      print('Failed to load clubs $e');
      print('Failed to load clubs $t');
    }
  }

  Future<CabinetResponse> fetchCabinetMembers() async {
    final response =
        await client.get(Uri.parse(BASE_URL + "getCabinetMembers"));
    if (response.statusCode == 200) {
      return CabinetResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Cabinet');
    }
  }

  Future<DgTeamResponse> fetchDgTeamMembers() async {
    final response = await client.get(Uri.parse(BASE_URL + "getDgTeamMembers"));
    if (response.statusCode == 200) {
      return DgTeamResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load DG teams');
    }
  }

  Future<GovernerResponse> fetchPastGovernerList() async {
    final response = await client.get(Uri.parse(BASE_URL + "getPastGoverners"));
    if (response.statusCode == 200) {
      return GovernerResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load past governers');
    }
  }

  Future<ProjectResponse> fetchProjects() async {
    final response = await client.get(Uri.parse(BASE_URL + "getProjects"));
    if (response.statusCode == 200) {
      return ProjectResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load projects');
    }
  }

  Future<AdvertisementResponse> fetchAdvertisements() async {
    final response =
        await client.get(Uri.parse(BASE_URL + "getAdvertisements"));
    if (response.statusCode == 200) {
      return AdvertisementResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load advertisements');
    }
  }

  Future<NewsletterResponse> fetchNewsletters() async {
    final response = await client.get(Uri.parse(BASE_URL + "getNewsletter"));
    if (response.statusCode == 200) {
      return NewsletterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load newsletters');
    }
  }

  Future<MemberResponse> fetchInternationalMembers() async {
    final response = await client.get(Uri.parse(BASE_URL + "getinternational"));
    if (response.statusCode == 200) {
      return MemberResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load international members');
    }
  }

  Future<MemberResponse> fetchMultipleMembers() async {
    final response = await client.get(Uri.parse(BASE_URL + "getmultiple"));
    if (response.statusCode == 200) {
      return MemberResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load multiple members');
    }
  }

  Future<MjfMemberResponse> fetchMjfMembers() async {
    final response = await client.get(Uri.parse(BASE_URL + "getMjfMember"));
    if (response.statusCode == 200) {
      return MjfMemberResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load international members');
    }
  }

  Future<SearchResponse> search(String searchTerm) async {
    final response =
        await client.get(Uri.parse(BASE_URL + "search/$searchTerm"));
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load international members');
    }
  }

  Future<DownloadResponse> fetchDownloadable() async {
    final response = await client.get(Uri.parse(BASE_URL + "getDownloads"));
    if (response.statusCode == 200) {
      return DownloadResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load downloads');
    }
  }

  Future<Popup> fetchPopup() async {
    final response = await client.get(Uri.parse(BASE_URL + "getPopup"));
    if (response.statusCode == 200) {
      return Popup.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load popup');
    }
  }

  Future<AlertResponse> fetchNotifications() async {
    final response = await client.get(Uri.parse(BASE_URL + "getNotification"));
    if (response.statusCode == 200) {
      return AlertResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load popup');
    }
  }
}
