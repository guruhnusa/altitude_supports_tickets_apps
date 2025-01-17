class TicketParam {
  String id;
  final String title;
  final String description;
  String? status;
  TicketParam({
    required this.id,
    required this.title,
    required this.description,
    this.status,
  });
}
