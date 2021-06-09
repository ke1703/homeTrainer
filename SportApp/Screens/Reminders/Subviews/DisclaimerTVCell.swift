import UIKit

final class DisclaimerTVCell: UITableViewCell {

    // MARK: - UI Properties.
    
    let titleLabel = UILabel().apply {
        $0.font = .textRegular
        $0.textAlignment = .left
        $0.textColor = .black
        $0.numberOfLines = 0
    }

    // MARK: - Initialization.

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView).inset(16)
            $0.trailing.equalTo(contentView)
            $0.top.equalTo(contentView)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure.

    func configure(text: String) {
        titleLabel.text = text
    }
}
