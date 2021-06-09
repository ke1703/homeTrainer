import UIKit

final class StatisticsTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties.

    /// серая граница
    private let grayBorderView = UIView().apply {
        $0.layer.cornerRadius = 16
        $0.layer.borderColor = UIColor.colorButton.cgColor
        $0.layer.borderWidth = 1
    }

    /// каpтинка тренировки
    let iconImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }

    /// название тренировки
    let workoutNameLabel = UILabel().apply {
        $0.font = .textRegular20
        $0.textColor = .black
        $0.numberOfLines = 2
    }

    /// заголовок вес пользователя
    private let weightTitleLabel = UILabel().apply {
        $0.font = .textMedium16
        $0.textColor = .grayButton
        $0.text = "Вес"
    }

    /// weight - показания весa пользователя
    let weightTextLabel = UILabel().apply {
        $0.font = .textRegular18
        $0.textColor = .black
    }
    
    // MARK: - Initialization.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        // вью тренировка новичок для стека
        contentView.addSubview(grayBorderView)
        grayBorderView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.applyWidth(16)
        }
        // каpтинка тренировки
        grayBorderView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(25)
            $0.left.equalToSuperview().inset(8)
            $0.size.equalTo(30)
        }
        // продвинутость название тренировки
        grayBorderView.addSubview(workoutNameLabel)
        workoutNameLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.left.equalTo(iconImageView.snp.right).offset(8)
        }
        // текст вес пользователя weight
        grayBorderView.addSubview(weightTitleLabel)
        weightTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.right.equalToSuperview()
            $0.width.equalTo(86)
        }
        // weight - показания весa пользователя
        grayBorderView.addSubview(weightTextLabel)
        weightTextLabel.snp.makeConstraints {
            $0.top.equalTo(weightTitleLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(12)
            $0.right.equalToSuperview()
            $0.width.equalTo(86)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
