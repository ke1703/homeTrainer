import UIKit

final class WorkoutTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties.

    ///картинка тренировки маленькая
    let workoutImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
    }

    /// серая картинка
    private let grayImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "stripesGroup")
    }
    
    /// название
    let nameLabel = UILabel().apply {
        $0.font = .textMedium16
        $0.textColor = .textPrimary
        $0.numberOfLines = 0
    }
    
    /// описание время или количество
    let descriptionLabel = UILabel().apply {
        $0.font = .textMedium10
        $0.textColor = .colorButton
    }

    /// стек для ровного отображения текста
    private lazy var textStackView = UIStackView().apply {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    // MARK: - Initialization.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(grayImageView)//серая картинка полоски
        grayImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(20)
            $0.width.equalTo(16)
            $0.height.equalTo(6)
        }
        
        addSubview(workoutImageView)//тренировка картинка
        workoutImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.size.equalTo(48)
            $0.left.equalTo(grayImageView.snp.right).offset(16)
        }
        
        textStackView.addArrangedSubviews([nameLabel, descriptionLabel])
        
        addSubview(textStackView)
        textStackView.snp.makeConstraints {
            $0.left.equalTo(workoutImageView.snp.right).offset(16)
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
