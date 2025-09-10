class TextVO {
  final String value;

  TextVO(this.value, {int? minLength, int? maxLength}) {
    if (value.trim().isEmpty) {
      throw Exception("O texto não pode estar vazio");
    }

    // Regex: aceita apenas letras, números e espaços
    if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
      throw Exception("O texto contém caracteres inválidos");
    }

    if (minLength != null && value.length < minLength) {
      throw Exception("O texto deve ter pelo menos $minLength caracteres");
    }

    if (maxLength != null && value.length > maxLength) {
      throw Exception("O texto deve ter no máximo $maxLength caracteres");
    }
  }

  @override
  String toString() => value;
}
