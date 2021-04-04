
import 'package:geolocator/geolocator.dart';
import 'package:tu_moto_app/bloc/requestAssistant.dart';

import '../configMaps.dart';

class AssistantMethod
{
  static Future<String> searchCoordinateAddress(Position position) async
  {
    String placeAddress = '';
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';

    var response = await RequestAssistant.getRequest(Uri.parse(url));
    if(response != 'failed')
      {
        placeAddress = response['results'][0]['formatted_address'];
      }
    return placeAddress;
  }
}