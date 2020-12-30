import 'package:flutter/material.dart';


class RadioButtonsWidget extends StatefulWidget {
  RadioButtonsWidget({Key key,}) : super(key: key);

  @override
  _RadioButtonsWidgetState createState() => _RadioButtonsWidgetState();
}

String radioButtonsStatus = 'toBuy';

class _RadioButtonsWidgetState extends State<RadioButtonsWidget> {

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Radio(
          value: 'toBuy',
          groupValue: radioButtonsStatus,
          onChanged: (String value) {
            setState(() {
              radioButtonsStatus = value;
            });
          },
        ),
        Expanded(
          child: Text('To buy'),
        ),
        Radio(
          value: 'bought',
          groupValue: radioButtonsStatus,
          onChanged: (String value) {
            setState(() {
              radioButtonsStatus = value;
            });
          },
        ),
        Expanded(
          child: Text('Bought'),
        ),
        Radio(
          value: 'notFound',
          groupValue: radioButtonsStatus,
          onChanged: (String value) {
            setState(() {
              radioButtonsStatus = value;
            });
          },
        ),
        Expanded(
          child: Text('Not found'),
        ),
      ],
    );
  }
}
