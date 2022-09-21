import 'package:lions/src/models/newsletter_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class NewsletterBloc {
  final _repository = Repository();
  final _zoneFetcher = PublishSubject<NewsletterResponse>();

  Observable<NewsletterResponse> get allNewsletters => _zoneFetcher.stream;

  fetchAllNewsletters() async {
    NewsletterResponse regionResponse = await _repository.fetchNewsletters();
    _zoneFetcher.sink.add(regionResponse);
  }

  dispose() {
    _zoneFetcher.close();
  }
}

final bloc = NewsletterBloc();
