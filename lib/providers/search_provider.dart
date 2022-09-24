import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  final _searchController = TextEditingController();
  String _prefix = '';

  TextEditingController get searchController => _searchController;

  void setPrefix(String val) {
    _prefix = val;
  }
}
