import Foundation
import UIKit

final class TabBarViewController: UITabBarController {

    // MARK: - Initialization.

    init() {
        super.init(nibName: nil, bundle: nil)
        UITabBar.appearance().barTintColor = UIColor.black
        viewControllers = viewControllers().map {
            NavigationController(rootViewController: $0, configuration: .default) }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods.

    //добавление экранов в таббар
    private func viewControllers() -> [UIViewController] {
        [ workoutsViewController(), statisticsViewController(), profileViewController()]
    }

    // функция добавления экрана треенировок
    private func workoutsViewController() -> UIViewController {
        let vc = WorkoutsViewController()
        vc.tabBarItem.image = UIImage(named: "гантеля")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "гантеля")?.withRenderingMode(.alwaysOriginal).withTintColor(.textBordo)
        return vc
    }

    //добавление экрана статистики в таббар
    private func statisticsViewController() -> UIViewController {
        let vc = StatisticsViewController()
        vc.tabBarItem.image = UIImage(named: "Статистика")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "Статистика")?.withRenderingMode(.alwaysOriginal).withTintColor(.textBordo)
        return vc
    }

    // добавление экрана профиля в таббар
    private func profileViewController() -> UIViewController {
        let vc = ProfileViewController()
        vc.tabBarItem.image = UIImage(named: "Профиль")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "Профиль")?.withRenderingMode(.alwaysOriginal).withTintColor(.textBordo)
        return vc
    }
}
