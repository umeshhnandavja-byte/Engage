
class EventModel{
  final String id;
  final String title;
  final String description;

  const EventModel({
    required this.id,
    required this.title,
    required this.description
  });

  EventModel copyWith({
    String? id,
    String? title,
    String? description
  }) {
    return
      EventModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description
      );
  }
}