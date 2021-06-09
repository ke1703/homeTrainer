import UIKit

final class NotificationTableViewCell: UITableViewCell {
    
    // MARK: - UI Properties.
    
    let deleteButton = UIButton().apply {
        $0.backgroundColor = .clear
        $0.setImage(UIImage(named: "icon_delete"), for: .normal)
        
        $0.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(24)
        }
    }
    
    private let iconImageView = UIImageView().apply {
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "icon_header_next")
    }
    
    private let timeLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 32, weight: .semibold)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    let switcher = UISwitch().apply {
        $0.onTintColor = .textBordo
        $0.tintColor = UIColor.white.withAlphaComponent(0.3)
        $0.snp.makeConstraints {
            $0.width.equalTo(47)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ deleteButton, timeLabel, switcher, iconImageView ])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 12
        return stackView
    }()
    
    // MARK: - Injected Properties.
    
    weak var delegateSwitch: SwitchNotificationDelegate?
    weak var deleteDelegate: DeleteNotificationDelegate?
    var timeModel: Reminder?
    
    // MARK: - Initialization.
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.applyWidth(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        
        switcher.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        deleteButton.addTarget(self, action: #selector(deleteTime), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods.
    
    func configure(model: Reminder, isEditing: Bool) {
        self.timeModel = model
        timeLabel.text = model.time.toString(dateFormat: .time)
        switcher.isOn = model.isOn
        deleteButton.isHidden = !isEditing
        switcher.isHidden = isEditing
        iconImageView.isHidden = !isEditing
    }
    
    // MARK: - User Interaction.
    
    @objc
    func changeValue() {
        guard var model = timeModel else { return }
        model.isOn = !model.isOn
        delegateSwitch?.changeSwitch(timeModel: model)
    }
    
    @objc
    func deleteTime() {
        guard let model = timeModel else { return }
        deleteDelegate?.deleteTime(timeModel: model)
    }
}
