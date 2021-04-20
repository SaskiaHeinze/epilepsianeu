import 'package:epilepsia/model/healthy/IconModel.dart';
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

  ///Objekte werden in die Struktur eingefügt
  @override
  void initState() {
    text = widget.text;
    iconData = widget.iconData;
    color = widget.color;
    id = widget.id;
    border = Border.all(
      color: Colors.white,
      width: 0,
      style: BorderStyle.solid,
    );

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
              //Symbol für die Sportaktivität
              Icon(
                IconData(iconData, fontFamily: 'MaterialIcons'),
                color: Colors.black,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          //Auswählen des Button
          onPressed: () {
            setState(() {
              StatusIcons statusIcon = new StatusIcons(
                  id: id, color: color, name: text, iconData: iconData);
              // Ausgewählte Sportaktivität wird gesucht und Werte eingetragen
              if ((widget.statusList.singleWhere(
                      (element) => element.id == statusIcon.id,
                      orElse: () => null)) !=
                  null) {
                if ((widget.statusList.singleWhere(
                        (element) => element.name == statusIcon.name,
                        orElse: () => null)) !=
                    null) {
                  color = widget.color;
                  border = border = Border.all(
                    color: Colors.white,
                    width: 0,
                  );
                  //Bei erneutem Klick auf die Sportaktivität wird die Auswahl aufgehoben
                  widget.statusList.removeWhere(
                      (element) => element.name == statusIcon.name);
                }
              }
              //Text-Button bekommt beim Auswählen eine schwarze Umrandung
              else {
                change = true;
                border = Border.all(
                  color: Colors.black,
                  width: 2,
                );
                //Die ausgewählte Sportaktivität wird im Widget in der statusList hinterlegt
                widget.statusList.add(statusIcon);
              }
            });
          },
        ),
      ),
    );
  }
}
