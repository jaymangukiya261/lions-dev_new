import 'package:flutter/material.dart';
import 'package:lions/src/blocs/projects_bloc.dart';
import 'package:lions/src/models/project_response.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/project_list_item.dart';

class ProjectsList extends StatelessWidget {
  LionsCategory category;

  ProjectsList({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllProjeccts();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: StreamBuilder(
          stream: bloc.allProjeccts,
          builder: (context, AsyncSnapshot<ProjectResponse> snapshot) {
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

  Widget buildList(AsyncSnapshot<ProjectResponse> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.results.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return ProjectListItem(
            project: snapshot.data.results[index],
          );
        });
  }
}
