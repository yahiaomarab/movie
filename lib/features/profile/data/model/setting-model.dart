import 'package:flutter/widgets.dart';

class SettingListModel{
   BuildContext context;
   IconData? icon; 
   dynamic routerPath;
   String? title;
   SettingListModel(this.context,this.icon,this.routerPath,this.title);
}