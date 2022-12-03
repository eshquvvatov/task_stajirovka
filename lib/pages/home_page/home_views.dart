
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_stajirovka/service/constants/colors.dart';
import 'package:task_stajirovka/viewModels/home_viewModel.dart';
import 'package:video_player/video_player.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,required this.buttonColor,required this.child, required this.onTap}) : super(key: key);
  final Widget child;
  final VoidCallback onTap;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(onPressed:onTap,shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r),side: const BorderSide(color: AppColors.customButtonSideColor)),
      height: 40.h,minWidth: 160.w,color: buttonColor,child: Center(child: child,),
    );
  }
}
class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key, required this.imageUrl,required this.height, required this.width,required this.ishShow,required this.onTap}) : super(key: key);
  final String imageUrl;
  final double height;
  final double width;
  final bool ishShow;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller= context.read<HomeViewModel>();
    return GestureDetector(
      onTap:ishShow==true? (){
        print("ontap bosildi");
        controller.blocEnglishSkills(onTap);
      }:null,
      onTapDown:(ishShow==false)? (_) {
        print("boshlandu");
         controller.takeShadow(onTap);
      }:null,
      onTapCancel:() {
        print("tugadi tap calnel");
        controller.cancelShadow();
      } ,
      onTapUp:(ishShow==false)? (_) {
        print("tugadi");
        controller.cancelShadow();
      }:null,
      child: SizedBox(
        height: height.w,
        width:  width.w,
        child: Stack(
          children: [
            Container(
              height: height.w,
              width:  width.w,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r),image: DecorationImage(image: AssetImage(imageUrl),fit:BoxFit.fill)),
            ),
            Positioned(
                bottom: 18.h,
                left: 12.w,
                child: Row(
                  children: [
                    SizedBox(width: 105.w, child: Container(clipBehavior: Clip.hardEdge,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),child: LinearProgressIndicator(backgroundColor: Colors.white.withOpacity(0.2),minHeight: 8.h,value: 0.2,valueColor:  const AlwaysStoppedAnimation<Color>(Colors.white),))),
                    SizedBox(width: 8.w,),
                    Text("20 %",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.white),)
                  ],
                )),
            if(!ishShow)  Container(decoration: BoxDecoration(color: Colors.black54.withOpacity(0.5),borderRadius: BorderRadius.circular(8.r)),),
            if(!ishShow)  Center(child: Image(image: AssetImage("assetes/images/crown.png"),height: 40.w,width: 40.w,fit: BoxFit.fill,),)
          ],
        ),
      ),
    );
  }
}

class DawnLoadInfo extends StatelessWidget {
  const DawnLoadInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isStartDownLoad = context.select((HomeViewModel value) =>value.isStartDownLoad );
    final progress = context.select((HomeViewModel value) =>value.progress );
    if(isStartDownLoad) return LinearProgressIndicator(color: Colors.red,minHeight: 8.h,value:progress);
    return const SizedBox();
  }
}

class SpeakNative extends StatelessWidget {
  const SpeakNative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeViewModel>();
    final isPlayVideo = context.select((HomeViewModel value) => value.isPlayVideo);
    return Container(
        width: 1.sw,
        height: 160.h,
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image:isPlayVideo?null: const DecorationImage(image: AssetImage("assetes/images/children_image.png"),fit: BoxFit.fill)
        ),
        child:Stack(
          children: [
           isPlayVideo? FutureBuilder(
              future: controller.videoController.initialize(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return VideoPlayer(controller.videoController);
                }
                else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ):
            Container(
              height: 52.h,
              padding: EdgeInsets.only(left: 12.w,right: 12.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.55),
                        Colors.black54.withOpacity(0.4),
                        Colors.grey.withOpacity(0.4),
                        Colors.grey.withOpacity(0.25),
                        Colors.grey.withOpacity(0.05)
                      ]
                  )
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("How to speak like a native",style: TextStyle(fontSize: 18.w,fontWeight: FontWeight.w500,color: Colors.white)),
                ],
              ),
            ),
            Positioned(right: 16.w,bottom:1.w,child:const _PlayVideoButton())
          ],
        )
    );
  }


}
class _PlayVideoButton extends StatelessWidget {
  const _PlayVideoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeViewModel>();
    return IconButton(onPressed: (){controller.playVideo(context);}, icon:  const Icon( Icons.play_circle_outline_rounded,color: Colors.white,size: 20,));
  }
}

class EnglishSkills extends StatelessWidget {
  const EnglishSkills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeViewModel>();
    final isShowGrammar = context.select((HomeViewModel value) => value.isShowGrammar);
    final isShowVocabulary = context.select((HomeViewModel value) => value.isShowVocabulary);
    final isSHowSpeaking = context.select((HomeViewModel value) => value.isSHowSpeaking);
    final isShowListening = context.select((HomeViewModel value) => value.isShowListening);
    final isShowHomework = context.select((HomeViewModel value) => value.isShowHomework);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            CustomContainer(imageUrl: 'assetes/images/grammar.png', height: 164, width: 164, ishShow:isShowGrammar, onTap: () { controller.changeGrammar(); }),
            CustomContainer(imageUrl: 'assetes/images/vocabulary.png', height: 164, width: 164, ishShow:isShowVocabulary, onTap: () { controller.changeVocabulary(); }),
          ],
        ),
        SizedBox(height: 20.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomContainer(imageUrl: 'assetes/images/speaking.png', height: 164, width: 164, ishShow: isSHowSpeaking, onTap: () { controller.changeSpeaking(); }),
            CustomContainer(imageUrl: 'assetes/images/listening.png', height: 164, width: 164, ishShow:isShowListening, onTap: () { controller.changeListening(); }),
          ],
        ),
        SizedBox(height: 20.h,),
        CustomContainer(imageUrl: 'assetes/images/homeWork.png', height: 131, width:1.sw, ishShow: isShowHomework, onTap: () { controller.changeHomework(); }),

      ],
    );
  }
}




