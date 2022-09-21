import 'package:lions/src/models/advertisement_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class AdvertisementBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<AdvertisementResponse>();

  Observable<AdvertisementResponse> get allAdvertisements => _fetcher.stream;

  fetchAllAdvertisements() async {
    AdvertisementResponse response = await _repository.fetchAdvertisements();
    _fetcher.sink.add(response);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = AdvertisementBloc();
