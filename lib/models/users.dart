class Users {
  Users(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.city,
      required this.country,
      required this.address,
      required this.date_joined,
      required this.date_of_birth,
      required this.department,
      required this.gender,
      required this.job_title,
      required this.last_joined,
      required this.manager,
      this.profile_picture,
      required this.status});

  final int id;
  final String name;
  final String email;
  final String phone;
  final String city;
  final String country;
  final String status;
  final String address;
  final String date_of_birth;
  final String gender;
  final String job_title;
  final String department;
  final String manager;
  final String date_joined;
  final String last_joined;
   String? profile_picture;
  
factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      address: map['address'] ?? '',
      date_of_birth: map['date_of_birth'] ?? '',
      gender: map['gender'] ?? '',
      job_title: map['job_title'] ?? '',
      department: map['department'] ?? '',
      manager: map['manager'] ?? '',
      date_joined: map['date_joined'] ?? '',
      last_joined: map['last_joined'] ?? '',
      profile_picture: map['profile_picture'],
      status: map['status'] ?? '',
    );
  }
   
 
}
