import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_stajirovka/pages/home_page/home_page.dart';
import 'package:task_stajirovka/service/db_service.dart';
import 'package:task_stajirovka/viewModels/app_lifecycle_manager_viewModel.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(DBService.DB_NAME);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLifecycleManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rounded Task',
        home: _LifeCycleManager(child: HomePage(),)
      ),
    );

  }
}



class _LifeCycleManager extends StatefulWidget {
 const _LifeCycleManager({ Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<_LifeCycleManager> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
   context.read<AppLifecycleManager>().changeLifecycle(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}



