/* Macro - Grupo 05 */


/// Os tipos que estão de acordo com esse protocolo lidam com erros que podem ocorrer
/// durante a aplicação. Esse protocolo define esses possíveis erros
protocol ErrorWarnings: Error {
    
    /// Avisos para o usuário
    var userWarning: String { get }
    
    /// Avisos para o desenvolvedor
    var devWarning: String { get }
}
