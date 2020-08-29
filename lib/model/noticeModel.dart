class NoticeModel {
  NoticeModel({
    this.hasAttachment,
    this.title,
    this.description,
    this.author,
    this.pdfUrl,
    this.time,
  });

  final String author;
  final String description;
  final List<MapEntry> time;
  final String title;
  final bool hasAttachment;
  final String pdfUrl;
}
