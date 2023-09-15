import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noteapp_php/app/notes/edit.dart';
import 'package:noteapp_php/components/card_notes.dart';
import 'package:noteapp_php/constant/linkapi.dart';
import 'package:noteapp_php/model/notes_model.dart';

import '../components/crud.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Crud {
  getNotes() async {
    var response = await postRequest(linkViewNotes, {
      "id": sharedPref.getString("id"),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Home Screen"),
          actions: [
            IconButton(
                onPressed: () {
                  sharedPref.clear();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("addnotes");
          },
          child: Icon(
            Icons.add,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: [
              FutureBuilder(
                  future: getNotes(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data['status'] == 'fail')
                        return const Text("No Exist Notes!");
                      return ListView.builder(
                        // itemCount: snapshot.data['data'].length,
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          // return Text(
                          //     "${snapshot.data['data'][i]['notes_title']}");
                          return CardNotes(
                              onDelete: () async {
                                var response =
                                    await postRequest(linkDeleteNotes, {
                                  "id": snapshot.data['data'][i]['notes_id']
                                      .toString(),
                                  "imagename": snapshot.data['data'][i]
                                          ['notes_image']
                                      .toString()
                                });
                                if (response['status'] == "success") {
                                  Navigator.of(context)
                                      .pushReplacementNamed("home");
                                }
                              },
                              ontap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNotes(
                                        notes: snapshot.data['data'][i])));
                              },
                              notesModel: NotesModel.fromJson(
                                  snapshot.data['data'][i]));
                        },
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  })
            ],
          ),
        ));
  }
}
