import 'package:Postly/data/repository/database/hive_repository.dart';
import 'package:Postly/models/address/address.dart';
import 'package:Postly/models/company/company.dart';
import 'package:Postly/models/geo/geo.dart';
import 'package:Postly/models/user/user.dart';
import 'package:Postly/utils/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class HiveRepositoryMock extends Mock implements HiveRepository {}

void main() async {
  HiveRepositoryMock hiveRepository = HiveRepositoryMock();

  User newUser = User(
      id: 2,
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
      points: 0);

  group(
      'Test create post function which gets hive user, adds 2 points and updates the local db',
      () {
    test('Test to get a user from local database', () {
      when(hiveRepository.get<User>(key: kUser, name: kUserBox))
          .thenReturn(newUser);
      // HiveRepository hiveImpl = HiveRepository();
      var result = hiveRepository.get<User>(key: kUser, name: kUserBox);
      expect(result, newUser);
      verify(hiveRepository.get<User>(key: kUser, name: kUserBox));
      verifyNoMoreInteractions(hiveRepository);
    });

    test("Test to increment user points when post is created", () {
      int currentPoint = newUser.points;
      newUser.points += 2;
      expect(newUser.points, currentPoint + 2);
    });

    test('Test to add the user with current point into local database', () {
      when(hiveRepository.add<User>(key: kUser, name: kUserBox))
          .thenAnswer((_) async => newUser);
      hiveRepository.add<User>(key: kUser, name: kUserBox);
      verify(hiveRepository.add<User>(key: kUser, name: kUserBox));
      verifyNoMoreInteractions(hiveRepository);
    });
  });
}

// void _removeRegisterionIfExist<T>() {
//   if (locator.isRegistered<T>()) {
//     locator.unregister<T>();
//   }
// }
