  import UIKit

  final class NavigationController: UINavigationController {

    // MARK: - Observed Properties.

    var statusBarStyle: UIStatusBarStyle {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    var preferesLargeTitles: Bool {
        didSet {
            if preferesLargeTitles {
                navigationItem.largeTitleDisplayMode = .always
                navigationBar.prefersLargeTitles = true
            }
            else {
                navigationItem.largeTitleDisplayMode = .never
                navigationBar.prefersLargeTitles = false
            }
        }
    }

    // MARK: - Computed Properties.

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Initialization.

    init(rootViewController: UIViewController, configuration: Configuration) {
        self.statusBarStyle = configuration.statusBarStyle
        self.preferesLargeTitles = configuration.preferesLargeTitles
        super.init(nibName: nil, bundle: nil)

        self.viewControllers = [rootViewController]

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = configuration.tintColor
        navigationBar.titleTextAttributes = configuration.titleTextAttributes

        if let backButtonImage = configuration.backButtonImage {
            navigationBar.backIndicatorImage = backButtonImage
            navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        }

        if preferesLargeTitles {
            navigationItem.largeTitleDisplayMode = .always
            navigationBar.prefersLargeTitles = true
        }
        else {
            navigationItem.largeTitleDisplayMode = .never
            navigationBar.prefersLargeTitles = false
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  }
