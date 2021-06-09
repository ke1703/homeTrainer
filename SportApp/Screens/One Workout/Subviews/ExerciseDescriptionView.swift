import Foundation
import UIKit
// oписание упражнения
final class ExerciseDescriptionView: UIView {
    
    // MARK: - UI Properties.
    
    /// белое вью
    let whiteView = UIView().apply {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }
    
    /// иконкa вью
    let iconImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
    }
    
    /// лейбл "название"
    let titleLable = UILabel().apply {
        $0.font = .textRegular24
        $0.textColor = .textBordo
        $0.numberOfLines = 0
    }
    
    /// стек картинкa + описания тренировки ( заголовок)
    private lazy var stackView = UIStackView().apply {
        $0.distribution = .fill
        $0.alignment = .center//картинка будет по центру надписи
        $0.axis = .horizontal//горизонтальный
        $0.spacing = 8 //расстояние между элементами
    }
    
    /// текст вью
    var textView = UITextView().apply {
        $0.font = .footnoteRegular
        $0.textColor = .black
        $0.isUserInteractionEnabled = false
    }
    
    /// кнопку назад
    let backButton = UIButton().apply {
        $0.setImage(UIImage(named: "back"), for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 17.5
    }
    
    /// номер упражнения
    let numberLabel = UILabel().apply {
        $0.font = .textMedium16
        $0.textColor = .textPrimary
        $0.textAlignment = .center//размещение по центру
    }
    
    /// кнопка вперед
    let nextButton = UIButton().apply {
        $0.setImage(UIImage(named: "nexts"), for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 17.5
    }
    
    /// описание время или количество
    let descriptionLabel = UILabel().apply {
        $0.font = .textMedium10
        $0.textColor = .colorButton
    }
    
    /// стек название + описание
    private lazy var textStackView = UIStackView().apply {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        ///прозрачность экраннного фона
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        /// белое вью , чтобы корректно отображать при любом размере экрана
        addSubview(whiteView)
        whiteView.snp.makeConstraints {
            $0.applyWidth(24)
            $0.top.equalToSuperview().inset(UIScreen.main.bounds.height / 6)//всю ширину экрана делим на 6 и получит отступ от края
            $0.bottom.equalToSuperview().inset(UIScreen.main.bounds.height / 8)//всю ширину экрана делим на 8 и получит отступ от края
        }
        
        /// стек из лэйблов
        textStackView.addArrangedSubviews([titleLable, descriptionLabel])
        
        /// стек из иконки и названия тренировки
        stackView.addArrangedSubviews([iconImageView, textStackView])
        
        /// белое вью, добавляем стек из иконки и названия тренировки,теперь иконка будет находится всегда по центру текста у titleLable убрали все констрейны
        whiteView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.applyWidth(30)
        }
        
        iconImageView.snp.makeConstraints {//оставили только размер иконки,т к она в стеке и сменили размер на большую
            $0.size.equalTo(124)
        }
        /// белое вью, добавили кнопку "назад"
        whiteView.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(15)
            $0.left.equalToSuperview().inset(32)
            $0.size.equalTo(35)
        }
        /// белое вью, добавили текст вью
        whiteView.addSubview(textView)
        textView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)///закрепили к низу,стека,чтобы заголовок и иконка правильно взаимодействовали опускались и поднимались в зависимоти от текста
            $0.applyWidth(30)
            $0.bottom.equalTo(backButton.snp.top).offset(-30)
        }
        /// белое вью, закрепили текстовое поле для цифр страниц
        whiteView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton.snp.centerY)//центр кнопки и центр надписи крепим по центру У
            $0.centerX.equalToSuperview()//закрепили по центру экрана по Х
        }        
        /// белое вью, добавили кнопку "далее"
        whiteView.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(15)
            $0.right.equalToSuperview().inset(32)
            $0.size.equalTo(35)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(lesson: Lesson, allCount: Int, currentCount: Int, isHideButtons: Bool = false) {
        titleLable.text = lesson.name
        var text = ""
        if let counts = lesson.counts {
            text = "x \(counts)"
        }
        if let time = lesson.time {
            text = "\(time.times())"
        }
        
        descriptionLabel.text = text
        iconImageView.image = lesson.imageBig//заменили размер иконки
        textView.text = lesson.text
        numberLabel.text = "\(currentCount + 1) из \(allCount)"//+1,чтобы текст на экране начинался не с 0 индекса
        nextButton.isHidden = isHideButtons
        backButton.isHidden = isHideButtons
    }
}
