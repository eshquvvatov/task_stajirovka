import 'dart:convert';
import 'package:hive/hive.dart';


class _StorageKeys {

  static const DialogInfo = 'DialogInfo';
  static const Grammar = 'Grammar';
  static const Speaking = 'Speaking';
  static const Listening = 'Listening';
  static const Homework = 'Homework';
  static const Vocabulary = 'Vocabulary';



}
class DBService{

  static String DB_NAME = "stajirobka";
  static Box box = Hive.box(DB_NAME);

  static Future<void>storeDialogInfo(bool info)async{
    await box.put(_StorageKeys.DialogInfo,info);
  }

  static bool getDialogInfo(){
    return box.get(_StorageKeys.DialogInfo,defaultValue:true);
  }
  static Future<void>storeGrammar(bool info)async{
    await box.put(_StorageKeys.Grammar,info);
  }

  static bool getGrammar(){
    return box.get(_StorageKeys.Grammar,defaultValue:false);
  }
  static Future<void>storeSpeaking(bool info)async{
    await box.put(_StorageKeys.Speaking,info);
  }

  static bool getSpeaking(){
    return box.get(_StorageKeys.Speaking,defaultValue:false);
  }
  static Future<void>storeListening(bool info)async{
    await box.put(_StorageKeys.Listening,info);
  }

  static bool getListening(){
    return box.get(_StorageKeys.Listening,defaultValue:false);
  }
  static Future<void>storeHomework(bool info)async{
    await box.put(_StorageKeys.Homework,info);
  }

  static bool getHomework(){
    return box.get(_StorageKeys.Homework,defaultValue:false);
  }
  static Future<void>storeVocabulary(bool info)async{
    await box.put(_StorageKeys.Vocabulary,info);
  }

  static bool getVocabulary(){
    return box.get(_StorageKeys.Vocabulary,defaultValue:false);
  }


}

