# Postly

![ci](https://github.com/debbsefe/postly/actions/workflows/main.yml/badge.svg) [![codecov](https://codecov.io/gh/debbsefe/postly/branch/Mamus/graph/badge.svg?token=MX81M83W53)](https://codecov.io/gh/debbsefe/postly)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

## Table of Contents

- [Introduction](#introduction)
- [Screenshots](#screenshots)
- [Installing](#Installing)
- [Installing](#App-Development-Info)
- [Plugins](#Plugins)

# Introduction

## _Project Overview_

Postly a social app that lets you share your thoughts and get
comments from the community.

# Screenshot

![Beginner](https://github.com/debbsefe/postly/blob/media/beginner.jpeg?raw=true)

![Create Post](https://github.com/debbsefe/postly/blob/media/create_post.jpeg?raw=true)

![Post created](https://github.com/debbsefe/postly/blob/media/post_created.jpeg?raw=true)

![Professional](https://github.com/debbsefe/postly/blob/media/professional.jpeg?raw=true)

![Postly Legend](https://github.com/debbsefe/postly/blob/media/postly_legend.jpeg?raw=true)

# Installing

#### _Prerequisites_

Ensure you have **Flutter** installed by entering `flutter -v` on your terminal
If you don't have **Flutter** installed, go to the [Flutter Website](http://flutter.dev), and follow the download instructions

To install this app

`git clone https://github.com/debbsefe/postly`

And install the required dependencies

`flutter pub get`

Run the app

`flutter run --no-sound-null-safety`

## Running the tests

To run test cases

`flutter test --no-sound-null-safety`

# App-Development-Info

_Folder Structure_

- core: contains all files that are reused throughout the app

  - error: exceptions and failure classes are located here
  - utils: general classes and constants used throughout the app are located here, such as app strings, extensions, app colors etc.

- feature: each feature that are available in the app are included here, and separated as folders

  - data: all calls made to the remote data/api are included here
  - domain: represents bridge between the data layer and presentation layer, here all abstractions are made before being sent to the presentation layer
  - presentation: includes all classes and methods that make up the screens/pages of the app.

  ## Plugins

| Name                                                                  | Usage                               |
| --------------------------------------------------------------------- | ----------------------------------- |
| [**Flutter Riverpod**](https://pub.dev/packages/flutter_riverpod)     | State Management                    |
| [**Shared Preferences**](https://pub.dev/packages/shared_preferences) | Local cache/storage for simple data |
| [**Get It**](https://pub.dev/packages/get_it)                         | Dependency injection                |
| [**Dartz**](https://pub.dev/packages/dartz)                           | Functional programming in Dart      |
