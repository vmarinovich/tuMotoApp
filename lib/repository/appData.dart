import 'package:flutter/cupertino.dart';
import 'package:tu_moto_app/repository/address.dart';


class AppData extends ChangeNotifier{

  Address pickUpLocation;
  Address dropOffLocation;

  void updatePickupAddress(Address pickupAddress) {
    pickUpLocation = pickupAddress;
    notifyListeners();
  }

void updateDropOffAddress(Address dropOffAddress) {
  dropOffLocation = dropOffAddress;
  notifyListeners();
}
}