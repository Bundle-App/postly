import 'dart:math';

import 'package:Postly/data/repository/data_repository/user_services.dart';
import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/models/address/address.dart';
import 'package:Postly/models/company/company.dart';
import 'package:Postly/models/geo/geo.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class UserServicesMock extends Mock implements UserServices {}

class HiveRepositoryMock extends Mock implements HiveRepository {}

main() {
  List<User> testUsers = [
    User(
        id: 1,
        email: "ade@yahoo.com",
        username: "ade",
        address: Address(
          suite: "120",
          city: "lagos",
          street: "jide",
          zipcode: "101234",
          geo: Geo(lat: "-101", lng: "020"),
        ),
        phone: "050837282",
        website: "www.fb.com",
        company: Company(name: "over", catchPhrase: "yeah", bs: "yhh"),
        points: 0),
    User(
        id: 2,
        email: "ade@yahoo.com",
        username: "john",
        address: Address(
          suite: "12",
          city: "lagoos",
          street: "jide ken",
          zipcode: "10124",
          geo: Geo(lat: "-101", lng: "020"),
        ),
        phone: "0980837282",
        website: "www.fbk.com",
        company: Company(name: "over", catchPhrase: "yeah", bs: "yhh"),
        points: 0),
    User(
        id: 3,
        email: "ade@gmail.com",
        username: "swee",
        address: Address(
          suite: "156",
          city: "ssuru",
          street: "peter",
          zipcode: "123101",
          geo: Geo(lat: "-101", lng: "020"),
        ),
        phone: "050837282",
        website: "www.fb.com",
        company: Company(name: "over", catchPhrase: "yeah", bs: "yhh"),
        points: 0),
    User(
        id: 4,
        email: "ade@yahoo.com",
        username: "ade",
        address: Address(
          suite: "120",
          city: "lagos",
          street: "jide",
          zipcode: "101234",
          geo: Geo(lat: "-101", lng: "020"),
        ),
        phone: "050837282",
        website: "www.fb.com",
        company: Company(name: "over", catchPhrase: "yeah", bs: "yhh"),
        points: 0)
  ];

  User user;
  UserServicesMock userService = UserServicesMock();
  HiveRepositoryMock hiveRepository = HiveRepositoryMock();

  group('Testing get user, picking a random user and saving the user locally',
      () {
    test('Testing get user to see if it returns list of user object', () async {
      when(userService.getUsers()).thenAnswer((_) async => testUsers);
      var result = await userService.getUsers();
      expect(result, testUsers);
      verify(userService.getUsers());
      verifyNoMoreInteractions(userService);
    });

    test('Test to get a random number', () {
      Random random = Random();
      int randomNum = random.nextInt(testUsers.length);
      user = testUsers[randomNum];
      expect(user, testUsers[randomNum]);
    });

    test('Test to add the user with current point into local database', () {
      when(hiveRepository.add<User>(key: kUser, name: kUserBox))
          .thenAnswer((_) async => user);
      // HiveRepository hiveImpl = HiveRepository();
      //var result = await postService.getPosts();
      //     expect(result, testPosts);
      //     verify(postService.getPosts());
      //     verifyNoMoreInteractions(postService);
      hiveRepository.add<User>(key: kUser, name: kUserBox);
      // expect(result, newUser);
      verify(hiveRepository.add<User>(key: kUser, name: kUserBox));
      verifyNoMoreInteractions(hiveRepository);
    });
  });
}
