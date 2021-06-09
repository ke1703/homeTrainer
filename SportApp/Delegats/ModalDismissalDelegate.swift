import UIKit

protocol ModalDismissalDelegate: AnyObject {
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}
