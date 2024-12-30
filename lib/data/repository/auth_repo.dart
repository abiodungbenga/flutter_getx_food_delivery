import 'package:food_delivery_app/models/login_body_model.dart';
import 'package:food_delivery_app/models/signup_body_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_delivery_app/data/api/api_client.dart';

class AuthRepo {
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  //! taking api client variable
  final ApiClient apiClient;

  //! we also want to create a shared preference object because of the token we want to save it in our app
  final SharedPreferences sharedPreferences;

  Future<Response> registration(SignUpBody signUpBody) async {
    //! calling the api client so we can post the data the endpoint will be placed in uri
    return await apiClient.post(
      AppConstants.REGISTRATION_URI,
      //! converting the sigUpbody model to json so we can post the object as json
      signUpBody.toJson(),
    );
  }

//! because this  has only two fields that is why we did not create a model like sign in body for it
//! creating function for login post request and passing in the email and password
  Future<Response> login(LoginBody loginBody) async {
    //! calling the api client so we can post the data the endpoint will be placed in uri
    return await apiClient.post(
      AppConstants.LOGIN_URI,
      //! creating the body for the request and manually converting to json
      loginBody.toJson(),
    );
  }

  //! create a method to get user token
  Future<String> getUserToken() async {
    //! get the token as string if it doesnt exist return null
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? '';
  }

  //! create a method to know if the user is logged in or not
  bool userLoggedIn() {
    //! get the token as bool thats why we used contains key it returns a bool
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  //! creating a method to save user token with shared preferences
  //! it has a type of future boolean
  Future<bool> saveUserToken(String token) async {
    //! inserting the token the real one
    apiClient.token = token;
    //! when inserting your token you need to also update your headers and sending the token to the update header function
    apiClient.updateHeader(token);

    //! save the token with shared preferences
    return await sharedPreferences.setString(
      AppConstants.TOKEN,
      token,
    );
  }

  //! function to save user email and password or information
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      //! save to our local storage
      //! save the email with shared preferences
      await sharedPreferences.setString(
        AppConstants.EMAIL,
        email,
      );
      //! save the password with shared preferences
      await sharedPreferences.setString(
        AppConstants.PASSWORD,
        password,
      );
    } catch (e) {
      print(e);
    }
  }

//! function to clear the data we stored with shared preferences
  bool clearSharedData() {
    //! when the user logs out none of this information should be kept
    sharedPreferences.remove(
      AppConstants.TOKEN,
    );
    sharedPreferences.remove(
      AppConstants.PASSWORD,
    );
    sharedPreferences.remove(
      AppConstants.EMAIL,
    );
    //! make sure the api client token is empty
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
