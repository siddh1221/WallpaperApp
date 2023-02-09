import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpapper_app/bloc/wallpaper_cubit/wallpaper_cubit.dart';
import 'package:wallpapper_app/repo/wallpaper_repo.dart';

import 'package:wallpapper_app/screens/splash_screen/spalsh_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WallpaperCubit>(
        create: (context) => WallpaperCubit(WallPaperRepository()),
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(useMaterial3: true),
              title: 'Wallpaper',
              home: const SplashScreen()),
          designSize: const Size(390, 844),
        ));
  }
}
