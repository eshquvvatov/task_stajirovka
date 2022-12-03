import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_stajirovka/models/imageModel.dart';
import 'package:task_stajirovka/service/db_service.dart';
import 'package:task_stajirovka/service/internet_service.dart';
import 'package:video_player/video_player.dart';
import 'app_lifecycle_manager_viewModel.dart';

class HomeViewModel extends ChangeNotifier {
  late ImageModel imageModel;
  bool isLoading = false;
  bool isPlayVideo = false;
  bool isStartDownLoad=false;
  late bool isShowDialog;
  late VideoPlayerController videoController;
  Timer? timer;
  bool isShowGrammar = false;
  bool isShowVocabulary = false;
  bool isSHowSpeaking = false;
  bool isShowListening = false;
  bool isShowHomework = false;
  int _countTap = 0;
  double progress = 0.0;

  HomeViewModel() {
    isShowDialog = DBService.getDialogInfo();
    isShowGrammar = DBService.getGrammar();
    isShowVocabulary = DBService.getVocabulary();
    isSHowSpeaking = DBService.getSpeaking();
    isShowListening = DBService.getListening();
    isShowHomework= DBService.getHomework();
    if (isShowDialog) getImage();
  }

  /// get random  image info from api
  void getImage() async {
    isLoading = true;
    notifyListeners();
    var response = await NetworkService.GET();
    imageModel = ImageModel.fromJson(jsonDecode(response!));
    isLoading = false;
    notifyListeners();
  }

  /// play video
  void playVideo(BuildContext context) {
    if(context.read<AppLifecycleManager>().appLifecycleState == AppLifecycleState.resumed)
      {if(isPlayVideo==false) {
        isPlayVideo=true;
        notifyListeners();
        videoController = VideoPlayerController.network(
          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
        );
        videoController.addListener(() { if(!videoController.value.isPlaying){
          print("isPlaying yugadi");
          isPlayVideo=false;
          notifyListeners();
        }
        if(context.read<AppLifecycleManager>().appLifecycleState == AppLifecycleState.paused){
          videoController.dispose();
        }
        });
        videoController.play();
      }}
    else {
      videoController.dispose();
    }

  }

  /// download video
  void downLoadVideo()async{
    isStartDownLoad=true;
    notifyListeners();
    Dio dio = Dio();
    const String url =
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';
    const String fileName = "TV.mp4";
    String path = await _getFilePath(fileName);
    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        progress = recivedBytes / totalBytes;
        notifyListeners();
        if(progress==1.0){
          isStartDownLoad=false;
          notifyListeners();
        }
      },
      deleteOnError: true,
    ).then((_) {

    });


  }
  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }

  void takeShadow(VoidCallback isShow) {
    timer = Timer(const Duration(seconds: 5), () {
      isShow();
      timer?.cancel();
      _countTap = 0;
    });
  }

  void cancelShadow() {
    timer?.cancel();
  }



  /// bloc english skills
  void blocEnglishSkills(VoidCallback isShow) {
    if (_countTap == 1) {
      timer = Timer(const Duration(milliseconds: 1000), () => _countTap = 1);
    }
    _countTap++;
    if (_countTap == 4) isShow();
    if (_countTap >= 4) {
      _countTap = 1;
      timer?.cancel();
    }
  }

  /// stop show Dialog
  void stopDialog() {
    DBService.storeDialogInfo(false);
    isShowDialog = false;
    notifyListeners();
  }

  /// cancel dialog
  void cancelDialog() {
    isShowDialog = false;
    notifyListeners();
  }

  /// change grammar show
  void changeGrammar() {
    print("grammer ishladi");
    isShowGrammar = !isShowGrammar;
    notifyListeners();
    DBService.storeGrammar(isShowGrammar);
  }

  /// change vocabulary
  void changeVocabulary() {
    isShowVocabulary = !isShowVocabulary;
    notifyListeners();
    DBService.storeVocabulary(isShowGrammar);
  }

  /// change Speaking
  void changeSpeaking() {
    isSHowSpeaking = !isSHowSpeaking;
    notifyListeners();
    DBService.storeSpeaking(isShowGrammar);
  }

  /// change Listening
  void changeListening() {
    isShowListening = !isShowListening;
    notifyListeners();
    DBService.storeListening(isShowGrammar);
  }

  /// change Homework
  void changeHomework() {
    isShowHomework = !isShowHomework;
    notifyListeners();
    DBService.storeHomework(isShowGrammar);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    videoController.dispose();
  }

}
