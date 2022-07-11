import 'dart:ui';

class Category{
  const Category(this.name, this.icon, this.color, this.imgName, this.subCategories);

  final String name;
  final String icon;
  final Color color;
  final String imgName;
  final List<Category> subCategories;
}