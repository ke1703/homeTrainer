import Foundation
import UIKit
import KCCircularTimer
/// Финиш
final class FinishWorkoutView: UIView {
    
    // MARK: - UI Properties.
    
    private let imageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "free-icon-victory-1066387")
    }

    /// текст "Отлично! Вы сделали это!"
    private let titleLabel = UILabel().apply {
        $0.font = .textRegular24
        $0.textColor = .textBordo
        $0.text = "Отлично! Вы сделали это!"
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    /// Белое view с круглыми краями сверху
    private let view = UIView().apply {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

    /// картинка часы
    private let watchImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "free-icon-time-4151173")
    }

    /// длительность
    private let durationLabel = UILabel().apply {
        $0.font = .textMedium18
        $0.textColor = .black
        $0.text = "Длительность"
    }

    /// time затраченное пользователем время на тренировки
    let timeLabel = UILabel().apply {//
        $0.font = .footnoteRegular
        $0.textColor = .grayButton
    }

    /// картинка весы
    private let weightImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "free-icon-bathroom-scale-2770966")
    }

    /// лэйбл Текущий вес
    private let currentWeightLabel = UILabel().apply {
        $0.font = .textMedium18
        $0.textColor = .black
        $0.text = "Текущий вес"
    }

    /// weight вес пользователя
    let weightLabel = UILabel().apply {
        $0.font = .footnoteRegular
        $0.textColor = .grayButton
    }

    /// кнопка Ещё тренировки
    let moreWorcautButton = ImageTextButton(title: "Ещё тренировки", imageBefore: nil, imageAfter: UIImage(named: "BordoNext"))
    
    /// кнопка карандаш
    let editWeightButton = UIButton().apply {
        $0.setImage(UIImage(named: "free-icon-pencil-3094216"), for: .normal)
    }
    
    /// скролл вью для маленьких экранов
    let scrollView = UIScrollView()
    
    /// вью изменения веса
    let changeWeightView = ChangeWeightView()
    
    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .black
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview() //картинка до верха супервью
            $0.centerX.equalToSuperview()
            $0.size.equalTo(243)
        }
        // текст "Отлично! Вы сделали это!"
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(36)
            $0.applyWidth(20)
        }
        //констрейны Белое view с круглыми краями сверху
        addSubview(view)
        view.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(17)
            $0.applyWidth()
            $0.bottom.equalToSuperview()
        }
        //в белое вью добавляем картинку часы
        view.addSubview(watchImageView)
        watchImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalToSuperview().inset(24)
            $0.size.equalTo(50)
        }
        //длительность лэйбл
        view.addSubview(durationLabel)
        durationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.left.equalTo(watchImageView.snp.right).offset(8)
            $0.right.equalToSuperview()
        }
        //time затраченное время
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.left.equalTo(watchImageView.snp.right).offset(8)
            $0.top.equalTo(durationLabel.snp.bottom).offset(8)
            $0.right.equalToSuperview().inset(24)
        }
        //добавляем картинку весы Weight
        view.addSubview(weightImageView)
        weightImageView.snp.makeConstraints {
            $0.top.equalTo(watchImageView.snp.bottom).offset(24)
            $0.left.equalToSuperview().inset(24)
            $0.size.equalTo(50)
        }
        // лэйбл Текущий вес
        view.addSubview(currentWeightLabel)
        currentWeightLabel.snp.makeConstraints {
            $0.top.equalTo(watchImageView.snp.bottom).offset(24)
            $0.left.equalTo(weightImageView.snp.right).offset(8)
        }
        //Вес пользователя
        view.addSubview(weightLabel)
        weightLabel.snp.makeConstraints {
            $0.top.equalTo(currentWeightLabel.snp.bottom).offset(8)
            $0.left.equalTo(weightImageView.snp.right).offset(8)
        }
        
        //еще тренировки moreWorcautButton
        moreWorcautButton.nameLabel.textColor = .textBordo
        view.addSubview(moreWorcautButton)
        moreWorcautButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(36)
            $0.right.equalToSuperview().inset(16)
        }
        //карандашик
        view.addSubview(editWeightButton)
        editWeightButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(30)
            $0.centerY.equalTo( weightImageView.snp.centerY)
            $0.size.equalTo(30)
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        //переход по карандашику на следующее вью изменения веса
        scrollView.isHidden = true
        scrollView.addSubview(changeWeightView)
        changeWeightView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
