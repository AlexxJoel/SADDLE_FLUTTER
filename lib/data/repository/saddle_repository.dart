import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:catalogue_saddle/data/model/saddle_model.dart';

class SaddleRepository{
  final String apiURL;

  SaddleRepository({required this.apiURL});

  Future<SaddleModel> createSaddle(SaddleModel saddle) async{
    final response = await http.post(
      Uri.parse('$apiURL/saddle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(saddle.toJson())
    );
    if(response.statusCode != 201){
      throw Exception('Failed to create saddle');
    }

    final resp = json.decode(response.body);
    final data = resp['data'];
    return SaddleModel.fromJson(data);
  }

  // get one ?

  Future<SaddleModel> updateSaddle(SaddleModel saddle) async{
    final response = await http.put(
      Uri.parse('$apiURL/saddle'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(saddle.toJson())
    );
    if(response.statusCode != 200){
      throw Exception('Failed to update saddle');
    }

    return SaddleModel.fromJson(json.decode(response.body));
  }

  Future<SaddleModel> deleteSaddle(String id) async{
    final response = await http.delete(Uri.parse('$apiURL/saddle/$id'));

    final statusCode = response.statusCode.toInt();
    if(statusCode != 200){
      throw Exception('Failed to delete saddle');
    }
    final resp = json.decode(response.body);
    // return a object onlu with id
    return  SaddleModel.fromJson({'id': resp['data']['id'], 'brand': '', 'model': '', 'material': '', 'size': ''});

  }

  Future<List<SaddleModel>> getAllSaddles() async{
    final response = await http.get(Uri.parse('$apiURL/saddle'));
    if(response.statusCode == 200) {
      final resp = json.decode(response.body);
      final Iterable items = resp['data']['items'];
      return items.map((saddle) => SaddleModel.fromJson(saddle)).toList();
    }else if(response.statusCode == 204){
      return [];
    }else{
      throw Exception('Failed to load saddles');
    }
  }
}