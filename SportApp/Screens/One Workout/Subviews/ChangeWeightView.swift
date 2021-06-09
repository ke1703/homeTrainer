import Foundation
import UIKit
import KCCircularTimer

final class ChangeWeightView: UIView {
    
    // MARK: - UI Properties.
    
    /// белое вью
    private let whiteView = UIView().apply {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }
    
    /// картинка весы
    private let weightImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "free-icon-bathroom-scale-2770966")
    }
    
    /// укажите текущий вес
    private let currentWeightLabel = UILabel().apply {
        $0.font = .textMedium24
        $0.textColor = .black
        $0.text = "Укажите \nтекущий вес"
        $0.numberOfLines = 0
    }
    
    /// вес slider
    let weightView = SliderView(title: "Вес", smallImage: UIImage(named: "maleMiniWeight"), bigImage: UIImage(named: "maleMaxiWeight"), currency: "кг", min: 20, max: 250)
    
    /// кнопка записать
    let recordButton = BasicButton(title: "Записать", color: .textBordo)
    
    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        backgroundColor = UIColor.black.withAlphaComponent(0.6)//прозрачность экраннного фона
        
        /// белое вью
        addSubview(whiteView)
        whiteView.snp.makeConstraints {
            $0.applyWidth(30)
            $0.centerY.equalToSuperview()
        }
        /// белое вью, добавляем картинку весы Weight
        whiteView.addSubview(weightImageView)
        weightImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(24)
            $0.size.equalTo(50)
        }
        /// белое вью, лэйбл Текущий вес
        whiteView.addSubview(currentWeightLabel)
        currentWeightLabel.snp.makeConstraints {
            $0.top.right.equalToSuperview().inset(24)
            $0.left.equalTo(weightImageView.snp.right).offset(8)
        }
        /// белое вью, вес пользователя//вес slider
        whiteView.addSubview(weightView)
        weightView.snp.makeConstraints {
            $0.top.equalTo(weightImageView.snp.bottom).offset(24)
            $0.applyWidth(24)
        }
        /// белое вью,  кнопка Записать - record
        whiteView.addSubview(recordButton)
        recordButton.snp.makeConstraints {
            $0.top.equalTo(weightView.snp.bottom).offset(48)
            $0.bottom.equalToSuperview().inset(24)
            $0.applyWidth(46)
            $0.height.equalTo(48)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
