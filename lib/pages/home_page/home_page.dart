import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_stajirovka/viewModels/home_viewModel.dart';
import '../../service/constants/colors.dart';
import 'home_views.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeViewModel(),
      builder: (context, child) {
             return const MainView();
            });
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.select((HomeViewModel value) =>value.isLoading);
    final controller1 = context.select((HomeViewModel value) =>value.isShowDialog);
    final controller2 = context.read<HomeViewModel>();

    // final controller = context.select((HomeViewModel value) =>value.);
    return Scaffold(
      body:controller?const Center(child: CircularProgressIndicator()): Container(
        height: 1.sh,
        width: 1.sw,
        color: Colors.grey.withOpacity(0.5),
        child: Stack(
          children: [
            const _HomePage(),
          if(controller1) Container(
              height: 1.sh,
              width: 1.sw,
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Container(
                height: 346.w,
                width: 327.w,
                padding: EdgeInsets.only(bottom: 22.w,left: 16.w,right: 16.w),

                decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(8.r),
                // image: DecorationImage
                ),
                child: Column(
                  children: [
                    Align(alignment: Alignment.topRight,child: IconButton(onPressed: (){controller2.cancelDialog();},icon:const Icon(Icons.close),iconSize: 25,)),
                    Text("Har safar yangi rasm siz uchun",style: TextStyle(fontSize: 14.w,fontWeight: FontWeight.w400),),
                    SizedBox(height: 16.h),
                    Container(
                      height: 180.w,
                      width: double.infinity,
                      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(context.read<HomeViewModel>().imageModel.urls!.small!),fit: BoxFit.fill),borderRadius: BorderRadius.circular(8.r)),
                    ),
                    SizedBox(height: 16.h),
                    MaterialButton(onPressed: (){controller2.stopDialog();},height: 48.w,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),color: AppColors.customButtonSideColor,child: Center(child:Text("To'xtatish",style: TextStyle(fontSize: 16.w,fontWeight: FontWeight.w500),)),)
                  ],
                ),
              ),
            )
          ],
        ),
      ) ,
    );
  }
}


class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

     final controller =context.read<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.pageBackgroundColor,
      appBar: AppBar(title:Text("Rounded Task") ,centerTitle: false),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 16.w,left: 16.w,right: 16.w,top: 5.w),
        child: Column(
          children: [
            const DawnLoadInfo(),
             SizedBox(height: 24.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
                height: 96.w,
                width: 96.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(image: AssetImage("assetes/images/lesson2_image.png"),fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(8.r),

                ),
              ),
              SizedBox(width: 12.w,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("Lesson 2",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,color: const Color(0xFF828282))),
                SizedBox(height: 5.w,),
                Text("How to talk about nation\n Asilbek Asqarov Asilbek",textAlign: TextAlign.start,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500,color: const Color(0xFF4F4F4F)))],))
            ],),
            SizedBox(height: 16.h,),
            /// download and save button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(buttonColor: Colors.white, onTap: () {  }, child: Row(children: [Text("Saqlab qo'yish",style: TextStyle(color: AppColors.customButtonSideColor,fontSize: 16.sp,fontWeight: FontWeight.w400),),SizedBox(width: 4.w,),Image(image: const AssetImage("assetes/images/save_image.png"),width: 24.w,height: 24.h,fit: BoxFit.fill,color: AppColors.customButtonSideColor,)],),),
                CustomButton(buttonColor: AppColors.customButtonSideColor, onTap: () {controller.progress ==0? controller.downLoadVideo():(){print("bosilmaydi");}; }, child: Row(children: [Text("Yuklab olish",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w400),),SizedBox(width: 4.w,),Image(image: const AssetImage("assetes/images/download_image.png"),width: 24.w,height: 24.h,fit: BoxFit.fill,)],),)
              ],
            ),
            SizedBox(height: 24.h,),
            /// speak like a native
            const SpeakNative(),
            // Container(
            //   width: 1.sw,
            //   height: 160.h,
            //   alignment: Alignment.bottomCenter,
            //   clipBehavior: Clip.hardEdge,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8.r),
            //     image:controller.isPlayVideo?null: const DecorationImage(image: AssetImage("assetes/images/children_image.png"),fit: BoxFit.fill)
            //   ),
            //   child:Stack(
            //     children: [
            //       controller.isPlayVideo? FutureBuilder(
            //         future: controller.videoController.initialize(),
            //         builder: (context, snapshot) {
            //           if (snapshot.connectionState == ConnectionState.done) {
            //             return VideoPlayer(controller.videoController);
            //           }
            //           else {
            //             return const Center(child: CircularProgressIndicator());
            //           }
            //         },
            //       ):
            //       Container(
            //         height: 52.h,
            //         padding: EdgeInsets.only(left: 12.w,right: 12.w),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
            //             gradient: LinearGradient(
            //                 begin: Alignment.bottomCenter,
            //                 end: Alignment.topCenter,
            //                 colors: [
            //                   Colors.black.withOpacity(0.55),
            //                   Colors.black54.withOpacity(0.4),
            //                   Colors.grey.withOpacity(0.4),
            //                   Colors.grey.withOpacity(0.25),
            //                   Colors.grey.withOpacity(0.05)
            //                 ]
            //             )
            //         ),
            //         alignment: Alignment.center,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text("How to speak like a native",style: TextStyle(fontSize: 18.w,fontWeight: FontWeight.w500,color: Colors.white)),
            //           ],
            //         ),
            //       ),
            //       Positioned(right: 16.w,bottom:1.w,child: IconButton(onPressed: (){controller.playVideo();}, icon: const Icon( Icons.play_circle_outline_rounded,color: Colors.white,size: 20,)))
            //     ],
            //   )
            // ),
            SizedBox(height: 24.h,),
            /// english skills
            const EnglishSkills()
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children:  [
            //     CustomContainer(imageUrl: 'assetes/images/grammar.png', height: 164, width: 164, ishShow:controller.isShowGrammar, onTap: () { controller.changeGrammar(); }),
            //     CustomContainer(imageUrl: 'assetes/images/vocabulary.png', height: 164, width: 164, ishShow: controller.isShowVocabulary, onTap: () { controller.changeVocabulary(); }),
            //   ],
            // ),
            // SizedBox(height: 20.h,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CustomContainer(imageUrl: 'assetes/images/speaking.png', height: 164, width: 164, ishShow: controller.isSHowSpeaking, onTap: () { controller.changeSpeaking(); }),
            //     CustomContainer(imageUrl: 'assetes/images/listening.png', height: 164, width: 164, ishShow: controller.isShowListening, onTap: () { controller.changeListening(); }),
            //   ],
            // ),
            // SizedBox(height: 20.h,),
            // CustomContainer(imageUrl: 'assetes/images/homeWork.png', height: 131, width:1.sw, ishShow: controller.isShowHomework, onTap: () { controller.changeHomework(); }),
          ],
        ),
      ),
    );
  }
}



