/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /* MARK: - Atributos */
    
    /// Janela princiapal do app
    var window: UIWindow?


    
    /* MARK: - Delegate */
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let nav = self.createNavigation(for: HomeController())
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Cria uma navigation controller para uma controller
    /// - Parameter vc: controller que vai receber a navigation controller
    /// - Returns: navigation controller
    private func createNavigation(for vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController()
        nav.navigationBar.prefersLargeTitles = true
        nav.pushViewController(vc, animated: true)
        
        return nav
    }
}
