class CaseModel {
  final String id;
  final String title;
  final String client;
  final String status;
  final String reviewDate;
  final String phone;
  final String details;
  final DateTime? createdAt;

  CaseModel({
    required this.id,
    required this.title,
    required this.client,
    required this.status,
    required this.reviewDate,
    required this.phone,
    required this.details,
    this.createdAt,
  });

  factory CaseModel.fromJson(Map<String, dynamic> json) {
    return CaseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      client: json['client'] ?? '',
      status: json['status'] ?? '',
      reviewDate: json['reviewDate'] ?? '',
      phone: json['phone'] ?? '',
      details: json['details'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'client': client,
      'status': status,
      'reviewDate': reviewDate,
      'phone': phone,
      'details': details,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  CaseModel copyWith({
    String? id,
    String? title,
    String? client,
    String? status,
    String? reviewDate,
    String? phone,
    String? details,
    DateTime? createdAt,
  }) {
    return CaseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      client: client ?? this.client,
      status: status ?? this.status,
      reviewDate: reviewDate ?? this.reviewDate,
      phone: phone ?? this.phone,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
