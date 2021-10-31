import 'dart:io';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) {
    final decodedMessage = jsonDecode(message);
    final serverTimeAsEpoch = decodedMessage['tick']['epoch'];
    final quote = decodedMessage['tick']['quote'];
    final symbol = decodedMessage['tick']['symbol'];
    final serverTime =
        DateTime.fromMillisecondsSinceEpoch(serverTimeAsEpoch * 1000);
    print('Name: $symbol, Price: $quote, Date: $serverTime');

    // channel.sink.close();
  });

  print('Please Enter Active Symbol name');
  final symbol = stdin.readLineSync();
  channel.sink.add('{"ticks":"$symbol"}');
}
