import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wallpapper_app/bloc/wallpaper_cubit/wallpaper_cubit.dart';
import 'package:wallpapper_app/bloc/wallpaper_cubit/wallpaper_state.dart';
import 'package:wallpapper_app/screens/full_screen/full_screen.dart';
import 'package:wallpapper_app/screens/home_page/widgets/category_tile.dart';

import '../../model/category_model.dart';
import 'data/category_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategorieModel> categories = [];
  @override
  void initState() {
    categories = getCategories();
    BlocProvider.of<WallpaperCubit>(context).getWallpaper("all");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SizedBox(
            height: 60.h,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  /// Create List Item tile
                  return CategoriesTile(
                    imgUrls: categories[index].imgUrl!,
                    categorie: categories[index].categorieName!,
                  );
                }),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Wallpaper",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<WallpaperCubit, WallpaperState>(
          builder: (context, state) {
            if (state is WallpaperLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
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
                                      colors: _kDefaultRainbowColors,

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
                        .getWallpaper("all");
                  },
                  icon: const Icon(Icons.refresh)),
            );
          },
          listener: (context, state) {
            if (state is WallpaperErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 1),
              ));
            }
          },
        ),
      ),
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
