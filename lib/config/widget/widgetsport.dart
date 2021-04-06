import 'package:epilepsia/model/healthy/stimmung.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SportWidget extends StatefulWidget {
  const SportWidget(
      Key key, this.id, this.text, this.iconData, this.color, this.statusList)
      : super(key: key);

  final String text;
  final int iconData;
  final Color color;
  final String id;
  final List<StatusIcons> statusList;

  @override
  _SportWidgetState createState() => _SportWidgetState();
}

class _SportWidgetState extends State<SportWidget> {
  String id;
  String text;
  int iconData;
  Color color;
  Border border;
  bool change = false;

  @override
  void initState() {
    text = widget.text;
    iconData = widget.iconData;
    color = widget.color;
    id = widget.id;
    border = Border.all(
      color: Colors.white,
      width: 0,
    );
    // borderRadius: BorderRadius.all(Radius.circular(20));
    print(text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: border,
        ),
        margin: EdgeInsets.only(top: 25, bottom: 2, left: 15, right: 15),
        height: 90,
        child: TextButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(IconData(iconData, fontFamily: 'MaterialIcons')),
                color: Colors.black,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              StatusIcons statusIcon = new StatusIcons(
                  id: id, color: color, name: text, iconData: iconData);
              if ((widget.statusList.singleWhere(
                      (element) => element.id == statusIcon.id,
                      orElse: () => null)) !=
                  null) {
                print("Exist");
                if ((widget.statusList.singleWhere(
                        (element) => element.name == statusIcon.name,
                        orElse: () => null)) !=
                    null) {
                  color = widget.color;
                  border = border = Border.all(
                    color: Colors.white,
                    width: 0,
                  );
                  widget.statusList.removeWhere(
                      (element) => element.name == statusIcon.name);
                }
              } else {
                print("not Exist");
                change = true;
                border = Border.all(
                  color: Colors.black,
                  width: 2,
                );
                widget.statusList.add(statusIcon);
              }
            });
          },
        ),
      ),
    );
  }
}
