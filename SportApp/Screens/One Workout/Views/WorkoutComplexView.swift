import UIKit

final class WorkoutComplexView: UIView {
    
    // MARK: - UI Properties.

    /// картинка тренировки
    let imageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    
    /// Белое view с круглыми краями сверху
    private let view = UIView().apply {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

    /// Тренировки
    let titleLabel = UILabel().apply {
        $0.font = .textRegular28
        $0.textColor = .textBordo
        $0.textAlignment = .center
    }

    /// отображение времени
    let timeCountView = TimeCountView()//добавить констрейны

    /// таблица
    let tableView = UITableView().apply {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.register(WorkoutTableViewCell.self, forCellReuseIdentifier: WorkoutTableViewCell.reuseID)
    }

    /// белое вью
    private let buttonWhiteView = UIView().apply {
        $0.backgroundColor = .white
    }

    /// серое вью для кнопки
    private let grayView = UIView().apply {
        $0.backgroundColor = .colorButton
    }

    /// кнопка начать
    let buttonStart = BasicButton(title: "Начать", color: .textBordo)

    /// подсказка
    let exerciseDescriptionView = ExerciseDescriptionView()

    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview() //картинка до верха супервью
            $0.applyWidth()//до краев
            $0.height.equalTo(255)
        }
        
        /// констрейны Белое view с круглыми краями сверху
        addSubview(view)
        view.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).inset(20)
            $0.applyWidth()
            $0.height.equalTo(40)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.applyWidth()
            $0.bottom.equalToSuperview()
        }
        /// Tаблица,(сделать констрейны до низа view)заменяем констрейн до buttonWhiteView
        addSubview(timeCountView)
        timeCountView.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom).offset(20)
            $0.applyWidth()
        }
        /// белое вью
        addSubview(buttonWhiteView)
        buttonWhiteView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide)//до системной черточки
            $0.applyWidth()
        }
        /// белое вью
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(timeCountView.snp.bottom).offset(16)//верх крепим к низу timeCountView
            $0.applyWidth()//закрепляем на ширину экрана
            $0.bottom.equalTo(buttonWhiteView.snp.top)
        }
        
        // размещаем серое вью (grayView) в белом (buttonWhiteView)
        buttonWhiteView.addSubview(grayView)
        grayView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(1)
            $0.applyWidth()
        }
        /// размещаем в белом вью(buttonWhiteView) кнопку старт(buttonStart)
        buttonWhiteView.addSubview(buttonStart)
        buttonStart.snp.makeConstraints {
            $0.height.equalTo(48)//высоту
            $0.applyWidth(16)//ширину до края
            $0.top.bottom.equalToSuperview().inset(8)//низ к белому вью(buttonWhiteView)
        }
        //переход на вью exerciseDescriptionView
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
