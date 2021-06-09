import UIKit
import RxCocoa
import RxSwift

/// RxKeyboard provides a reactive way of observing keyboard frame changes.
public class RxKeyboard {
    // MARK: Public.

    /// Get a singleton instance.
    public static let instance = RxKeyboard()

    /// An observable keyboard frame.
    public let frame: Driver<CGRect>

    /// An observable visible height of keyboard. Emits keyboard height if the keyboard is visible
    /// or `0` if the keyboard is not visible.
    public let visibleHeight: Driver<CGFloat>

    /// Same with `visibleHeight` but only emits values when keyboard is about to show. This is
    /// useful when adjusting scroll view content offset.
    public let willShowVisibleHeight: Driver<CGFloat>

    /// An observable visibility of keyboard. Emits keyboard visibility
    /// when changed keyboard show and hide.
    public let isHidden: Driver<Bool>

    // MARK: Private.

    private let disposeBag = DisposeBag()

    // MARK: Initializing.

    private init() {
//        let applicationDidFinishLaunching = UIApplication.didFinishLaunchingNotification

        let defaultFrame = CGRect(
                x: 0,
                y: UIScreen.main.bounds.height,
                width: UIScreen.main.bounds.width,
                height: 0
        )
        let frameVariable = BehaviorRelay<CGRect>(value: defaultFrame)
        self.frame = frameVariable.asDriver().distinctUntilChanged()
        self.visibleHeight = self.frame.map { $0.height }
        self.willShowVisibleHeight = self.visibleHeight
                .scan((visibleHeight: 0, isShowing: false)) { lastState, newVisibleHeight in
                    (visibleHeight: newVisibleHeight, isShowing: lastState.visibleHeight == 0 && newVisibleHeight > 0)
                }
                .filter { state in state.isShowing }
                .map { state in state.visibleHeight }
        self.isHidden = self.visibleHeight.map({ $0 == 0.0 }).distinctUntilChanged()

        // keyboard will change frame
        let willChangeFrame = Observable.merge(NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification),
                        NotificationCenter.default.rx.notification(UIResponder.keyboardWillChangeFrameNotification))
                .compactMap { notification -> CGRect? in notification.cgRectValue }
                .map { frame -> CGRect in CGRect(x: 0, y: UIScreen.main.bounds.height - frame.height, width: UIScreen.main.bounds.width, height: frame.height) }

        // keyboard will hide
        let willHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
//                .do(onNext: { notification in
//                    Log.debug(notification.debugDescription)
//                })
                .map { _ -> CGRect in defaultFrame }

        // merge into single sequence
        Observable.of(willChangeFrame, willHide).merge()
                .distinctUntilChanged()
//                .debug("frame")
                .bind(to: frameVariable)
                .disposed(by: self.disposeBag)
    }
}

fileprivate extension Notification {
    var cgRectValue: CGRect? {
//        Log.debug(self.debugDescription)
        let screenWidth = UIScreen.main.bounds.width
        if let endValue = (self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, endValue.width == screenWidth {
            return endValue
        }
        if let beginValue = (self.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, beginValue.width == screenWidth {
            return beginValue
        }
        return nil
    }
}
