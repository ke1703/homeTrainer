import Foundation
import UIKit

final class RemindersView: UIView {

    // MARK: - UI Properties.

    /// Заголовок Напоминания
    private let titleLabel = UILabel().apply {
        $0.font = .squadHeavy28
        $0.textColor = .black
        $0.text = "Напоминания"
        $0.textAlignment = .center
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .interactive
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        tableView.tableFooterView = UIView()
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionFooterHeight = 0.0
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))

        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.reuseID)
        tableView.register(DisclaimerTVCell.self, forCellReuseIdentifier: DisclaimerTVCell.reuseID)
        tableView.register(AddItemTVCell.self, forCellReuseIdentifier: AddItemTVCell.reuseID)

        return tableView
    }()

    // MARK: - Initialization.

    init() {
        super.init(frame: .zero)
        backgroundColor = .white

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(-38)
            $0.applyWidth(16)
        }

        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.applyWidth()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.bottom.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
