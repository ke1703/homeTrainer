import UIKit

final class View: UIView {

    // MARK: - Initialization.

    init(then completion: (_ view: View) -> Void) {
        super.init(frame: .zero)
        completion(self)
    }

    init() {
        super.init(frame: .zero)
    }

    @available(*, unavailable, message: "Loading this view from a nib is unsupported")
    required init?(coder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported")
    }

}
