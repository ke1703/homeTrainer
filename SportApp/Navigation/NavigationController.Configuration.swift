import UIKit

extension NavigationController {
    struct Configuration {
        let tintColor: UIColor
        let title: (color: UIColor, customFont: UIFont?)
        let backButtonImage: UIImage?
        let statusBarStyle: UIStatusBarStyle
        let preferesLargeTitles: Bool

        var titleTextAttributes: [NSAttributedString.Key: Any] {
            var attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.foregroundColor: title.color ]

            if let customFont = title.customFont {
                attributes[NSAttributedString.Key.font] = customFont
            }

            return attributes
        }

        init(tintColor: UIColor, title: (color: UIColor, customFont: UIFont?), backButtonImage: UIImage?, statusBarStyle: UIStatusBarStyle, preferesLargeTitles: Bool) {
            self.tintColor = tintColor
            self.title = title
            self.backButtonImage = backButtonImage
            self.statusBarStyle = statusBarStyle
            self.preferesLargeTitles = preferesLargeTitles
        }
    }
}

extension NavigationController.Configuration {
    static var `default`: NavigationController.Configuration {
        return NavigationController.Configuration(
            tintColor: .white,
            title: (color: .cyan, customFont: .systemFont(ofSize: 17, weight: .semibold)),
            backButtonImage: nil,
            statusBarStyle: .lightContent,
            preferesLargeTitles: false)
    }
}
