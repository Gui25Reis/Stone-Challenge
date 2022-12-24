/* Gui Reis    -    gui.sreis25@gmail.com */


/// Os tipos que estão de acordo com esse protocolo possuem informações para poder criar um tag
protocol TagInfo: CaseIterable {
    var filter: FilterType { get }
    var name: String { get }
    var color: AppColors { get }
    
    static func getType(by name: String) -> Self
}
