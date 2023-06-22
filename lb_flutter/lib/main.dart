import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lb_flutter/HomePage.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ///用于接收原生项目的传值
  Map<String, dynamic>? arguments;

  static const messageChannel = BasicMessageChannel('com.pages.your/native_post', StandardMessageCodec());

  Future<Object?> sendMessage() async {
    //参数
    Map<String, dynamic> arguments = {"title": "我是flutter传过来的title", "cid": "78"};
    //发送组装
    Map<String,dynamic> sendMap = {"method" : "toNativePop" , "arguments" : arguments};
    final reply = await messageChannel.send(sendMap);
    print('reply: $reply');
    return reply;
  }

  void receiveMessage() {
    messageChannel.setMessageHandler((message) async {
      print('接收到iOS发的 message: $message');
      // arguments = message as Map<String, dynamic>;
      // print("arguments1:  ${arguments}");
      dynamic myMessage = message;
      Map<String, dynamic> messageMap = Map.from(myMessage);
      arguments = messageMap;
      print('接收到iOS发的 message 1: $messageMap');
      setState(() {

      });
      return '返回Native端的数据';
    });
  }


  @override
  void initState() {
    super.initState();
    //接收iOS的消息
    receiveMessage();
    // sendMessage();
  }


  @override
  Widget build(BuildContext context) {
    print("arguments  ${arguments}");
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments?['title'] ?? ''),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text('ID: ${arguments?['id'] ?? ''}'),
            SizedBox(height: 100,),
            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                },
                child: Text("下一页")),
            SizedBox(height: 20,),
            TextButton(
                onPressed: (){
                  sendMessage();
                },
                child: Text("返回数据给iOS")),
          ],
        ),
      ),
    );
  }

}
