import 'package:epilepsia/model/healthy/IconModel.dart';
import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget(
      Key key, this.id, this.text, this.iconData, this.color, this.statusList)
      : super(key: key);

  final String text;
  final int iconData;
  final Color color;
  final String id;
  final List<StatusIcons> statusList;

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  String id;
  String text;
  int iconData;
  Color color;
  Border border;
  bool change = false;
  bool _isEnable = false;

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
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 1, left: 10, right: 10),
        height: 90,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  color: color, shape: BoxShape.circle, border: border),
              child: IconButton(
                icon: Icon(
                  IconData(iconData, fontFamily: 'MaterialIcons'),
                  color: Colors.black,
                ),
                onPressed: () {
                  //Auswählen des Button
                  setState(
                    () {
                      StatusIcons statusIcon = new StatusIcons(
                          id: id, color: color, name: text, iconData: iconData);
                      // Ausgewähltes Icon wird gesucht und Werte eingetragen
                      if ((widget.statusList.singleWhere(
                              (element) => element.id == statusIcon.id,
                              orElse: () => null)) !=
                          null) {
                        if ((widget.statusList.singleWhere(
                                (element) => element.name == statusIcon.name,
                                orElse: () => null)) !=
                            null) {
                          change = false;
                          color = widget.color;
                          border = border = Border.all(
                            color: Colors.white,
                            width: 0,
                          );
                          //Bei erneutem Klick auf das Icon-Button wird die Auswahl aufgehoben
                          widget.statusList.removeWhere(
                              (element) => element.name == statusIcon.name);
                        }
                      } else {
                        //Wenn das höchste Stresslevel ausgewählt wird, wird die Spieleerinnerung sichtbar
                        setState(() {
                          if (text == "Stress") {
                            _isEnable = true;
                          }
                        });
                        //Icon-Button bekommt beim Auswählen eine schwarze Umrandung
                        change = true;
                        border = Border.all(
                          color: Colors.black,
                          width: 2,
                        );
                        //Das ausgewählte Icon-Button wird im Widget in der statusList hinterlegt
                        widget.statusList.add(statusIcon);
                      }
                    },
                  );
                },
              ),
            ),
            //Spieleerinnerung wird angezeigt
            Visibility(
              visible: _isEnable,
              child: Container(
                margin: EdgeInsets.only(top: 5, bottom: 1, left: 5, right: 5),
                child: Text("Bitte ein Spiel spielen!",
                    style: TextStyle(color: Colors.red[300], fontSize: 11)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 5,
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
