import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let service = ExchangeService()
        let interactor = ExchangeInteractor(service: service)
        let presenter = ExchangePresenter(interactor: interactor)
        let initialViewController = UINavigationController(rootViewController: ViewController(presenter: presenter))

        window.rootViewController = initialViewController
        self.window = window
        window.makeKeyAndVisible()

    }

}

