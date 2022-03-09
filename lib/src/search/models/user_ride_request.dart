class UserRideRequest {
  UserRideRequest({
    this.id = '',
    this.userId = '',
    this.carId = '',
    this.fromCityId = '',
    this.fromLat = '',
    this.fromLong = '',
    this.toCityId = '',
    this.toLat = '',
    this.toLong = '',
    this.capacity = '',
    this.rate = '',
    this.bookedSeats = '',
    this.status = '',
    this.createdAt,
    this.updatedAt = '',
    this.pickUpTime = '',
    this.dropOffTime = '',
  });

  String id;
  String userId;
  String carId;
  String fromCityId;
  String fromLat;
  String fromLong;
  String toCityId;
  String toLat;
  String toLong;
  String capacity;
  String rate;
  String bookedSeats;
  String status;
  DateTime? createdAt;
  String updatedAt;
  String pickUpTime;
  String dropOffTime;

  factory UserRideRequest.fromJson(Map<String, dynamic> json) => UserRideRequest(
        id: json["id"],
        userId: json["user_id"],
        carId: json["car_id"],
        fromCityId: json["from_city_id"],
        fromLat: json["from_lat"],
        fromLong: json["from_long"],
        toCityId: json["to_city_id"],
        toLat: json["to_lat"],
        toLong: json["to_long"],
        capacity: json["capacity"],
        rate: json["rate"],
        bookedSeats: json["booked_seats"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        pickUpTime: json["pick_up_time"],
        dropOffTime: json["drop_off_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "car_id": carId,
        "from_city_id": fromCityId,
        "from_lat": fromLat,
        "from_long": fromLong,
        "to_city_id": toCityId,
        "to_lat": toLat,
        "to_long": toLong,
        "capacity": capacity,
        "rate": rate,
        "booked_seats": bookedSeats,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "pick_up_time": pickUpTime,
        "drop_off_time": dropOffTime,
      };
}
