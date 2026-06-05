class Usuario {
  final String codigo;
  final String nombre;
  final String apellido;
  final String correo;
  final String tipoUsuario;

  Usuario({
    required this.codigo,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.tipoUsuario,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      codigo: json['codigo'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      correo: json['correo'],
      tipoUsuario: json['tipoUsuario'],
    );
  }

  String get nombreCompleto => '$nombre $apellido';
}