import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router = Router();

  final reports = [
    {
      'user': 'Lucía Torres',
      'location': 'Colonia Las Flores',
      'image': '🏠',
      'description': 'Fuga de agua en la esquina de la calle principal',
      'time': 'Hace 1 hora',
    },
    {
      'user': 'Miguel Hernández',
      'location': 'Parque Industrial',
      'image': '🏭',
      'description': 'Humo excesivo proveniente de una fábrica cercana',
      'time': 'Hace 3 horas',
    },
    {
      'user': 'Sofía Martínez',
      'location': 'Boulevard del Sol',
      'image': '💡',
      'description': 'Farolas parpadeando durante la noche',
      'time': 'Hace 5 horas',
    },
    {
      'user': 'Andrés Pérez',
      'location': 'Mercado Municipal',
      'image': '🗑️',
      'description': 'Acumulación de basura sin recoger desde la mañana',
      'time': 'Hace 7 horas',
    },
  ];


  final users = [
    {"name": "Paul", "age": 19, "phone": "6121398270"},
    {"name": "Kutsi", "age": 19, "phone": "6121054313"}
  ];

  // Endpoints
  router.get('/hello', (Request request) {
    return Response.ok('Hola Mundo');
  });

  router.get('/reports', (Request request) {
    return Response.ok(jsonEncode(reports),
        headers: {'Content-Type': 'application/json'});
  });

  router.get('/users', (Request request) {
    return Response.ok(jsonEncode(users),
        headers: {'Content-Type': 'application/json'});
  });

  final handler =
      const Pipeline().addMiddleware(logRequests()).addHandler(router);

  await io.serve(handler, 'localhost', 8080);
  print('Servidor corriendo en el puerto 8080');
}