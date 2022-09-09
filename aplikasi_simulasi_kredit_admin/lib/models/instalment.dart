class Instalment {
  Instalment({
    required this.total,
    required this.period,
    required this.interest,
    required this.remaining,
    required this.primary,
    required this.status
  });

  double total;
  String period;
  double interest;
  double remaining;
  double primary;
  String status;

  factory Instalment.fromJson(Map<String, dynamic> json) => Instalment(
        total: json["total"],
        period: json["period"],
        interest: json["interest"],
        remaining: json["remaining"],
        primary: json["primary"],
        status: json["status"]
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "period": period,
        "interest": interest,
        "remaining": remaining,
        "primary": primary,
        "status": status
      };
}
