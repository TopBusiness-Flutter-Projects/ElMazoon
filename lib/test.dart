// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:macadress_gen/macadress_gen.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(title: 'Material App', home: HomePage());
//   }
// }
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   MacadressGen macadressGen = MacadressGen();
//
//   String? mac;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MAC ADDRESS'),
//       ),
//       body: Center(
//           child: Text(
//         mac ?? 'MAC ',
//         style: TextStyle(
//             fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black54),
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           print('GetMacAddress.macAddress');
//           print(await GetMacAddress.macAddress.then((value) => setState((){print(value);})));
//
//           await getMAc();
//           setState(
//             () {},
//           );
//         },
//       ),
//     );
//   }
//
//   Future getMAc() async {
//     mac = await MacadressGen().getMac();
//     print('mac');
//     print(mac);
//   }
// }
//
//
// class GetMacAddress {
//   static const MethodChannel _channel = const MethodChannel('get_mac');
//
//   static Future<String> get macAddress async {
//     final String macID = await _channel.invokeMethod('getMacAddress');
//     return macID;
//   }
// }