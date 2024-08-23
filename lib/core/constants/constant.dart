import 'package:flutter/material.dart';

const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
const String apiKey = 'API_KEY'; // api key will get in spooncular api
const String imageUrl = 'https://spoonacular.com/cdn/ingredients_100x100/';
const String ingredientUrl = 'https://www.themealdb.com/images/ingredients/';
//const String loadingGif = 'assets/images/loading.gif';

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kSecondary),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kSecondary),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
  ),
  filled: true,
  fillColor: Colors.white,
  //suffixIcon: Icon(Icons.search, color: kSecondary),
  hintText: 'Enter Ingredients',
);

const kTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontFamily: 'Poppins-Regular',
  fontWeight: FontWeight.bold,
);

const kPrimary = Color(0xffFAF8F4);
const kSecondary = Color(0xff30768a);
const kGreyColor = Color(0xffF3F7FA);
const kTextColor = Color(0xffc4c4c4);
const kBgroundColor = Color(0xffF8F8F8);
const kIconColor = Color.fromARGB(255, 72, 90, 157);