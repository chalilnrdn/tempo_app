
import 'dart:convert';
import 'package:tempo_app/models/news_response.dart';
import 'package:tempo_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _baseUrl = Constants.baseUrl;
  static final String _apiKey = Constants.apiKey;

  //fungsi yang bertujuan untuk membuat request get ke server
  Future<NewsResponse> getTopHeadlines({
    // mendefinisi parameter dalam fungsi
    String country = Constants.defaultCountry,
    String? category,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'apiKey' : _apiKey,
        'country' : country,
        'page' : page.toString(),
        'pageSize' : pageSize.toString(),
      };

      //statement yang akan dijalankan ketika kategori tidak kosong
      if (category != null && category.isNotEmpty) {
        queryParams['category'] = category;
      }
      //berfungsi untuk parsing data dari json ke UI
      // simplenya : kita daftarin baseUrl + endpoint yang akan digunakan 
      final uri = Uri.parse('$_baseUrl${Constants.topHeadlines}')
          .replace(queryParameters: queryParams);
      //untuk menyimoan respon yang diberikan oleh server
      final response = await http.get(uri);

      // kode yang akan dijalankan jika request ke API sukses
      if (response.statusCode ==200) {
        //untuk mengubah data dari json ke bahasa dart
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData);
      // kode yang akan dijalankan jika request ke API gagal (status http =! 200)
      } else {
        throw Exception('Failed to load news, please try again later');
      }
      //kode yang dijalan kan ketika terjadi error lain selain yang sudah dibuat diatas
      //e = error
    } catch (e) {
      throw Exception('Another problem occurs, please try agai, later');
    }
  }

  Future <NewsResponse> searchNews ({
    required String query,  // ini adalah nilai yang dimasukan ke kolom pencarian
    int page = 1, //ini untuk mendefinisikan halaman berita keberapa
    int pageSize = 20, // berapa banyak berita yang ingin ditampilakan ketika sekali proses rednering data
    String? sortBy, // ini adalah untuk mengurutkan berita berdasarkan apa
  }) async{
    try {
      final Map<String, String > queryParams = {
        'apiKey' : _apiKey,
        'q' : query,
        'page' : page.toString(),
        'pageSize' : pageSize.toString(),
      };

      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sortBy'] = sortBy;
      }

      final uri = Uri.parse('$_baseUrl${Constants.everything}')
          .replace(queryParameters: queryParams);

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load news, please try again later');
      }
    } catch (e) {
      throw Exception('Another problem occurs, please try again later');
    }
  }
}