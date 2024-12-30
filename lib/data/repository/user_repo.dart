import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({
    required this.apiClient,
  });

  //! function to get user information
  //! type of future response and used async and await because we are fetching from internet
  Future<Response> getUserInfo() async {
    return await apiClient.getData(
      AppConstants.USER_INFO_URI,
    );
  }
}
