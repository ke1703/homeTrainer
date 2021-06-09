import UIKit
import KCCircularTimer

/// Ожидание просмотра
final class WaitingView: UIView {
    
    // MARK: - UI Properties.

    /// название тренировки
    let titleLabel = UILabel().apply {
        $0.font = .textRegular24
        $0.textColor = .textBordo
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    /// картинка тренировки
    let imageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    
    /// кнопка помощь
    let helpButton = UIButton().apply {
        $0.setImage(UIImage(named: "icons8-помощь-100 1"), for: .normal)
    }

    /// Приготовьтесь
    private let getReadyLabel = UILabel().apply {
        $0.font = .squadHeavy
        $0.textColor = .black
        $0.textAlignment = .center
        $0.text = "Приготовьтесь"
        $0.numberOfLines = 0
    }

    /// таймер
    let timer = KCCircularTimer().apply {
        $0.currentValue = 0
        $0.maximumValue = 30
        $0.backgroundColor = .white
        $0.tintColor = #colorLiteral(red: 0.7215686275, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
    }

    /// кнопка пропустить
    let skipButton = UIButton().apply {
        $0.setImage(UIImage(named: "Vector 8"), for: .normal)
        $0.backgroundColor = .white
        
    }
    
    /// окно подсказки
    let exerciseDescriptionView = ExerciseDescriptionView().apply {
        $0.isHidden = true
    }

    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.applyWidth(85)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8) 
            $0.applyWidth(70)//до краев
            $0.height.equalTo(214)
        }
        
        addSubview(helpButton)
        helpButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(280)
            $0.left.equalTo(imageView.snp.right).offset(20)
            $0.right.equalToSuperview().inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }

        addSubview(getReadyLabel)
        getReadyLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(120)
            $0.applyWidth(16)
        }

        addSubview(timer)
        timer.snp.makeConstraints {
            $0.applyWidth(112)
            $0.top.equalTo(getReadyLabel).offset(45)
            $0.height.equalTo(150)
            $0.width.equalTo(150)
        }

        addSubview(skipButton)
        skipButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(34)
            $0.right.equalToSuperview().inset(34)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
            
        }
        
        //добавление всплывающего окна при нажатии на кнопку помощь
        exerciseDescriptionView.isHidden = true
        addSubview(exerciseDescriptionView)
        exerciseDescriptionView.snp.makeConstraints {
            $0.edges.equalToSuperview()//закрепили на всю ширину и высоту экрана
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
