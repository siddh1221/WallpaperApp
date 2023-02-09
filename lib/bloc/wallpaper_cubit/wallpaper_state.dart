abstract class WallpaperState {}

class WallpaperInitialState extends WallpaperState {}

class WallpaperLoadingState extends WallpaperState {}

class WallpaperLoadedState extends WallpaperState {
  final List wallpapers;

  WallpaperLoadedState(this.wallpapers);
}

class WallpaperErrorState extends WallpaperState {
  final String message;

  WallpaperErrorState(this.message);
}
