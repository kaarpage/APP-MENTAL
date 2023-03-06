import 'package:app_mental/Services/questionnaireService.dart';
import 'package:app_mental/escalas/promis_answer.dart';
import 'package:app_mental/escalas/question.dart';
import 'package:flutter/material.dart';

class Promisn1 extends StatelessWidget {
  final int sizeQuestionnaire;
  final String question;
  final List<Map<String, Object>> answers;
  final int questionIndex;
  final Function answerQuestion;
  final Function resetLastDomain;
  final String userEmail;

  Promisn1(
      {required this.answers,
      required this.sizeQuestionnaire,
      required this.question,
      required this.answerQuestion,
      required this.questionIndex,
      required this.resetLastDomain,
      required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(244, 244, 244, 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Questão $questionIndex de $sizeQuestionnaire",
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Question(question),
          ...(answers[questionIndex]['answers'] as List<Map<String, dynamic>>)
              .map((answer) {
            return AnswerOption(
              () => answerQuestion(
                  answer['score'], answer['dom'], answer['text']),
              answer['text']!,
            );
          }).toList(),
          Spacer(),
          Container(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    resetLastDomain();
                  },
                  child: const Text("Responder de novo este domínio"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(104, 202, 138, 1)),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Responder depois'),
                      content: const Text(
                          'Deseja salvar suas respostas e terminar de responder mais tarde?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            QuestionnaireService()
                                .discardAllAnswers(userEmail, "promisN1_week1")
                                .then((_) {
                              Navigator.of(context).popUntil(
                                  ModalRoute.withName('/logged-home'));
                              Navigator.of(context).pushNamed("/quests-screen");
                            });
                          },
                          child: const Text('Descartar'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/logged-home'));
                            Navigator.of(context).pushNamed("/quests-screen");
                          },
                          child: const Text('Salvar'),
                        ),
                      ],
                    ),
                  ),
                  child: const Text('Responder depois',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
