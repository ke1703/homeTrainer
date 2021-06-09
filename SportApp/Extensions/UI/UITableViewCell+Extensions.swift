import UIKit

public extension UITableViewCell {
    static var reuseID: String {
        return String(describing: self)
    }
}
