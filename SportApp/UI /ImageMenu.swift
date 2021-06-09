import Foundation
import UIKit

struct ImageMenu {

    // MARK: - Properties.

    private let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

    // MARK: - Public Methods.

    func show(showsRemoveImageOption: Bool, then completion: @escaping (_ action: Action) -> Void) {
         possibleActions(showsRemoveImageOption: showsRemoveImageOption)
            .map { UIAlertAction(action: $0, completion: completion) }
            .forEach { self.alertController.addAction($0) }

        alertController.show()
    }

    // MARK: - Private Actions.

    private func possibleActions(showsRemoveImageOption: Bool) -> [Action] {
        return Action.allCases.filter({ (action) -> Bool in
            switch action {
            case .takePhoto where UIImagePickerController.isSourceTypeAvailable(.camera):
                return true
            case .pickFromLibrary where UIImagePickerController.isSourceTypeAvailable(.photoLibrary):
                return true
            case .delete where showsRemoveImageOption:
                return true
            case .cancel:
                return true
            default:
                return false
            }
        })
    }

}

extension ImageMenu {
    enum Action: CaseIterable {
        case takePhoto
        case pickFromLibrary
        case delete
        case cancel

        var title: String {
            switch self {
            case .takePhoto:
                return "Сделать фото"
            case .pickFromLibrary:
                return "Выбрать из галереи"
            case .delete:
                return "Удалить"
            case .cancel:
                return "Отменить"
            }
        }

        var style: UIAlertAction.Style {
            switch self {
            case .takePhoto, .pickFromLibrary:
                return .default
            case .delete:
                return .destructive
            case .cancel:
                return .cancel
            }
        }
    }
}
