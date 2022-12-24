/* Gui Reis    -    gui.sreis25@gmail.com */


extension String {
    
    /// Separa a string em em um vetor de acordo com o tipo de separação definido
    /// - Parameter char: ponto que vai ser separado
    /// - Returns: lista com as partes separadas
    ///
    /// Observação: apesar do tipo ser `String` só é aceito caracteres ou strings de tamanho 1. Caso
    /// a tenha mais de dois caractes o vaiza retorna a lista com a string em si.
    func strip(at char: String) -> [String] {
        guard !char.isEmpty else { return [self] }
        
        var strip: [String] = []
        var subString = ""
        
        for letter in self {
            let str = "\(letter)"
            if str == char {
                strip.append(subString)
                subString = ""
            } else {
                subString += str
            }
        }
        
        if strip.isEmpty { return [self] }
        
        if !subString.isEmpty { strip.append(subString) }
        
        return strip
    }
}
