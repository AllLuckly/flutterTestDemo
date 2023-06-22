import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const messageChannel = BasicMessageChannel('com.pages.your/native_post', StandardMessageCodec());
  ///用于接收原生项目的传值
  Map<String, dynamic>? arguments;

  Future<Object?> sendMessage() async {
    //参数
    Map<String, dynamic> arguments = {"title": "flutter title", "cid": "78"};
    //发送组装
    Map<String,dynamic> sendMap = {"method" : "pushToTest" , "arguments" : arguments};
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
  }

  String naviTitle = 'title' ;


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        // 在此处理返回事件
        return true; // 返回 true 表示允许返回
      },
        child:  Scaffold(
          body:  Center(
              child: TextButton(
                  onPressed: (){
                    clickBtn();
                  }
                  , child:  Text("跳转到原生界面Test"))
          ),
        ),

    );
  }

  void clickBtn(){//传值给iOS端
    sendMessage();
  }

  errorEventListen(dynamic error, StackTrace stackTrace) {

  }

}