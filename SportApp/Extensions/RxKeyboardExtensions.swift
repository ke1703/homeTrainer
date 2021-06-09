import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    func scrollToViewForInput(vc: UIViewController, margin: CGFloat = 0) -> Disposable {
        let disposable1 = RxKeyboard.instance.willShowVisibleHeight.drive(onNext: { [weak scrollView = self.base] float in
            guard let scrollView = scrollView else {return}
            scrollView.contentInset.bottom = float + margin
            scrollView.scrollIndicatorInsets.bottom = float
            guard let viewToCenter = vc.view.findFirstResponder() else { return }
            let relativeFrame = viewToCenter.superview!.convert(viewToCenter.frame, to: scrollView)

            let landscape = vc.interfaceOrientation == .landscapeLeft || vc.interfaceOrientation == .landscapeRight
            let spaceAboveKeyboard = (landscape ? scrollView.frame.width : scrollView.frame.height) - float

            let offset = relativeFrame.origin.y - (spaceAboveKeyboard - viewToCenter.frame.height) / 2
            scrollView.setContentOffset(CGPoint(x: 0, y: max(offset, 0)), animated: true)
        })

        let disposable2 = RxKeyboard.instance.isHidden.debounce(.milliseconds(150)).filter { b in b }.drive(onNext: { [weak scrollView = self.base] b in
            guard let scrollView = scrollView else {return}
            scrollView.contentInset.bottom = vc.bottomMargin + margin
            scrollView.scrollIndicatorInsets.bottom = 0
        })

        return CompositeDisposable(disposable1, disposable2)
    }

    /// Иная стратегия для вычисления величины скролла
    func scrollToViewForInput(vc: UIViewController, margin: CGFloat = 0, offsetFromKeyboard: CGFloat = 16) -> Disposable {

            let disposable1 = RxKeyboard.instance.willShowVisibleHeight.drive(onNext: { [weak scrollView = self.base] float in
                guard let scrollView = scrollView else { return }
                scrollView.contentInset.bottom = float + margin
                scrollView.scrollIndicatorInsets.bottom = float
                guard let viewToCenter = vc.view.findFirstResponder() else { return }
                let relativeFrame = viewToCenter.superview!.convert(viewToCenter.frame, to: scrollView)

                // приложение не поддерживает альбомную ориентацию
                let spaceAboveKeyboard = scrollView.frame.height - float

                // Прокрутка нужна только если клавиатура перекрывает View
                guard spaceAboveKeyboard < relativeFrame.maxY else { return }

                let offsetToScroll = relativeFrame.origin.y - spaceAboveKeyboard + viewToCenter.frame.height + offsetFromKeyboard

                scrollView.setContentOffset(CGPoint(x: 0, y: max(offsetToScroll, 0)), animated: true)
            })

            let disposable2 = RxKeyboard.instance.isHidden.debounce(.milliseconds(150)).filter { b in b }.drive(onNext: { [weak scrollView = self.base] b in
                guard let scrollView = scrollView else {return}
                scrollView.contentInset.bottom = vc.bottomMargin + margin
                scrollView.scrollIndicatorInsets.bottom = 0
            })

            return CompositeDisposable(disposable1, disposable2)
        }

    func keyboardInsets(_ vc: UIViewController, margin: CGFloat = 0) -> Disposable {
        let disposable1 = RxKeyboard.instance.willShowVisibleHeight.drive(onNext: { [weak scrollView = self.base] float in
            guard let scrollView = scrollView else {return}
            scrollView.contentInset.bottom = float + margin
            scrollView.scrollIndicatorInsets.bottom = float
        })

        let disposable2 = RxKeyboard.instance.isHidden.debounce(.milliseconds(150)).filter { b in b }.drive(onNext: { [weak scrollView = self.base] b in
            guard let scrollView = scrollView else {return}
            scrollView.contentInset.bottom = vc.bottomMargin + margin
            scrollView.scrollIndicatorInsets.bottom = 0
        })

        return CompositeDisposable(disposable1, disposable2)
    }
}
