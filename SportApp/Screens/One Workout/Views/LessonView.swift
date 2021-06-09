import Foundation
import UIKit
import KCCircularTimer

final class LessonView: UIView {
    
    // MARK: - UI Properties.

    /// название тренировки
    let titleLabel = UILabel().apply {
        $0.font = .textRegular24
        $0.textColor = .textBordo
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    /// каpтинка тренировки
    let imageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }

    /// кнопка подсказка
    let helpButton = UIButton().apply {
        $0.setImage(UIImage(named: "icons8-помощь-100 1"), for: .normal)
    }

    /// время
    let timerLabel = UILabel().apply {
        $0.font = .textHeavy50
        $0.textColor = .black
        $0.textAlignment = .center
    }

    /// кнопка паузы
    let pauseButton = BasicButton(title: "Пауза", color: .textBordo, icon: UIImage(named: "пауза"))
    
    /// кнопка Следующее
    let nextButton = ImageTextButton(title: "Следующее", imageBefore: nil, imageAfter: UIImage(named: "nexts"))

    /// завершить тренировку
    let finishWorkoutButton = ImageTextButton(title: "Завершить тренировку", imageBefore: nil, imageAfter: UIImage(named: "nexts"))

    /// стек для кнопок
    private lazy var buttonStackView = UIStackView().apply {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 0
    }
    
    /// вью для кнопки пауза
    private let pauseView = UIView()
    
    /// окно подсказки
    let exerciseDescriptionView = ExerciseDescriptionView()

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
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.left.equalToSuperview().inset(110)
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
        
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(118)
            $0.height.equalTo(50)
            $0.width.equalTo(154)
            $0.applyWidth(110)//до краев
        }

        buttonStackView.addArrangedSubviews([nextButton, finishWorkoutButton])
        finishWorkoutButton.isHidden = true
        
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.right.equalToSuperview().inset(32)
        }
        
        addSubview(pauseView)
        pauseView.snp.makeConstraints {
            $0.applyWidth()
            $0.top.equalTo(timerLabel.snp.bottom)
            $0.bottom.equalTo(buttonStackView.snp.top)
        }
        pauseView.addSubview(pauseButton)
        pauseButton.snp.makeConstraints {
            $0.applyWidth(16)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview()
        }

        /// окно подсказки
        exerciseDescriptionView.isHidden = true
        addSubview(exerciseDescriptionView)
        exerciseDescriptionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
