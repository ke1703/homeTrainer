import UIKit

struct LaunchManager {

    // MARK: - Properties.

    private let window: UIWindow

    // MARK: - Initialization.

    init?(window: UIWindow?) {
        guard let window = window else {
            return nil
        }
        self.window = window
    }

    // MARK: - Public Methods.

    func launch() {
        standartOpen()
    }

    private func standartOpen() {
        LaunchRouter(window: window)?.to(.start)
    }
}
