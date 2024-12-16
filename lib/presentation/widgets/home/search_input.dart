import 'dart:async';

import 'package:flutter/material.dart';
// Primero crear un widget personalizado para el buscador
class SearchInput extends StatefulWidget {
  final Function(String) onSearch;
  
  const SearchInput({
    super.key, 
    required this.onSearch
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  Timer? _debounce;
  
  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Busca historias',
            prefixIcon: Icon(Icons.search, size: 20),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            isDense: true,
          ),
          style: const TextStyle(fontSize: 14),
          onChanged: _onSearchChanged,
        ),
      ),
    );
  }
}