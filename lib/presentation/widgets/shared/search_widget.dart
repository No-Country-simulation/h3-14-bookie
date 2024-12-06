import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 0.7)
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 10,),
          Text('Busca historias')
        ],
      ),
    );
  }
}