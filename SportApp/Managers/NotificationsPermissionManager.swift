import UIKit
import UserNotifications

struct NotificationsPermissionManager {

    // MARK: - Public Methods.

    func checkNotificationsAccess(askingForPermission: Bool, then completion: @escaping (_ isAllowed: Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized:
                    completion(true)
                case .notDetermined, .provisional:
                    if askingForPermission {
                        self.requestNotificationsAccess(then: completion)
                    }
                    else {
                        completion(false)
                    }
                default:
                    if askingForPermission {
                        self.showAlert()
                    }
                    else {
                        completion(false)
                    }
                }
            }
        }
    }

    // MARK: - Private Methods.

    private func requestNotificationsAccess(then completion: @escaping (_ isAllowed: Bool) -> Void) {
        let options: UNAuthorizationOptions = [.alert, .sound]

        UNUserNotificationCenter.current().requestAuthorization(options: options) { (isAllowed, _) in
            DispatchQueue.main.async {
                completion(isAllowed)
            }
        }
    }

    private func showAlert() {
        let alert = UIAlertController.settingsAlert(title: "Уведомления", message: "Включите уведомления чтобы получать важные оповещения от приложения")
        UIViewController.current()?.present(alert, animated: true)
    }
}
