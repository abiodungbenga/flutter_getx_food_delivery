import 'package:food_delivery_app/models/popular_products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({
    required this.recommendedProductRepo,
  });
  List<dynamic> _recommendedProductList = [];
  //! we need this method to accept the data
  List<dynamic> get recommendedProductsList => _recommendedProductList;
  //! setting up a boolean for the preloaded
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getrecommendedProductsList();
    if (response.statusCode == 200) {
      print('got the request');
      // print(response.body);
      // print(_popularProductList);
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      //! this is just like set state
      _isLoaded = true;
      update();
    } else {
      print(
        'could not get the request',
      );
      //! if it fails
    }
  }
}
