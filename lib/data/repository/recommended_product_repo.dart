import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/data/api/api_client.dart';

//! when loading data from the internet your class should exteend getx service
class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({
    required this.apiClient,
  });
  Future<Response> getrecommendedProductsList() async {
    return await apiClient.get(
      AppConstants.RECOMMENDED_PRODUCT_URI,
    );
  }
}
