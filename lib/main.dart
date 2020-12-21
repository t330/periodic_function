import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:periodic_function/main_model.dart';
import 'package:provider/provider.dart';
import 'clock.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  int _value = 5;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aaaaadsfsd',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '同期信号アプリ'
          ),
        ),
        body: Consumer<MainModel>(builder: (context, model, child) {
          return Column(
              children: [
                Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          model.numberOfFlashes.toString(),
                        ),
                        DropdownButton (
                          value: _value,
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                '5秒ごと'
                              ),
                              value: 5,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                '5分ごと'
                              ),
                              value: 300,
                            ),
                            DropdownMenuItem(
                              child: Text(
                                '10分ごと'
                              ),
                              value: 600,
                            ),
                          ],
                          onChanged: (value) {
                            _value = value;
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            '開始する'
                          ),
                          onPressed: model.isStarting ? null : () {
                            model.initialFlashlight(_value);
                            print('開始した！');
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            '停止する'
                          ),
                          onPressed: !model.isStarting ? null : () {
                            model.cancelInitialFlashlight();
                            print('停止した！');
                          },
                        ),
                        Clock(),
                      ],
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: model.flashHistory.length,
                    itemBuilder: (context, int index) {
                      return Text(
                        model.flashHistory[index],
                        style: GoogleFonts.robotoMono(fontSize: 20),
                      );
                    },
                  ),
                ),
              ],
          );
            },
          ),
        ),
      ),
    );
  }
}