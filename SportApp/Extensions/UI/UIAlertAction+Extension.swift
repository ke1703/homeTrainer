import UIKit

extension UIAlertAction {
    convenience init(action: ImageMenu.Action, completion: @escaping (_ completion: ImageMenu.Action) -> Void) {
        self.init(title: action.title, style: action.style) { _ in
            completion(action)
        }
    }
}
