import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView]? = nil, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .equalSpacing, spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill) {
        if let arrangedSubviews = arrangedSubviews {
            self.init(arrangedSubviews: arrangedSubviews)
        } else {
            self.init()
        }
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.alignment = alignment
    }

    func addArrangedSubviews(_ views: UIView...) {
        self.addArrangedSubviews(views)
    }

    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }}
