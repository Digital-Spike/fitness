class TrainerModel {
  String? id;
  String? name;
  String? phoneNumber;
  String? category;
  String? branch;
  String? image;
  String? status;
  String? balance;
  String? description;
  String? rating;
  String? trainerId;
  String? branchId1;
  String? branchId2;
  String? branchId3;
  String? branchId4;
  String? branchId5;

  TrainerModel(
      {this.name,
      this.description,
      this.balance,
      this.branch,
      this.branchId1,
      this.branchId2,
      this.branchId3,
      this.branchId4,
      this.branchId5,
      this.category,
      this.id,
      this.image,
      this.phoneNumber,
      this.rating,
      this.status,
      this.trainerId});

  factory TrainerModel.fromMap(map) {
    return TrainerModel(
      name: map['name'],
      description: map['description'],
      balance: map['balance'],
      branch: map['branch'],
      branchId1: map['branchId1'],
      branchId2: map['branchId2'],
      branchId3: map['branchId3'],
      branchId4: map['branchId4'],
      branchId5: map['branchId5'],
      category: map['category'],
      id: map['id'],
      image: map['image'],
      phoneNumber: map['phoneNumber'],
      rating: map['rating'],
      status: map['status'],
      trainerId: map['trainerId']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'balance': balance,
      'branch': branch,
      'branchId1': branchId1,
      'branchId2': branchId2,
      'branchId3': branchId3,
      'branchId4': branchId4,
      'branchId5': branchId5,
      'category': category,
      'id': id,
      'image': image,
      'phoneNumber': phoneNumber,
      'rating': rating,
      'status': status,
      'trainerId': trainerId,
    };
  }
}
