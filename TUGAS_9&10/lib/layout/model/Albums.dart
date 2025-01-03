class Albums {
  final int id;
  final String title;

  const Albums({required this.id, required this.title});

  factory Albums.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id, 
        'title': String title
      } => Albums(
          id: id,
          title: title
        ), 
      _ => throw const FormatException('Failed to load album.')
    };
  }
}
