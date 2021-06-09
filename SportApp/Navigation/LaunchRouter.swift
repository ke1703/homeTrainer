import UIKit
import RealmSwift

struct LaunchRouter {
    
    // MARK: - Properties.
    
    private let window: UIWindow
    
    // MARK: - Initialization.
    
    init?(window: UIWindow?) {
        guard let window = window else {
            return nil
        }
        
        self.window = window
    }
    
    // MARK: - Public Methods.
    
    func to(_ screen: Screen) {
        var vc: UIViewController {
            switch screen {
            case .start:
                let realm = try! Realm()
                guard realm.objects(ProfileModel.self).isEmpty//проверяем есть ли у нас пользователь
                else {
                    return TabBarViewController()
                }
                return EnterDataViewControllers()//если нет то загрузить эту страницу
            }
        }
        
        //let nc = NavigationController(rootViewController: vc, configuration: .default)
        show(vc)
    }
    
    // MARK: - Private Methods.
    
    private func show(_ viewController: UIViewController) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

extension LaunchRouter {
    enum Screen {
        case start
    }
}
