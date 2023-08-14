
import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Gridview with Color Change'),
      ),
      body: GridView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
                 Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _ColorPage(color: colors[_selectedColor]),
            ),
          );
              });
            },
            child: Container(
              color: colors[index],
              child: Center(
                child: Text(
                  colors[index].toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

class _ColorPage extends StatelessWidget {
  final Color color;

  _ColorPage({required this.color,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(color.toString()),
      ),
      body: Container(
        color: color,
        child: Center(
          child: Text(
            'This is the color page!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}