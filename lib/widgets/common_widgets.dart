import 'package:ui_app/utils/validators.dart';

import '../utils/path_provider.dart';

Widget loadingImage(String url, {double? height, double? width}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.network(
      url,
      fit: BoxFit.cover,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    ),
  );
}

Widget buildSearchBar(BuildContext context, double screenWidth,
    double screenHeight, double textScale) {
  double titleFontSize = screenWidth * 0.065 * textScale;
  double labelFontSize = screenWidth * 0.035 * textScale;
  double textFieldHeight = screenHeight * 0.08;
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.04,
      vertical: screenHeight * 0.02,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore the world! By\nTraveling',
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
          textScaleFactor: textScale,
        ),
        SizedBox(height: screenHeight * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                height: textFieldHeight,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: screenWidth * 0.06,
                    ),
                    labelText: 'Where did you go?',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: labelFontSize,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Container(
              width: screenWidth * 0.13,
              height: screenWidth * 0.13,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.filter_list,
                  color: Colors.black,
                  size: screenWidth * 0.08,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildPopularLocations(BuildContext context, double screenWidth,
    double screenHeight, double textScale) {
  double titleFontSize = screenWidth * 0.05 * textScale;
  double itemFontSize = screenWidth * 0.04 * textScale;

  double containerHeight = screenHeight * 0.2;
  double itemWidth = screenWidth * 0.3;

  return Container(
    width: screenWidth,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Text(
            'Popular Locations',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: containerHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: houses.length,
            itemBuilder: (context, index) {
              return Container(
                width: itemWidth,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    loadingImage(
                      houses[index].imageUrl,
                      height: containerHeight,
                      width: itemWidth,
                    ),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      child: Text(
                        houses[index].location,
                        style: getTextStyle(
                          fontSize: itemFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildRecommended(BuildContext context, double screenWidth,
    double screenHeight, double textScale) {
  double titleFontSize = screenWidth * 0.05 * textScale;
  double priceFontSize = screenWidth * 0.035 * textScale;
  double ratingFontSize = screenWidth * 0.025 * textScale;
  double nameFontSize = screenWidth * 0.04 * textScale;
  double bedroomFontSize = screenWidth * 0.03 * textScale;

  double containerHeight = screenHeight * 0.20;
  double itemWidth = screenWidth * 0.5;

  return Container(
    width: screenWidth,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Text(
            'Recommended',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: containerHeight,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: houses.length,
            itemBuilder: (context, index) {
              double dynamicItemWidth = itemWidth;
              double dynamicContainerHeight = containerHeight;

              if (houses.length < 3) {
                dynamicItemWidth = screenWidth * 0.7;
                dynamicContainerHeight = screenHeight * 0.4;
              } else if (houses.length == 3) {
                dynamicItemWidth = screenWidth * 0.55;
                dynamicContainerHeight = screenHeight * 0.35;
              }

              return Container(
                width: dynamicItemWidth,
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        loadingImage(
                          houses[index].houseUrl,
                          height: dynamicContainerHeight * 0.52,
                          width: dynamicItemWidth,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(screenWidth * 0.02),
                            width: screenWidth * 0.08,
                            height: screenWidth * 0.08,
                            child: const Center(
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${houses[index].price}/Night",
                          style: getTextStyle(
                            fontSize: priceFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Icon(
                                  Icons.star,
                                  color: Colors.red,
                                  size:
                                      screenWidth * 0.04, // Adjusted icon size
                                ),
                              ),
                              TextSpan(
                                text: houses[index].rating,
                                style: getTextStyle(
                                  fontSize:
                                      ratingFontSize, // Adjusted font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      houses[index].houseName,
                      style: getTextStyle(
                        fontSize: nameFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Private Bedroom/${houses[index].bedroomCount}",
                      style: getTextStyle(
                        fontSize: bedroomFontSize,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildHostingAd(BuildContext context, double screenWidth,
    double screenHeight, double textScale) {
  double titleFontSize = screenWidth * 0.06 * textScale;
  double buttonFontSize = screenWidth * 0.04 * textScale;

  return Container(
    color: Colors.white,
    height: screenHeight * 0.35,
    width: screenWidth,
    child: Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: loadingImage(
              hosting,
              height: screenHeight * 0.35,
              width: screenWidth,
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.05,
          left: screenWidth * 0.05,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Hosting fee for \n as low as 1%\n",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                WidgetSpan(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pink,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.015,
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Become a host",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: buttonFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildMostViewed(BuildContext context, double screenWidth,
    double screenHeight, double textScale) {
  double fontSizeFactor = screenWidth / 375;
  double screenHeightFactor = screenWidth > 418 ? screenWidth / 418 : 1.0;
  double ratingFontSize = screenWidth * 0.035 * textScale;

  return Container(
    width: screenWidth,
    color: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Text(
              'Most Viewed',
              style: TextStyle(
                fontSize: 22 * fontSizeFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: screenWidth,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: houses.length,
              itemBuilder: (context, index) {
                return Container(
                  height: screenHeight * 0.3 * screenHeightFactor,
                  width: screenWidth,
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                houses[index].houseUrl,
                                fit: BoxFit.cover,
                                height:
                                    screenHeight * 0.18 * screenHeightFactor,
                                width: screenWidth,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.all(screenWidth * 0.02),
                                width: screenWidth * 0.08, // Adjust for scaling
                                height:
                                    screenWidth * 0.08, // Adjust for scaling
                                child: const Center(
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${houses[index].price}/Night",
                              style: TextStyle(
                                fontSize: 12 * fontSizeFactor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.red,
                                      size: screenWidth *
                                          0.035, // Adjust icon size
                                    ),
                                  ),
                                  TextSpan(
                                    text: houses[index].rating,
                                    style: getTextStyle(
                                      fontSize:
                                          ratingFontSize, // Adjusted font size
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          houses[index].houseName,
                          style: TextStyle(
                            fontSize: 17 * fontSizeFactor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          "Private Bedroom/${houses[index].bedroomCount}",
                          style: TextStyle(
                            fontSize: 10 * fontSizeFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget logoWidget(
    {double height = 100.0, double width = 100.0, double radius = 100.0}) {
  return SizedBox(
    height: height,
    width: width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(radius), // Adjust corner radius
      child: SvgPicture.asset(
        'assets/logo.svg',
        width: 100,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget textInputField({
  required TextEditingController controller,
  int maxlength = 100,
  bool? obsureText,
  TextInputType? type,
  Validator validate = Validator.name,
  String fieldName = "",
  int min = 0,
  int max = 0,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obsureText ?? false,
    maxLength: maxlength,
    showCursor: true,
    cursorColor: black,
    validator: (value) {
      validation(validate, value!, fieldName, min, max);
    },
    decoration: InputDecoration(
      counterText: "",
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );
}

Widget buttonField({
  double height = 50.0,
  double width = 100.0,
  double radius = 10,
  Color? color,
  String input = " ",
  required VoidCallback onPressed,
  TextStyle? style,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: color ?? primary.withValues(alpha: 0.01),
        border: Border.all(color: black, width: 2.0),
        borderRadius: BorderRadius.circular(radius)),
    child: TextButton(
      onPressed: onPressed,
      child: Text(input, style: style ?? interRegular()),
    ),
  );
}

Widget imageButton({
  double height = 50.0,
  double width = 50.0,
  double borderRadius = 10.0,
  double padding = 2.0,
  String image = "",
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Image.asset(image),
            ))),
  );
}
