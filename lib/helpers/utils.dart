import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:langapp/helpers/appcolors.dart';
import 'package:langapp/models/category.dart';

class Utils{

  static List<Category> getMockedCategories(){
    return [
      Category("Carnes", "IconName", Colors.blue, "cat1", []),
      Category("Carnes", "IconName", Colors.blue, "cat1", []),
      Category("Carnes", "IconName", Colors.blue, "cat1", []),
      Category("Carnes", "IconName", Colors.blue, "cat1", []),
      Category("Carnes", "IconName", Colors.blue, "cat1", []),
    ];
  }
}