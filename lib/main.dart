import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

const kPort = 8000;
const kLocalMachineIP = '10.0.0.7';

void main() {
  runApp(const MyApp());
  if (Platform.isMacOS) {
    startServer();
  }
}

void startServer() async {
  final server = await ServerSocket.bind(InternetAddress.anyIPv4, kPort);
  print('Server started on port ${server.port}');

  await for (final socket in server) {
    print(
        'Client connected: ${socket.remoteAddress.address}:${socket.remotePort}');

    socket.listen((List<int> data) {
      final message = utf8.decode(data);
      print('Message from client: $message');
      socket.add(utf8.encode('Hello from macos'));
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FTF_USB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter is awesome'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Platform.isMacOS
                  ? 'Waiting for connection...'
                  : 'Click on button to connect and see terminal',
            ),
          ],
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () async {
                final socket = await Socket.connect(kLocalMachineIP, kPort);
                print('Connected to server');

                socket.add(utf8.encode('Hello from android'));

                socket.listen((List<int> data) {
                  final message = utf8.decode(data);
                  print('Message from server: $message');
                });
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
