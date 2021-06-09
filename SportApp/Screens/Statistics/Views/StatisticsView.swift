import Foundation
import UIKit
import Charts

final class StatisticsView: UIView {
    
    // MARK: - UI Properties.

    /// заголовок
    private let titleLabel = UILabel().apply {
        $0.font = .squadHeavy
        $0.textColor = .black
        $0.text = "Статистика"
        $0.textAlignment = .center
    }

    /// отображение графика линии
    let graphicView = LineChartView()

    /// таблица
    let tableView = UITableView().apply {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.register(StatisticsTableViewCell.self, forCellReuseIdentifier: StatisticsTableViewCell.reuseID)
    }

    /// пройдите тренировку для отображения статистики
    private let statisticLabel = UILabel().apply {
        $0.font = .textBold20
        $0.textColor = .black
        $0.text = "Пройдите тренировку для отображения статистики"
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    /// картинка вместо графика статистики  при первом открытии
    private let iconImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "note")
        $0.snp.makeConstraints {
            $0.size.equalTo(100)
        }
    }

    /// стэк вертикальный из
    lazy var stackView = UIStackView().apply {
        $0.distribution = .fill
        $0.alignment = .center
        $0.axis = .vertical
        $0.spacing = 8
        $0.isUserInteractionEnabled = false
        $0.isHidden = true  // скрывает временный стек
    }

    // MARK: - Initialization.
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        // Статистика
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.applyWidth(13)
        }
        ///стек вью
        stackView.addArrangedSubviews(statisticLabel, iconImageView)
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.applyWidth(16)
        }
        // вью
        addSubview(graphicView)
        graphicView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.applyWidth(16)
            $0.height.equalTo(194)
        }
        //Tаблица
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(graphicView.snp.bottom).offset(8)//верх крепим к низу графика
            $0.applyWidth()//закрепляем на ширину экрана
            $0.bottom.equalTo(safeAreaLayoutGuide)//до системной черточки
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
