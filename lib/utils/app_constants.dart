class AppConstants {
  static const String APP_NAME = 'FoodDelivery';
  static const int APP_VERSION = 1;

  static const String BASE_URL = 'http://192.168.204.2/delivery_app_backend';
  static const String POPULAR_PRODUCT_URI = '/public/api/products/popular';
  static const String RECOMMENDED_PRODUCT_URI =
      '/public/api/products/recommended';
  //! auth endpoint
  static const String REGISTRATION_URI = '/public/api/register';
  static const String LOGIN_URI = '/public/api/login';
  static const String USER_INFO_URI = '/public/api/user-info';

  static const String UPLOAD_URL = '/storage/app/public/';
  //! if there is a token from the database we saved it otherwise it will still be empty
  static const String TOKEN = '';

  static const String EMAIL = '';
  static const String PASSWORD = '';
  static const String CARTLIST = 'Cart-List';
  static const String CARTHISTORYLIST = 'Cart-History-List';
}
