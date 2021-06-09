import SnapKit

extension ConstraintMaker {
    @discardableResult
    public func belowTo(_ other: ConstraintView, _ file: String = #file, _ line: UInt = #line) -> ConstraintMakerEditable {
        self.top.equalTo(other.snp.bottom, file, line)
    }

    @discardableResult
    public func aboveTo(_ other: ConstraintView, _ file: String = #file, _ line: UInt = #line) -> ConstraintMakerEditable {
        self.bottom.equalTo(other.snp.top, file, line)
    }

    @discardableResult
    public func beforeTo(_ other: ConstraintView, _ file: String = #file, _ line: UInt = #line) -> ConstraintMakerEditable {
        self.trailing.equalTo(other.snp.leading, file, line)
    }

    @discardableResult
    public func afterTo(_ other: ConstraintView, _ file: String = #file, _ line: UInt = #line) -> ConstraintMakerEditable {
        self.leading.equalTo(other.snp.trailing, file, line)
    }

    public func equalsEdgesToSafeArea(_ vc: UIViewController, _ file: String = #file, _ line: UInt = #line) {
        self.left.equalToSuperview()
        self.top.equalTo(vc.snpSafeAreaTop)
        self.width.equalToSuperview()
        self.bottom.equalToSuperview()
    }

    func applyWidth(_ offset: CGFloat = 0) {
        let editable1 = self.left.equalToSuperview()
        let editable2 = self.width.equalToSuperview()
        if offset != 0 {
            editable1.offset(offset)
            editable2.offset(-offset * 2)
        }
    }

    func applyWidth(_ other: ConstraintView, offset: CGFloat = 0) {
        let editable1 = self.left.equalTo(other)
        let editable2 = self.width.equalTo(other)
        if offset != 0 {
            editable1.offset(offset)
            editable2.offset(-offset * 2)
        }
    }
}

extension UIViewController {
    var snpSafeAreaTop: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.top
        } else {
            return self.topLayoutGuide.snp.bottom
        }
    }

    var snpSafeAreaBottom: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.bottom
        } else {
            return self.bottomLayoutGuide.snp.top
        }
    }
}
