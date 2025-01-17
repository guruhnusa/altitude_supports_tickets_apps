import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

@freezed
class TicketModel with _$TicketModel {
  const factory TicketModel({
    @JsonKey(name: "_id") required String id,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "status") required String status,
    @JsonKey(name: "createdAt") required String createdAt,
    @JsonKey(name: "updatedAt") required String updatedAt,
    @JsonKey(name: "__v") required int v,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);
}
