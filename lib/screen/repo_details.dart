import 'package:flutter/material.dart';
import 'package:testinilab/model/home_model.dart';
import 'package:testinilab/model/repo_model.dart';

class RepoDetailsScreen extends StatefulWidget {
  const RepoDetailsScreen({Key? key, required this.repoModel, required this.avaterUrl, required this.name, required this.login}) : super(key: key);
  final RepoModel repoModel;
  final String avaterUrl;
  final String name;
  final String login;
  @override
  State<RepoDetailsScreen> createState() => _RepoDetailsScreenState();
}

class _RepoDetailsScreenState extends State<RepoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "${widget.repoModel.owner.avatarUrl}",
                  ),
                  radius: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('${widget.repoModel.owner.login}',style: TextStyle(fontSize: 16),)
              ],
            ),
            SizedBox(height: 20,),
            Text('${widget.repoModel.name}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.star_outline),
                    SizedBox(width: 5,),
                    Text('${widget.repoModel.stargazersCount} stars'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.push_pin_outlined),
                    SizedBox(width: 5,),
                    Text('${widget.repoModel.forks} forks'),
                  ],
                ),

              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green
                      ),
                      child: Icon(Icons.arrow_circle_up,color: Colors.white,),
                    ),
                    SizedBox(width: 10,),
                    Text("Issues"),
                  ],
                ),
                Text("${widget.repoModel.openIssuesCount}")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent
                      ),
                      child: Icon(Icons.line_axis,color: Colors.white,),
                    ),
                    SizedBox(width: 10,),
                    Text("Pull Requests"),
                  ],
                ),
                Text("${widget.repoModel.openIssuesCount}")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange
                      ),
                      child: Icon(Icons.people,color: Colors.white,),
                    ),
                    SizedBox(width: 10,),
                    Text("Contributors"),
                  ],
                ),
                Text("${widget.repoModel.stargazersCount}")
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow
                      ),
                      child: Icon(Icons.visibility,color: Colors.white,),
                    ),
                    SizedBox(width: 10,),
                    Text("Watchers"),
                  ],
                ),
                Text("${widget.repoModel.watchersCount}",),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
