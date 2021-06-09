import Foundation
import UIKit

final class SliderView: UIView {

    // MARK: - UI Properties.
    
    /// название слайдера
    private let titleLabel = UILabel().apply {
        $0.font = .textBold20//задаем размер шрифта,толщину шрифта, стиль шрифта
        $0.textColor = .black
    }

    /// значение слайдера
    let valueLabel = UILabel().apply {
        $0.font = .footnoteRegular//задаем размер шрифта,толщину шрифта, стиль шрифта
        $0.textColor = .textLightAB
    }
    
    /// маленькая картинка
    private let smallImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
    }

    /// большая картинка
    private let bigImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
    }

    /// текст ввода
    let textField = BasicTextField(placeholder: "").apply {
        $0.keyboardType = .numberPad
    }

    /// слайдер
    let slider = DefaultSlider()

    /// минимум ввода слайдера
    private let minLabel = UILabel().apply {
        $0.font = .footnoteRegular//задаем размер шрифта,толщину шрифта, стиль шрифта
        $0.textColor = .textLightAB
    }

    /// максимум ввода слайдера
    private let maxLabel = UILabel().apply {
        $0.font = .footnoteRegular//задаем размер шрифта,толщину шрифта, стиль шрифта
        $0.textColor = .textLightAB
        $0.textAlignment = .right
    }

    // MARK: - Initialization.

    init(title: String, smallImage: UIImage?, bigImage: UIImage?, currency: String, min: Float, max: Float) {
        super.init(frame: .zero)

        titleLabel.text = title
        slider.minimumValue = min
        slider.maximumValue = max
        smallImageView.image = smallImage
        bigImageView.image = bigImage
        minLabel.text = String(Int(min)) + " " + currency
        maxLabel.text = String(Int(max)) + " " + currency

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()//крепим верх до низа nameTextFild
            $0.left.equalToSuperview()//крепим по краям
            $0.width.equalTo(70)   //крепим ширину
        }

        addSubview(valueLabel)
        valueLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.left.equalTo(titleLabel.snp.right).offset(8) //крепим по краям
            $0.right.equalToSuperview()
        }

        addSubview(smallImageView)
        smallImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)//крепим верх до низа growthLable
            $0.left.equalToSuperview() //крепим по краям
            $0.height.equalTo(15)  //крепим высоту
            $0.width.equalTo(5)
        }

        addSubview(bigImageView)
        bigImageView.snp.makeConstraints {
            $0.centerY.equalTo(smallImageView.snp.top)
            $0.right.equalToSuperview()
            $0.height.equalTo(29)
            $0.width.equalTo(8)
        }

        addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalTo(smallImageView.snp.bottom).offset(4)
            $0.applyWidth()
            $0.height.equalTo(48)
        }
        
        addSubview(slider)
        slider.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(4)
            $0.applyWidth()
        }

        addSubview(minLabel)
        minLabel.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(6)
            $0.left.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        addSubview(maxLabel)
        maxLabel.snp.makeConstraints {
            $0.top.equalTo(slider.snp.bottom).offset(6)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
