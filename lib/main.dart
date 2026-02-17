import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0; // This is our STATE
  final TextEditingController _controller = TextEditingController();

  void _increment() {
    setState(() => _counter++);
  }

  void _decrement() {
    setState(() => _counter--);
  }

  void _reset() {
    setState(() => _counter = 0);
  }

  // FIX - GET INPUT VALUE
  void _setValue() {
    // get and convert input to int value
    String inputVal = _controller.text;
    int num = int.parse(inputVal);

    const warning = SnackBar(content: Text('Limit Reached!'));

    if ((num < 0) || (num > 100)) {
      ScaffoldMessenger.of(context).showSnackBar(warning);
    } else {
      setState(() => _counter = num);
    }

  }

  Color get counterColor {
    if (_counter == 0) return Colors.red;
    if (_counter >= 50) return const Color.fromARGB(255, 77, 200, 81);
    return Colors.black;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Counter')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue.shade100,
              padding: EdgeInsets.all(20),
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: 50.0, color: counterColor ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Slider(
            min: 0, max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              // 👇 This triggers the UI rebuild
              setState(() {
                _counter = value.toInt();
              });
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: _increment, child: Text("+")),
              ElevatedButton(onPressed: _counter == 0 ? null : _decrement, child: Text("-")),
              ElevatedButton(onPressed: _reset, child: Text("Reset")),
            ],
            ),
            // accept input from user
            Center(
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter a value'
                    )
                  ),
                  ElevatedButton(onPressed: _setValue, child: Text("Set Value"))
                ],
              )
            ),
        ],
      ),
    );
  }
}