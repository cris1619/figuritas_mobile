class StickerModel {

  final int number;

  final bool obtained;

  StickerModel({

    required this.number,

    this.obtained = false,
  });

  StickerModel copyWith({

    int? number,

    bool? obtained,
  }) {

    return StickerModel(

      number:
          number ?? this.number,

      obtained:
          obtained ?? this.obtained,
    );
  }
}