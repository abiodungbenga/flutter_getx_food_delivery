import 'package:food_delivery_app/data/repository/auth_repo.dart';
import 'package:food_delivery_app/data/repository/user_repo.dart';
import 'package:food_delivery_app/models/login_body_model.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:get/get.dart';

//! because we want to use repo thats why we are calling getx service
class UserController extends GetxController implements GetxService {
  UserController({required this.userRepo});

  //! injecting the repo inside the controller or creating auth repo instance
  final UserRepo userRepo;

  //! to check if its loading or not
  bool _isLoading = false;
  //! creating an instance of user model so whatever data we get we save it in the user mode
  //! so we can use it in our UI Files
  UserModel? _userModel;

  //! want to also get if its loading or not
  bool get isLoading => _isLoading;
  //! creating a getter for userModel
  UserModel? get userModel => _userModel;

  //! creating a registration method

  //! taking sign up body as object or parameter
  //! make sure to always set your function type it is a type of response model
  Future<ResponseModel> getUserInfo() async {
    //! call the actual registration method to the repo or the repository function which will call to the api client
    //! calling the registration method from the auth repo and passing the model in it and saving it to a response object
    Response response = await userRepo.getUserInfo();

    //! instanciating the response model
    late ResponseModel responseModel;
    print(
      response.body.toString(),
    );
    //! check our response type if it is 201 that is successful or if it is not
    if (response.statusCode == 200) {
      //! from json we convert to an object then save in userModel variable and used the getter
      //! to get the data to out UI
      _userModel = UserModel.fromJson(response.body);
      print(
        'getting info.....',
      );
      //! ounce you have a status code of 201 let it load
      _isLoading = true;

      //! initializing the response model based on our status that means nothing went wrong
      responseModel = ResponseModel(
        true,
        'Successful',
      );
    } else {
      print(
        'could not get data',
      );
      //! but if things went wrong
      responseModel = ResponseModel(
        false,
        response.statusText!,
      );
    }

    //! calling the update method because our front end will be reactive
    update();
    //! returning the response model
    return responseModel;
  }
}
