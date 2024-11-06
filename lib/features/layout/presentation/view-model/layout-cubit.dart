import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/movies/favourite/favourite-view.dart';
import 'package:movie/features/movies/home/presentation/views/home-view.dart';
import 'package:movie/features/layout/presentation/view-model/layout-states.dart';
import 'package:movie/features/profile/presentation/view/profile-view.dart';
import 'package:movie/features/tv/home/presentation/view/tv-view.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super(LayoutInitState());
  static LayoutCubit get(context)=>BlocProvider.of(context);
  int currentIndex =0;
  List<Widget>screens=[
    const HomePage(),
    const SeriesPage(),
    const FavouritePage(),
      ProfileScreen(),
  ];
  void changeBottomNavIndex(int index){
    currentIndex = index;
    emit(ChangingIndexState());
  }
}