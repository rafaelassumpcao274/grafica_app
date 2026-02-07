import 'package:flutter/cupertino.dart';

class TitlePage extends ValueNotifier<String>{
  TitlePage(): super("Unilith App");

  void setTitle(String title) {
    value = title;
  }

}