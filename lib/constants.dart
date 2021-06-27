import 'package:flutter/rendering.dart';

class BTConstants {
  static const String BASE_URL = 'https://api.notion.com/v1';
}

class BTUI {
  //EDGE INSETS
  static const EdgeInsets edge8 = const EdgeInsets.all(8.0);
  static const EdgeInsets edge16 = const EdgeInsets.all(16.0);

  //BORDER RADIUS
  static final BorderRadius radius10 = BorderRadius.circular(10.0);

  //1D VALUES
  static const double PIE_CHART_HEIGHT = 360.0;
  static const double PIE_CHART_RADIUS = 100.0;
  static const double PIE_CHART_SPACE = 4.0;
  static const double PIE_CHART_FONT_SIZE = 12.0;

  static const double SECTION_MARGIN = 20.0;
  static const double LEGEND_SPACING = 8.0;
  static const double LEGEND_SIZE = 16.0;
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

  //TOOLTIP
  static const String ADD_TRANSACTION = "Add transaction";
}
