import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/features/favourite/favourite-view.dart';
import 'package:movie/features/home/presentation/views/home-view.dart';
import 'package:movie/features/layout/presentation/view-model/layout-states.dart';
import 'package:movie/features/series/series-view.dart';
import 'package:movie/features/settings/presentation/view/settings-view.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit():super(LayoutInitState());
  static LayoutCubit get(context)=>BlocProvider.of(context);
  int currentIndex =0;
  List<Widget>screens=[
    const HomePage(),
    const SeriesPage(),
    const FavouritePage(),
     const SettingsPage(),
  ];
  void changeBottomNavIndex(int index){
    currentIndex = index;
    emit(ChangingIndexState());
  }
}