import 'package:flutter/material.dart';
import 'package:lions/src/blocs/search_bloc.dart';
import 'package:lions/src/models/search_response.dart';
import 'package:lions/src/ui/widget/search_result_list_item.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white70,
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
                style: TextStyle(color: Colors.black87),
                onSubmitted: (String value) {
                  setState(() {
                    _searchTerm = value;
                  });
                  bloc.fetchAllSearchResults(value);
                },
                //keyboardType: TextInputType.number,
              ),
            ),
            StreamBuilder(
              stream: bloc.allSearchResults,
              builder: (context, AsyncSnapshot<SearchResponse> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    if (_searchTerm.isEmpty) {
                      return Container();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                        //child: Text('Loading...'),
                      );
                    }
                    break;
                  default:
                    if (snapshot.data.results.isEmpty) {
                      if (_searchTerm.isEmpty) {
                        return Center(
                          child: Text('You haven\'t searched any term yet.'),
                        );
                      } else {
                        return Center(
                          child: Text('No matching term found.'),
                        );
                      }
                    } else {
                      return buildList(snapshot);
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
    //throw UnimplementedError();
  }

  Widget buildList(AsyncSnapshot<SearchResponse> snapshot) {
    return Expanded(
      child: ListView.builder(
        itemCount: snapshot.data.results.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return SearchResultListItem(
            value: snapshot.data.results[index],
          );
        },
      ),
    );
  }
}
