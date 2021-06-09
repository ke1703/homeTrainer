import UIKit

final class ViewControllerPullUP<UI: UIView>: PullUpController {

    // MARK: - UI Properties.

    internal let ui = UI()

    // MARK: - Lifecycle.

    override func loadView() {
        view = ui
    }

    // MARK: - Initialization.
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
