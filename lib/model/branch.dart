class BranchModel {
  String? id;
  String? branchName;
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
      this.branchName,
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
      branchName: map['branchName'],
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
      'branchName': branchName,
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
