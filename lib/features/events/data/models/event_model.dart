
class EventModel{
  final String id;
  final String title;
  final String shortDescription;

  const EventModel({
    required this.id,
    required this.title,
    required this.shortDescription
  });

  EventModel copyWith({
    String? id,
    String? title,
    String? shortDescription
  }) {
    return
      EventModel(
        id: id ?? this.id,
        title: title ?? this.title,
        shortDescription: shortDescription ?? this.shortDescription
      );
  }
}