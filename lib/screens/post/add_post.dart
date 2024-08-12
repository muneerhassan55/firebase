import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorial/components/round_button.dart';
import 'package:firebase_tutorial/components/ui_helper.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  final databaseref = FirebaseDatabase.instance.ref('Data');
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                  hintText: 'What is o  your mind',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: 'ADD',
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  databaseref.child(id).set({
                    'title': postController.text.toString(),
                    'id': id
                  }).then((value) {
                    UiHelper.CustomAlertBox(context, 'Post Added');
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, StackTrace) {
                    UiHelper.CustomAlertBox(context, error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
