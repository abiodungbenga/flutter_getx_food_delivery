import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! keep sending the request to the server for 30 seconds
class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
//! we need to declare sharedpreferences because we want to store the token with it
  late SharedPreferences sharedPreferences;

  //! storing data locally
  late Map<String, String> _mainHeaders;
  ApiClient({
    required this.appBaseUrl,
    required this.sharedPreferences,
  }) {
    baseUrl = appBaseUrl;
    timeout = const Duration(
      seconds: 30,
    );
    //! storing the token from shared preferences given it to the token variable and if
    //! it is null return an empty string '' that is if the token is not found
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? '';
    //! this is just trying to say i will give you some contents and the type is json
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
  //! function to get data or to send a get request to any uri from the Repo
  Future<Response> getData(String uri,
      //! trying to pass the header token and it could be empty ?
      //! using {} so they can be optional
      {Map<String, String>? headers}) async {
    try {
      //! if the user is logged in and have a token send the token unless dont send the token to
      //! the server
      Response response = await get(
        uri,
        //! if the header is empty send _mainheaders
        headers: headers ?? _mainHeaders,
        // query: q
      );
      return response;
    } catch (e) {
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  //! function to post data or to send a post request to any uri from the Repo and we are
  //! we are going to be using the request for a lot of other things not just for sign up sign in thats why we have dynamic
  Future<Response> postData(String uri, dynamic body) async {
    print(
      body.toString(),
    );
    //! try catch to send to server
    try {
      //! also  sending headers and saving the data in a response object
      //! anytime you see Future you need to add await
      Response response = await post(
        uri,
        body,
        headers: _mainHeaders,
      );
      print(
        response.toString(),
      );
      //! returning response

      return response;
    } catch (e) {
      print(e);
      //! we need to to tell flutter or our ui or response error to our form validation this response is from getx
      return Response(
        statusCode: 1,
        statusText: e.toString(),
      );
    }
  }

  //! function to update the Header for the token and post request
  //! because the token will be empty but when you sign in it will be updated
  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
}
