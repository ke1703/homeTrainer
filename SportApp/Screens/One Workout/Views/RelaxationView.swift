import Foundation
import UIKit
import KCCircularTimer
// ОТДЫХ
final class RelaxationView: UIView {
    
    // MARK: - UI Properties.
    
    /// заголовок
    private let titleLabel = UILabel().apply {
        $0.font = .textHeavy50
        $0.textColor = .black
        $0.text = "Отдых"
        $0.textAlignment = .center
    }

    /// таймер время секундомер
    let timerLabel = UILabel().apply {
        $0.font = .textRegular22
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    /// кнопка завершить тренировку
    let finishWorkoutButton = ImageTextButton(title: "Завершить тренировку", imageBefore: nil, imageAfter: UIImage(named: "nexts"))
    
    /// кнопка + cek
    let secondsButton = BasicButton(title: "+20 сек", color: .grayButton)
    
    /// кнопка Пропустить
    let skipButton = BasicButton(title: "Пропустить", color: .textBordo)

    /// стек для кнопок
    private lazy var buttonStackView = UIStackView().apply {
        $0.distribution = .fillEqually
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 8
    }

    /// серое view с круглыми краями сверху
    let grayView = UIView().apply {
        $0.backgroundColor = .grayView
        $0.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

    /// номер тренировки
    let lessonsCountLabel = UILabel().apply {
        $0.font = .textRegular
        $0.text = "Следующее 2 из 16"
        $0.textColor = .black
    }

    /// название тренировки
    let nextLessonNameLabel = UILabel().apply {
        $0.font = .textRegular22
        $0.textColor = .textBordo
        $0.numberOfLines = 0
    }

    /// кнопка помощи
    let helpButton = UIButton().apply {
        $0.setImage(UIImage(named: "icons8-помощь-100 1"), for: .normal)
    }

    /// повторить
    let descriptionNextLessonLabel = UILabel().apply {
        $0.font = .textMedium10
        $0.text = "×20"
        $0.textColor = .black
    }

    /// добавление всплывающего окна при нажатии на кнопку помощь
    let exerciseDescriptionView = ExerciseDescriptionView()
    
    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        // название  ОТДЫХ
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(266)
            $0.applyWidth(16)
        }
        // таймер время секундомер
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.height.equalTo(24)
            $0.width.equalTo(107)
            $0.applyWidth(16)//до краев
        }
        // завершить тренировку
        addSubview(finishWorkoutButton)
        finishWorkoutButton.snp.makeConstraints {
            $0.top.equalTo(timerLabel.snp.bottom).offset(16)
            $0.applyWidth(76)
        }
        // серое view с круглыми краями сверху
        addSubview(grayView)
        grayView.snp.makeConstraints {
            $0.applyWidth()
            $0.bottom.equalToSuperview()
        }
        // стэк из кнопок
        buttonStackView.addArrangedSubviews([secondsButton, skipButton])
        // кнопка +20cek
        addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(grayView.snp.top).offset(-16)
            $0.applyWidth(16)
            $0.height.equalTo(48)
        }
        // текст СЛЕДУЮЩЕЕ 2 из 16
        grayView.addSubview(lessonsCountLabel)
        lessonsCountLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.applyWidth(16)
        }
        // кнопка помощи
        grayView.addSubview(helpButton)
        helpButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.right.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        // название тренировки ОТЖИМАНИЯ
        grayView.addSubview(nextLessonNameLabel)
        nextLessonNameLabel.snp.makeConstraints {
            $0.top.equalTo(lessonsCountLabel.snp.bottom).offset(4)
            $0.applyWidth(16)
        }
        // в серое вью добавляем - лэйбл повторить
        grayView.addSubview(descriptionNextLessonLabel)
        descriptionNextLessonLabel.snp.makeConstraints {
            $0.top.equalTo(nextLessonNameLabel.snp.bottom).offset(4)
            $0.applyWidth(16)
            $0.bottom.equalToSuperview().inset(30)
        }
        // добавление всплывающего окна при нажатии на кнопку помощь
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
