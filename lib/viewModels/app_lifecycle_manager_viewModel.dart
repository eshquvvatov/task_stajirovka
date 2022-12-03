import 'package:flutter/cupertino.dart';

class AppLifecycleManager extends ChangeNotifier{
  AppLifecycleState appLifecycleState=AppLifecycleState.resumed;

  /// change lifecycle
  void changeLifecycle(AppLifecycleState lifecycle){
    print("lifecycle----------------------$lifecycle");
    appLifecycleState=lifecycle;
    notifyListeners();
  }
}