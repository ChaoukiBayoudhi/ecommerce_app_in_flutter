class Address{
  int id;
  String houseNumber;
  String city;
  String state;
  String zip;
  String? country;

  Address({
    required this.id,
    required this.houseNumber,
    required this.city,
    required this.state,
    required this.zip,
    this.country="Tunisia",
  });

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
      id: json['id'],
      houseNumber: json['houseNumber'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'houseNumber': houseNumber,
      'city': city,
      'state': state,
      'zip': zip,
      'country': country,
    };
  }
}