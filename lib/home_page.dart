import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _cost_service = TextEditingController();
  int? currentRadio;
  bool isSwitched = false;
  double tipAmount = 0;
  var radioGroup = {0: "Amazing (20%)", 1: "Good (18%)", 2: "Okay (15%)"};
  var percent = [20, 18, 15];
  bool _iscost = true;
  bool _isRadio = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.store),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: Container(
                margin: const EdgeInsets.only(right: 150),
                child: TextField(
                  controller: _cost_service,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Cost service",
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(),
                      errorText: !_iscost ? 'Please enter cost' : null),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Text("How was the service?"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isRadio ? "" : "Choose leatest one",
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: radioGroupGenerator(),
            ),
          ),
          SwitchListTile(
              secondary: Icon(Icons.north_east),
              title: Text("Round up tip"),
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              }),
          MaterialButton(
            onPressed: () => _tipCalculation(),
            child: Text(
              "CALCULATE",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
          ),
          Container(
            padding: EdgeInsets.only(right: 10, top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Tip amount: \$ ${tipAmount.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _tipCalculation() {
    // TODO: completar
    _iscost = _cost_service.value.text != '' ? true : false;
    _isRadio = currentRadio != null ? true : false;
    tipAmount = currentRadio != null && _cost_service.value.text != ''
        ? (double.parse(_cost_service.value.text) * (currentRadio ?? 0) / 100)
        : 0;
    if (isSwitched) {
      tipAmount = (tipAmount.ceil()).toDouble();
    }
    setState(() {});
  }

  radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioElement) => ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              leading: Radio(
                value: percent[radioElement.key],
                groupValue: currentRadio,
                onChanged: (int? selected) {
                  currentRadio = selected;
                  setState(() {});
                },
              ),
              title: Text(
                "${radioElement.value}",
                style: TextStyle(color: _isRadio ? Colors.black : Colors.red),
              )),
        )
        .toList();
  }
}
