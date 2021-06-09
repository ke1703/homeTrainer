import UIKit

extension UIAlertController {

    static func settingsAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Открыть Настройки", style: .default, handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        alert.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))

        return alert
    }

    static func show(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.default, handler: nil))
        alert.show()
    }

    func show() {
        UIViewController.current()?.present(self, animated: true, completion: nil)
    }
}
