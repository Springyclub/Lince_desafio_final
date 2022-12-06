import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'database.dart';

class Controlador {
}


  Future<void> salvaArquivo(String placa) async {
    final appDir = await getApplicationDocumentsDirectory();

    final fotosDir = Directory('${appDir.path}/fotos_veiculos');
    if (!fotosDir.existsSync()) {
      await fotosDir.create();
    }

    final fotoDaGaleria = File('oaushdgfosdng/asd;foushfhas.jpg');
    final imagem = File('${fotosDir.path}/$placa.jpg');

    if (!imagem.existsSync()) {
      await imagem.create();
    }

    await imagem.writeAsBytes(fotoDaGaleria.readAsBytesSync());
  }

  Future<File> buscaArquivo(String placa) async {
    final appDir = await getApplicationDocumentsDirectory();

    final fotosDir = Directory('${appDir.path}/fotos_veiculos');
    return File('${fotosDir.path}/$placa.jpg');
  }

