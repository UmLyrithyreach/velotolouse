
import 'package:velotolouse/model/bike/bike.dart';

class BikeDto{
  static Bike fromFireStore(String id ,Map<String, dynamic> map){
    return Bike(
      bikeId: id,
      name: map['name'],
      type: map['type'],
      status: map['status'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  static Map<String, dynamic> toFireStore(Bike bike){
    return {
      'name': bike.name,
      'type': bike.type,
      'status': bike.status,
      'latitude': bike.latitude,
      'longitude': bike.longitude,
    };
  }
}