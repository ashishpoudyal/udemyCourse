import 'package:flutter_application_udemy_mvvm/app/extensions.dart';
import 'package:flutter_application_udemy_mvvm/data/responses/responses.dart';

//toc convert the response into a non nullable object (model)

import '../../domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id?.orEmpty() ?? EMPTY,
        this?.name?.orEmpty() ?? EMPTY,
        this?.numOfNotifications?.orZero() ?? ZERO);
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email?.orEmpty() ?? EMPTY,
      this?.phone?.orEmpty() ?? EMPTY,
      this?.link?.orEmpty() ?? EMPTY,
    );
  }
}

extension AuthenticationMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.contact?.toDomain(),
      this?.customer?.toDomain(),
    );
  }
}
