import 'package:flutter/material.dart';
import 'package:lions/src/blocs/newsletter_bloc.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/models/newsletter_response.dart';
import 'package:lions/src/ui/widget/newsletter_list_item.dart';

class NewsletterList extends StatelessWidget {
  LionsCategory category;

  NewsletterList({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllNewsletters();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: StreamBuilder(
          stream: bloc.allNewsletters,
          builder: (context, AsyncSnapshot<NewsletterResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.results.isEmpty) {
                return Center(
                  child: Text("No Items Available"),
                );
              } else {
                return buildList(snapshot);
              }
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
    //throw UnimplementedError();
  }

  Widget buildList(AsyncSnapshot<NewsletterResponse> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.results.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return NewsletterListItem(
            newsletter: snapshot.data.results[index],
          );
        });
  }
}
