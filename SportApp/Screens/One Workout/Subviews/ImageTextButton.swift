import Foundation
import UIKit

final class ImageTextButton: UIButton {
    
    // MARK: - UI Properties.
    
    /// имя
    let nameLabel = UILabel().apply {
        $0.font = .textRegular
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    /// перед просмотром изображения
    let beforeImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    /// после просмотра изображения
    let afterImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    /// приватный стек вью
    private lazy var stackView = UIStackView().apply {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 4
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: - Lifecycle.
    
    convenience init(title: String?, imageBefore: UIImage?, imageAfter: UIImage?)  {
        self.init()
        nameLabel.text = title
        beforeImageView.image = imageBefore
        afterImageView.image = imageAfter
        
        beforeImageView.isHidden = imageBefore == nil
        afterImageView.isHidden = imageAfter == nil
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
    
    func initialize() {
        clipsToBounds = true
        stackView.addArrangedSubviews([beforeImageView, nameLabel,  afterImageView])
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height / 2
    }
}
