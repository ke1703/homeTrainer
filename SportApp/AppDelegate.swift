import UIKit
import UserNotifications

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties.

    var window: UIWindow?
    
    /// центр нотификаций управление уведомлениями делаем авторизацию запроса пользователю
    let notificationsCentr = UNUserNotificationCenter.current()
  
    // MARK: - Lifecycle.
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LaunchManager(window: window)?.launch()

        // функция не будет реализовываться на отправку уведомлений при открытом приложении
        notificationsCentr.delegate = self
       
        return true
    }
    
    // MARK: UISceneSession Lifecycle.

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
    /// расширяем AppDelegate функция отвечает за показ уведомления при открытом приложении
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        print(#function)
    }
    // функция срабатывае когда нажимаем на уведомление
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
    }
}
