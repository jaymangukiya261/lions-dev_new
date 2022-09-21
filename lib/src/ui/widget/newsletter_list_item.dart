import 'package:flutter/material.dart';
import 'package:lions/src/models/newsletter.dart';

class NewsletterListItem extends StatelessWidget {
  Newsletter newsletter;

  NewsletterListItem({Key key, @required this.newsletter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
          child: Card(
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(newsletter.image),
                    Text(newsletter.name),
                    Text(newsletter.description ?? ''),
                  ],
                )),
          )),
    );
  }
}
