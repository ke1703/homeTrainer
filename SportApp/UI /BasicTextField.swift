import UIKit

final class BasicTextField: UITextField {
    
    // MARK: - Initialization.
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    convenience init(placeholder: String? = nil) {
        self.init()
        self.placeholder = placeholder
    }
    
    private func initialize() {
        self.layer.masksToBounds = true
        font = .textBold16
        textColor = .textPrimary
        tintColor = .textPrimary
        layer.borderWidth = 1
        layer.borderColor = UIColor.textLightGray.cgColor
    }
    
    // MARK: - Lifecycle.
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 8
    }
    
    // MARK: - Rect Methods.
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 13, left: 16, bottom: 15, right: 16))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 13, left: 16, bottom: 15, right: 16))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 13, left: 16, bottom: 15, right: 16))
    }
}
