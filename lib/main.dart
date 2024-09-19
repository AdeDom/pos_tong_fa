import 'package:flutter/material.dart';
import 'package:pos_tong_fa/data/repositories/hardware_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'POS - Tong fa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HardwareRepository _hardwareRepository = HardwareRepositoryImpl();
  dynamic _data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Data : $_data'),
            ElevatedButton(
              onPressed: () async {
                final data = await _hardwareRepository.ledConnect();
                setState(() {
                  _data = data;
                });
              },
              child: const Text('Led connect'),
            ),
            ElevatedButton(
              onPressed: () async {
                final data = await _hardwareRepository.ledDisconnect();
                setState(() {
                  _data = data;
                });
              },
              child: const Text('Led disconnect'),
            ),
            ElevatedButton(
              onPressed: () async {
                final data = await _hardwareRepository.ledClearScreen();
                setState(() {
                  _data = data;
                });
              },
              child: const Text('Led clear screen'),
            ),
            ElevatedButton(
              onPressed: () async {
                final data = await _hardwareRepository.ledDisplay(123.45);
                setState(() {
                  _data = data;
                });
              },
              child: const Text('Led display'),
            ),
          ],
        ),
      ),
    );
  }
}
