class  PlacePredicitions
{
  String secondaryText;
  String mainText;
  String placeId;

  PlacePredicitions({this.secondaryText,this.mainText,this.placeId});
  PlacePredicitions.fromJson(Map<String, dynamic> json)
  {
    placeId = json['place_id'];
    mainText = json['structured_formatting']['main_text'];
    secondaryText = json['structured_formatting']['secondary_text'];
  }
}