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
import 'package:lions/src/models/zone_response.dart';
import 'package:lions/src/models/region_response.dart';
import 'package:lions/src/models/district_response.dart';
import 'package:lions/src/resources/user_api_provider.dart';

class Repository {
  final usersApiProvider = UserApiProvider();

  Future<AuthResponse> authenticate(String membershipNumber, String phone) =>
      usersApiProvider.authenticate(membershipNumber, phone);

  Future<DistrictResponse> fetchDistricts() =>
      usersApiProvider.fetchDistrictList();

  Future<RegionResponse> fetchRegions() => usersApiProvider.fetchRegionList();

  Future<ZoneResponse> fetchZones(int regionId) =>
      usersApiProvider.fetchZoneList(regionId);

  Future<CityResponse> fetchCities() => usersApiProvider.fetchCityList();

  Future<ClubResponse> fetchClubs(int regionId, int zoneId) =>
      usersApiProvider.fetchClubList(regionId, zoneId);

  Future<CabinetResponse> fetchCabinetMembers() =>
      usersApiProvider.fetchCabinetMembers();

  Future<DgTeamResponse> fetchDgTeamMembers() =>
      usersApiProvider.fetchDgTeamMembers();

  Future<GovernerResponse> fetchPastGoverners() =>
      usersApiProvider.fetchPastGovernerList();

  Future<ProjectResponse> fetchProjects() => usersApiProvider.fetchProjects();

  Future<AdvertisementResponse> fetchAdvertisements() =>
      usersApiProvider.fetchAdvertisements();

  Future<NewsletterResponse> fetchNewsletters() =>
      usersApiProvider.fetchNewsletters();

  Future<MemberResponse> fetchInternationalMembers() =>
      usersApiProvider.fetchInternationalMembers();

  Future<MemberResponse> fetchMultipleMembers() =>
      usersApiProvider.fetchMultipleMembers();

  Future<MjfMemberResponse> fetchMjfMembers() =>
      usersApiProvider.fetchMjfMembers();

  Future<SearchResponse> search(String searchTerm) =>
      usersApiProvider.search(searchTerm);

  Future<DownloadResponse> fetchDownloadable() =>
      usersApiProvider.fetchDownloadable();

  Future<Popup> fetchPopup() => usersApiProvider.fetchPopup();

  Future<AlertResponse> fetchNotifications() =>
      usersApiProvider.fetchNotifications();
}
