import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventChannelDemo(),
    );
  }
}

class EventChannelDemo extends StatefulWidget {
  @override
  _EventChannelDemoState createState() => _EventChannelDemoState();
}

class _EventChannelDemoState extends State<EventChannelDemo> {
  static const eventChannel = EventChannel('com.kotlincodes.event_channel_demo/stream');

  String _eventData = 'Waiting for data...';

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen((dynamic event) {
      setState(() {
        _eventData = event.toString();
      });
    }, onError: (dynamic error) {
      setState(() {
        _eventData = 'Error: \${error.message}';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Channel Demo'),
      ),
      body: Center(
        child: Text(_eventData),
      ),
    );
  }
}
