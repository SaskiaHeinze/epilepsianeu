import 'package:epilepsia/model/healthy/stimmung.dart';
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
    print(text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 5, left: 10, right: 10),
        height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: new BoxDecoration(
                  color: color, shape: BoxShape.circle, border: border),
              child: IconButton(
                icon: Icon(IconData(iconData, fontFamily: 'MaterialIcons'),
                color: Colors.black,),
                onPressed: () {
                  setState(
                    () {
                      StatusIcons statusIcon = new StatusIcons(          
                          id: id,
                          color: color,
                          name: text,
                          iconData: iconData);
                      if ((widget.statusList.singleWhere(
                              (element) => element.id == statusIcon.id,
                              orElse: () => null)) !=
                          null) {
                        print("Exist");
                        if ((widget.statusList.singleWhere(
                                (element) => element.name == statusIcon.name,
                                orElse: () => null)) !=
                            null) {
                          change = false;
                          color = widget.color;
                          border =  border = Border.all(
      color: Colors.white,
      width: 0,
    );
                          widget.statusList.removeWhere(
                              (element) => element.name == statusIcon.name);
                        }
                      } else {
                        print("not Exist");
                        setState(() {
                          if (text == "Stress") {
                            _isEnable = true;
                          }
                        });
                        change = true;
              
                        border = Border.all(
                          color: Colors.black,
                          width: 2,
                        );
                        widget.statusList.add(statusIcon);
                      }
                    },
                  );
                },
              ),
            ),
            Visibility(
              visible: _isEnable,
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                child: Text("Bitte Spiel spielen!!!",style: TextStyle(
    color: Colors.red[300],)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                bottom: 10,
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
