class BranchModel {
  String? id;
  String? branchId;
  String? branch;
  String? phoneNumber;
  String? address;
  String? email;
  String? gpsLat;
  String? image;
  String? status;
  String? gpsLong;

  BranchModel(
      {this.id,
        this.branchId,
        this.branch,
        this.phoneNumber,
        this.address,
        this.email,
        this.gpsLat,
        this.image,
        this.status,
        this.gpsLong});

  factory BranchModel.fromMap(map) {
    return BranchModel(
        id: map['id'],
        branchId: map['branchId'],
        branch: map['branch'],
        phoneNumber: map['phoneNumber'],
        address: map['address'],
        email: map['email'],
        gpsLat: map['gpsLat'],
        image: map['image'],
        status: map['status'],
        gpsLong: map['gpsLong'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'branchId': branchId,
      'branch': branch,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
      'gpsLat': gpsLat,
      'image': image,
      'status': status,
      'gpsLong': gpsLong,
    };
  }
}
