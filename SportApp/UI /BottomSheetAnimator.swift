import UIKit

final class BottomSheetAnimator: NSObject {

    // MARK: - Properties.

    private let action: Action

    // MARK: - Computed Properties.

    private var bounds: CGRect {
        return UIScreen.main.bounds
    }

    private var height: CGFloat {
        guard case .present (let preferredHeight) = action, let height = preferredHeight else {
            return bounds.height - 30
        }

        return min(bounds.height - 30, height)
    }

    private var minY: CGFloat {
        return bounds.height - height
    }

    // MARK: - Initialization.

    init(action: Action) {
        self.action = action
        super.init()
    }

    // MARK: - Private Methods.

    private func present(_ viewController: UIViewController, over originViewController: UIViewController, in context: UIViewControllerContextTransitioning) {
        viewController.view.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: height)
        viewController.view.clipsToBounds = true
        context.containerView.addSubview(viewController.view)

        let duration = self.transitionDuration(using: context)

        UIView.animate(withDuration: duration, animations: {
            viewController.view.frame = CGRect(x: 0, y: self.minY, width: self.bounds.width, height: self.height)
        }) { (_) in
            context.completeTransition(!context.transitionWasCancelled)
        }
    }

    private func dismiss(_ viewController: UIViewController, returningTo originViewController: UIViewController, in context: UIViewControllerContextTransitioning) {
        let duration = self.transitionDuration(using: context)

        if context.isInteractive {
            UIView.animate(withDuration: duration, animations: {
                viewController.view.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.height)
            }) { (_) in
                context.completeTransition(!context.transitionWasCancelled)
            }
        } else {
            UIView.animate(withDuration: duration, animations: {
                viewController.view.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.height)
            }) { (_) in
                context.completeTransition(!context.transitionWasCancelled)
            }
        }
    }

}

extension BottomSheetAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
        else { return }

        switch action {
        case .present:
            present(toViewController, over: fromViewController, in: transitionContext)
        case .dismiss:
            dismiss(fromViewController, returningTo: toViewController, in: transitionContext)
        }
    }
}

extension BottomSheetAnimator {
    enum Action {
        case present (preferredHeight: CGFloat?)
        case dismiss
    }
}
