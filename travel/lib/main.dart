import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:travel/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  StreamingSharedPreferences sp = await StreamingSharedPreferences.instance;
  runApp(MyApp(sp));

}

class MyApp extends StatelessWidget {
  final StreamingSharedPreferences sp;
  const MyApp(this.sp, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,),
      initialRoute: '/',
      routes: generateRoutes(sp),
    );
  }
}
