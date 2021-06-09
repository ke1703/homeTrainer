import Foundation
import UIKit

final class BasicButton: UIButton {
    
    // MARK: - UI Properties.
    
    let nameLabel = UILabel().apply {
        $0.font = .textBold16
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let iconImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.snp.makeConstraints {
            $0.size.equalTo(16)
        }
    }
    
    private lazy var stackView = UIStackView().apply {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 8
        $0.isUserInteractionEnabled = false
    }

    // MARK: - Initialization.

    convenience init(title: String?, color: UIColor?, icon: UIImage? = nil)  {
        self.init()
        nameLabel.text = title
        iconImageView.image = icon
        iconImageView.isHidden = icon == nil
        backgroundColor = color
        initialize()
    }


    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    init() {
        super.init(frame: .zero)
        initialize()
    }

    private func initialize() {
        stackView.addArrangedSubviews([iconImageView, nameLabel])
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    // MARK: - Lifecycle.

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
}
