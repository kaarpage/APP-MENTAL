import 'package:app_mental/Screens/Reading/Widgets/body.dart';
import 'package:flutter/material.dart';
import 'package:app_mental/constants.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:app_mental/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReadingScreen extends StatelessWidget {
  ReadingScreen(this.title, this.file, this.image, this.id);

  final String file;
  final String title;
  final String image;
  final String id;
  final DatabaseMethods databaseMethods = new DatabaseMethods();

  void _showRatingDialog(context, String dialogTitle, String id) {
    final _dialog = RatingDialog(
      // your app's name?
      title: 'Avalie este conteúdo!',
      // encourage your user to leave a high rating?
      message:
          'Clique em uma estrela para avaliar, e adicione um comentário se quiser!',
      // your app's logo?
      image: const FlutterLogo(size: 100),
      submitButton: 'Enviar',
      onCancelled: () => print('cancelled'),

      onSubmitted: (response) {
        print(
            'rating: ${response.rating}, comment: ${response.comment}, id: $id, email: ${FirebaseAuth.instance.currentUser!.email}');
        Map<String, dynamic> ratingMap = {
          "readingsId": id,
          "rating": response.rating,
          "comment": response.comment,
        };
        databaseMethods.rateReading(
            id, ratingMap, FirebaseAuth.instance.currentUser!.email);
      },
      commentHint: 'Nos conte o que achou!',
    );

    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        backgroundColor: kTextColorGreen,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Text(title),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              primary: Colors.white,
            ),
            onPressed: () {
              _showRatingDialog(context, title, id);
            },
            child: Text("Avaliar"),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Body(file, image),
    );
  }
}
