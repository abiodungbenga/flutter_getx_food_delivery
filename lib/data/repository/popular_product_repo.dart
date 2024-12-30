import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/data/api/api_client.dart';

//! when loading data from the internet your class should exteend getx service
class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({
    required this.apiClient,
  });
  Future<Response> getPopularProductsList() async {
    return await apiClient.get(
      AppConstants.POPULAR_PRODUCT_URI,
    );
  }
}
