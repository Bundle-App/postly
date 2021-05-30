import 'dart:ui';
import 'package:flutter/material.dart';

//hive repository names
const String kUserBox = 'user_box';
const String kUser = 'user';
const String kPostBox = 'post_box';
const String kPosts = 'post';

//Colors
const Color kPrimaryColor = Color(0xff4B75BF);
const Color kBackground = Color(0xffF4F4F4);
const Color kSubTextColor = Color(0xffACACAC);

//screen routes
const POST_SCREEN_ROUTE = "/post";
const CREATE_POST_ROUTE = "/create_post";

//text styles
const TextStyle kTextStyle =
    TextStyle(fontWeight: FontWeight.w400, fontSize: 15);

const TextStyle kAppBarTextStyle = TextStyle(fontWeight: FontWeight.w500);

const TextStyle kSubTextStyle = TextStyle(fontSize: 13, color: kSubTextColor);

const TextStyle kHintTextStyle = TextStyle(color: kSubTextColor, fontSize: 13);
