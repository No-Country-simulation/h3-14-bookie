import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreSchemaExporter extends StatelessWidget {
  FirestoreSchemaExporter({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () async {
          await generateDbDiagramSchema();
        },
        child: const Text('Generate Schema'),
      ),
    ); // Puedes personalizar este widget según tus necesidades
  }

  Future<String> generateDbDiagramSchema() async {
    try {
      List<String> schema = [];
      Set<String> processedCollections = {};

      // Lista de colecciones conocidas
      List<String> knownCollections = [
        'users',
        'categories',
        'chapters',
        'stories',
        "tags"
        // Añade aquí otras colecciones que existan en tu base de datos
      ];

      for (String collectionName in knownCollections) {
        if (processedCollections.contains(collectionName)) continue;
        processedCollections.add(collectionName);

        try {
          var sampleDocs =
              await _firestore.collection(collectionName).limit(1).get();
          if (sampleDocs.docs.isEmpty) continue;

          var data = sampleDocs.docs.first.data();
          List<String> fields = [];

          data.forEach((key, value) {
            String fieldType = _getDbDiagramType(value);
            fields.add('  $key $fieldType');
          });

          String tableDefinition = '''
Table $collectionName {
${fields.join('\n')}
}''';

          schema.add(tableDefinition);
          print('Procesada colección: $collectionName');
        } catch (e) {
          print('Error procesando colección $collectionName: $e');
          continue;
        }
      }

      String finalSchema = schema.join('\n\n');
      print('\n=== ESQUEMA GENERADO ===\n');
      print(finalSchema);
      return finalSchema;
    } catch (e) {
      print('Error generando esquema: $e');
      return 'Error: $e';
    }
  }

  String _getDbDiagramType(dynamic value) {
    if (value is int) return 'integer';
    if (value is double) return 'float';
    if (value is bool) return 'boolean';
    if (value is Timestamp) return 'datetime';
    if (value is List) return 'array';
    if (value is Map) return 'json';
    return 'string'; // tipo por defecto para todo lo demás
  }
}
