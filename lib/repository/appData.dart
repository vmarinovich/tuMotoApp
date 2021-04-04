import 'package:flutter/cupertino.dart';
import 'package:tu_moto_app/repository/address.dart';

import '';
class AppData extends ChangeNotifier{

  Address pickupAddress;
  Address destinationAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }}