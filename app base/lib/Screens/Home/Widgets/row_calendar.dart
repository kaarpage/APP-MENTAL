import 'package:chat_app_tutorial/constants.dart';
import 'package:flutter/material.dart';

class RowCalendar extends StatelessWidget {
  const RowCalendar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
        children: <Widget>[
          DayCard(
              day: 01,
              month: "Julho",
              press: () {
                /*Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsScreen())); */
              }),

        ],
      );
  }
}

class DayCard extends StatelessWidget {
  const DayCard({
    Key key,
    this.press,
    this.day,
    this.month,
  }) : super(key: key);
  final int day;
  final String month;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5,
        ),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: press,
              child: Container(
                width: 200,
                height: 100,
                //padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 4),
                decoration: BoxDecoration(
                    color: kPrimaryGreen,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: kPrimaryGreen.withOpacity(0.23),
                      ),
                    ]),
                child: Row(
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "$day\n".toUpperCase(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "$month".toUpperCase(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
