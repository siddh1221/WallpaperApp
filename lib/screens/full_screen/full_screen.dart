// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class FullScreen extends StatefulWidget {
  const FullScreen({super.key, required this.imgPath});
  final String imgPath;
  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  showAlertDialog(BuildContext context, String imgPath) {
    String url = imgPath;

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Center(child: Text("Select Your Choies")),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text("Home Screen"), 
          onPressed: () async {
            var status = await Permission.storage.request();
            if (status.isGranted) {
              try {
                showDialog(
                    context: context,
                    builder: (BuildContext builderContext) {
                      return CupertinoAlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Center(child: CircularProgressIndicator()),
                            Text('Wait While a Second')
                          ],
                        ),
                      );
                    }).then((val) {
                  Navigator.pop(context);
                });

                int location = WallpaperManager
                    .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
                var file = await DefaultCacheManager().getSingleFile(url);
                final bool result = await WallpaperManager.setWallpaperFromFile(
                    file.path, location);
                debugPrint(result.toString());

                Navigator.pop(context);
                const snackBar = SnackBar(
                  content: Text('Wallpapper Set'),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } catch (e) {
                debugPrint("ERROR: $e");
              }
            } else {
              status;
            }
          },
        ),
        CupertinoDialogAction(
          child: const Text("Lock Screen"),
          onPressed: () async {
            var status = await Permission.storage.request();
            if (status.isGranted) {
              showDialog(
                  context: context,
                  builder: (BuildContext builderContext) {
                    return CupertinoAlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Center(child: CircularProgressIndicator()),
                          Text('Wait While a Second')
                        ],
                      ),
                    );
                  }).then((val) {
                Navigator.pop(context);
              });
              try {
                int location = WallpaperManager
                    .LOCK_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
                var file = await DefaultCacheManager().getSingleFile(url);
                final bool result = await WallpaperManager.setWallpaperFromFile(
                    file.path, location);
                debugPrint(result.toString());
                Navigator.pop(context);
                const snackBar = SnackBar(
                  content: Text('Wallpapper Set'),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } catch (e) {
                debugPrint("ERROR: $e");
              }
            } else {
              status;
            }
          },
        ),
        CupertinoDialogAction(
          child: const Text("Both Screen"),
          onPressed: () async {
            var status = await Permission.storage.request();
            if (status.isGranted) {
              showDialog(
                  context: context,
                  builder: (BuildContext builderContext) {
                    return CupertinoAlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Center(child: CircularProgressIndicator()),
                          Text('Wait While a Second')
                        ],
                      ),
                    );
                  }).then((val) {
                Navigator.pop(context);
              });
              try {
                int location = WallpaperManager
                    .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
                var file = await DefaultCacheManager().getSingleFile(url);
                final bool result = await WallpaperManager.setWallpaperFromFile(
                    file.path, location);
                debugPrint(result.toString());
                Navigator.pop(context);
                const snackBar = SnackBar(
                  content: Text('Wallpapper Set'),
                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } catch (e) {
                debugPrint("ERROR: $e");
              }
            } else {
              status;
            }
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showAlertDialog(context, widget.imgPath);
        },
        child: const Icon(Icons.image),
      ),
      backgroundColor: Colors.black,
      body: Hero(
          tag: widget.imgPath,
          child: CachedNetworkImage(
              imageUrl: widget.imgPath,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,

                    // shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(widget.imgPath), fit: BoxFit.cover),
                  ),
                );
              },
              placeholder: (context, url) {
                return Center(
                  child: SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: Center(
                      child: LoadingIndicator(
                          indicatorType: Indicator.ballRotateChase,
                          colors: _kDefaultRainbowColors,
                          strokeWidth: 5,
                          backgroundColor: Colors.transparent,
                          pathBackgroundColor: Colors.transparent),
                    ),
                  ),
                );
              })),
    );
  }

  final List<Color> _kDefaultRainbowColors = const [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
}
