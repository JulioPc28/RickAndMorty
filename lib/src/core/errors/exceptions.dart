/// Excepción para errores del servidor.
/// Se usa cuando la API falla o responde con error.
class ServerException implements Exception {}

/// Excepción para cuando un recurso no existe.
/// Por ejemplo: cuando la API responde que no encontró datos.
class NotFoundException implements Exception {}
