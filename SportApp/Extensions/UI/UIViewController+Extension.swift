import UIKit

extension UIViewController {
    static func current(of viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let viewController = viewController as? UITabBarController {
            if let selected = viewController.selectedViewController {
                return .current(of: selected)
            }
        }

        if let viewController = viewController as? UINavigationController {
            return .current(of: viewController.viewControllers.last)
        }

        if let viewController = viewController?.presentedViewController {
            return .current(of: viewController)
        }

        return viewController
    }

    func selectTime(selectedDate: Date?, then completion: @escaping (Date) -> Void) {
        let vc = DatePickerViewController(safeAreaInsets: view.safeAreaInsets, selectedDate: selectedDate, mode: .time, handler: completion)
        present(vc, animated: true, completion: nil)
    }

    var bottomMargin: CGFloat {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaInsets.bottom
        }
        return self.bottomLayoutGuide.length
    }
}
