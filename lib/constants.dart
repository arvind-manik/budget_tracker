import 'package:flutter/rendering.dart';

class BTConstants {
  static const String BASE_URL = 'https://api.notion.com/v1/';
}

class BTUI {
  //MARGINS
  static const EdgeInsets margin2 = const EdgeInsets.all(8.0);

  //BORDER RADIUS
  static final BorderRadius radius10 = BorderRadius.circular(10.0);

  //BORDER
}

class BTAPIKeys {
  static const String RESULTS = 'results';
  static const String PROPERTIES = 'properties';
  static const String NAME_TC = 'Name';
  static const String NAME = 'name';
  static const String DATE_TC = "Date";
  static const String DATE = "date";
  static const String START = "start";
  static const String CATEGORY_TC = "Category";
  static const String SELECT = 'select';
  static const String PLAIN_TEXT = 'plain_text';
  static const String PRICE_TC = 'Price';
  static const String NUMBER = 'number';
  static const String TITLE = 'title';
}

class BTResource {
  //ERRORS
  static const String GENERIC_FAILURE = 'Something went terribly wrong!';
  static const String REQUEST_FAILURE =
      'Unable to access your data right now. Please try again later!';

  //UI RESOURCES
  static const String FALLBACK_QMARK = '?';
  static const String FALLBACK_UNKNOWN = 'Unknown';
}
