import Foundation
import UIKit

final class GenderButton: UIButton {
    
    // MARK: - UI Properties.
    
    /// вью выбора полькователя
    let view = UIView().apply {
        $0.backgroundColor = .e5
        $0.layer.cornerRadius = 16
        $0.layer.borderColor = UIColor.e5.cgColor
        $0.isUserInteractionEnabled = false
    }
    
    /// вью иконки
    let iconImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "Check")
    }
    
    /// изображение пол пользователя
    let genderImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
    }
    
    /// лэйбл пол пользователя
    let genderLabel = UILabel().apply {
        $0.font = UIFont(name: "Helvetica-Regular", size: 16)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    // MARK: - Lifecycle.
    
    /// выбрать  к показу цвет вью, бордер на ширину вью, выбранную картинку
    var isSelect: Bool = false {
        didSet {
            view.backgroundColor = isSelect ? UIColor.e5 : UIColor.clear
            view.layer.borderWidth = isSelect ? 0 : 2
            iconImageView.isHidden = !isSelect
        }
    }
    
    convenience init(title: String?, image: UIImage?)  {
        self.init(image: image)
        genderLabel.text = title
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    init(image: UIImage? = nil) {
        super.init(frame: .zero)
        genderImageView.image = image
        initialize()
    }
    
    private func initialize() {
        clipsToBounds = true

        addSubview(view)
        view.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.applyWidth()
        }
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(12)
            $0.size.equalTo(30)
        }
        
        addSubview(genderImageView)
        genderImageView.snp.makeConstraints {
            $0.center.equalTo(view)
        }
        
        addSubview(genderLabel)
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom).offset(6)
            $0.applyWidth()
            $0.bottom.equalToSuperview()
        }
    }
}
