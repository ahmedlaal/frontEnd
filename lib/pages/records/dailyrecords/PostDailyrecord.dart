import 'package:devopsapp/api/API.dart';
import 'package:devopsapp/common/CWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

final nameR = RegExp(r'^[a-zA-Z]+$');
final String nameU = 'use  a-z | A-Z';

class PostDailyrecord extends StatefulWidget {
  @override
  _PostDailyrecordState createState() => _PostDailyrecordState();
}

class _PostDailyrecordState extends State<PostDailyrecord> {
  final _postDRKey = GlobalKey<FormState>();
  late String recordname;
  TextEditingController value = TextEditingController();
  List<String> options = [
    'BP',
    'Pulse Rate',
    'Respiration Rate',
    'Body Temperature'
  ];

  void setRecordName(name) {
    setState(() {
      recordname = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Daily Records')),
      body: Form(
          key: _postDRKey,
          child: ListView(padding: const EdgeInsets.all(15), children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: FormBuilderDropdown<String>(
                name: 'Deases',
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.blue)),
                ),
                // hint: Text('Select Deases'),
                // validator: FormBuilderValidators.required(context),
                onChanged: (value) {
                  setRecordName(value);
                },
                items: options
                    .map((name) => DropdownMenuItem(
                          value: name,
                          child: Text('$name'),
                        ))
                    .toList(),
              ),
            ),
            tf2(value, 'Reacord Value', nameR, nameU, TextInputType.number),
            button('Add Daily Record', postRecord),
          ])),
    );
  }

  postRecord() {
    if (recordname == null) {
    } else {
      int id = options.indexOf(recordname);
      Map dataToBePost = {"user": 1, "recordname": id + 1, "value": value.text};
      postData('dailyrecords/', dataToBePost);
    }
  }
}
