import AVFoundation
import UIKit

struct CameraPermissionManager {

    // MARK: - Public Methods.

    func checkCameraAccess(askingForPermission: Bool, then completion: @escaping (_ isAllowed: Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)

        DispatchQueue.main.async {
            switch status {
            case .authorized:
                completion(true)
            case .notDetermined:
                if askingForPermission {
                    self.requestAccess(then: completion)
                }
                else {
                    completion(false)
                }
            default:
                if askingForPermission {
                    self.showAlert()
                    completion(false)
                }
            }
        }
    }

    // MARK: - Private Methods.

    private func requestAccess(then completion: @escaping (_ success: Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { isAllowed in
            DispatchQueue.main.async {
                completion(isAllowed)
            }
        }
    }

    private func showAlert() {
        let alert = UIAlertController.settingsAlert(title: "Доступ к вашей камере", message: "Необходимо для добавления фото")
        UIViewController.current()?.present(alert, animated: true)
    }
}
