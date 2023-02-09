import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../bloc/wallpaper_cubit/wallpaper_cubit.dart';
import '../../bloc/wallpaper_cubit/wallpaper_state.dart';
import '../full_screen/full_screen.dart';

class CategorieScreen extends StatefulWidget {
  final String categorie;
  const CategorieScreen({super.key, required this.categorie});

  @override
  State<CategorieScreen> createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  @override
  void initState() {
    BlocProvider.of<WallpaperCubit>(context).getWallpaper(widget.categorie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categorie,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<WallpaperCubit, WallpaperState>(
        builder: (context, state) {
          if (state is WallpaperLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WallpaperErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is WallpaperLoadedState) {
            List data = state.wallpapers;
            return GridView.count(
              // controller: controller,
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(4.0),
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              children: List.generate(data.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreen(
                            imgPath: data[index]['src']['original'],
                          ),
                        ));
                  },
                  child: Hero(
                    tag: data[index]['src']['original'],
                    child: CachedNetworkImage(
                        imageUrl: data[index]['src']['tiny'],
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: 80.0.w,
                            height: 80.0.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black,

                              // shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    data[index]['src']['tiny'],
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          );
                        },
                        placeholder: (context, url) {
                          return Center(
                            child: SizedBox(
                              height: 50.h,
                              width: 50.w,
                              child: Center(
                                child: LoadingIndicator(
                                    indicatorType: Indicator.ballRotateChase,

                                    /// Required, The loading type of the widget
                                    colors: kDefaultRainbowColors,

                                    /// Optional, The color collections
                                    strokeWidth: 5,

                                    /// Optional, The stroke of the line, only applicable to widget which contains line
                                    backgroundColor: Colors.transparent,

                                    /// Optional, Background of the widget
                                    pathBackgroundColor: Colors.transparent

                                    /// Optional, the stroke backgroundColor
                                    ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              }),
            );
          }
          return Center(
            child: IconButton(
                onPressed: () {
                  BlocProvider.of<WallpaperCubit>(context)
                      .getWallpaper(widget.categorie);
                },
                icon: const Icon(Icons.refresh)),
          );
        },
      ),
    );
  }

  final List<Color> kDefaultRainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];
}
