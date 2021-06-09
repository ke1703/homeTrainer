import UIKit
import Foundation

extension UICollectionReusableView {
    static var reuseID: String {
        String(describing: self)
    }
}
