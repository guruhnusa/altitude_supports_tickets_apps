class TicketParam {
  String? id;
  final String title;
  final String description;
  String? status;
  TicketParam({
     this.id,
    required this.title,
    required this.description,
    this.status,
  });
}
