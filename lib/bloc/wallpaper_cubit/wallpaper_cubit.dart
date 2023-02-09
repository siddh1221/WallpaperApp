import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpapper_app/bloc/wallpaper_cubit/wallpaper_state.dart';
import 'package:wallpapper_app/repo/wallpaper_repo.dart';

class WallpaperCubit extends Cubit<WallpaperState> {
  WallpaperCubit(this._repository) : super(WallpaperInitialState());
  final WallPaperRepository _repository;

  void getWallpaper(String category) async {
    emit(WallpaperLoadingState());
    try {
      final wallpaper = await _repository.getWallPaper(category);
      if (wallpaper == null) {
        emit(WallpaperErrorState("Somthing Went Wrong"));
      } else {
        print(wallpaper.toString());
        emit(WallpaperLoadedState(wallpaper));
      }
    } catch (e) {
      print(e.toString());
      if (e == "Failed host lookup: 'api.pexels.com'") {
        emit(WallpaperErrorState("Please check internet connection"));
      }
    }
  }
}
