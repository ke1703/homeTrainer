import UIKit

extension UIView {
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder { return self }
        return self.subviews.compactMap { view in view.findFirstResponder() }.first
    }
}
