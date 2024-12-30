import 'package:food_delivery_app/data/repository/auth_repo.dart';
import 'package:food_delivery_app/models/login_body_model.dart';
import 'package:food_delivery_app/models/response_model.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:get/get.dart';

//! because we want to use repo that's why we are calling getx service
class AuthController extends GetxController implements GetxService {
  AuthController({required this.authRepo});

  //! injecting the repo inside the controller or creating auth repo instance
  final AuthRepo authRepo;

  //! to check if its loading or not
  bool _isLoading = false;

  //! want to also get if its loading or not
  bool get isLoading => _isLoading;

  //! creating a registration method

  //! taking sign up body as object or parameter
  //! make sure to always set your function type it is a type of response model
  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    //! setting _isLoading to true because ounce this function is called it means we have started talking to the server
    _isLoading = true;
    //! calling the update method because our front end will be reactive
    update();
    //! call the actual registration method to the repo or the repository function which will call to the api client
    //! calling the registration method from the auth repo and passing the model in it and saving it to a response object
    Response response = await authRepo.registration(signUpBody);

    //! instanciating the response model
    late ResponseModel responseModel;
    //! check our response type if it is 201 that is successful or if it is not
    if (response.statusCode == 201) {
      print('registering the user....');
      //! want to save the token locally from the response body
      //! pointing to the token from server response
      authRepo.saveUserToken(
        response.body['user']["token"],
      );
      //! initializing the response model based on our status that means nothing went wrong
      responseModel = ResponseModel(
        true,
        response.body['user']["token"],
      );
    } else {
      //! but if things went wrong
      responseModel = ResponseModel(
        false,
        response.statusText!,
      );
    }
    //! set is loading to false when it is done sending the request
    _isLoading = false;
    //! calling the update method because our front end will be reactive
    update();
    //! returning the response model
    return responseModel;
  }

  Future<ResponseModel> login(LoginBody loginBody) async {
    print('Getting the token');
    //! function to get the user token being called printing  the token from the function
    print(
      authRepo.getUserToken().toString(),
    );
    //! setting _isLoading to true because ounce this function is called it means we have started talking to the server
    _isLoading = true;
    //! calling the update method because our front end will be reactive
    update();
    //! call the actual login method to the repo or the repository function which will call to the api client
    //! calling the login method from the auth repo and email and password because there is no sign up body model
    Response response = await authRepo.login(
      loginBody,
    );

    //! instanciating the response model
    late ResponseModel responseModel;
    //! check our response type if it is 201 that is successful or if it is not
    if (response.statusCode == 201) {
      print('Backend Token');

      //! want to save the token locally from the response body
      //! pointing to the token from server response
      authRepo.saveUserToken(
        response.body['user']["token"],
      );
      //! printing the token for debugging purposes
      print(
        'token is' + response.body['user']["token"].toString(),
      );
      //! initializing the response model based on our status that means nothing went wrong
      responseModel = ResponseModel(
        true,
        response.body['user']["token"],
      );
    } else {
      //! but if things went wrong
      responseModel = ResponseModel(
        false,
        response.statusText!,
      );
    }
    //! set is loading to false when it is done sending the request
    _isLoading = false;
    //! calling the update method because our front end will be reactive
    update();
    //! returning the response model
    return responseModel;
  }

  //! function to save user email and password or information
  void saveUserEmailAndPassword(String email, String password) {
    try {
      //! calling the authrepo function with this we can call it in our UI when we need it
      authRepo.saveUserEmailAndPassword(email, password);
    } catch (e) {
      print(e);
    }
  }

  bool userLoggedIn() {
    //! calling the userLogged in function from the auth repository
    return authRepo.userLoggedIn();
  }

  //! function to clear stored data from the auth repository and from shared preferences
  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
