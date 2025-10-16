import 'package:get/get.dart';
import 'package:tempo_app/models/news_articles.dart';
import 'package:tempo_app/services/news_services.dart';

class NewsController extends GetxController {
  // untuk memprosres request yang sudah dibuat oleh newsservces
  final NewsService _newsService = NewsService();

  final _isLoading = false.obs;
  final _articles = <NewsArticles>[] .obs;
}