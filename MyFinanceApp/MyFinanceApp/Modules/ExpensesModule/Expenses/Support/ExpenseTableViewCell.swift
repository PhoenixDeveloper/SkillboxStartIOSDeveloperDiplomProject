//
//  ExpenseTableViewCell.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 14.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit
import DTModelStorage

class ExpenseTableViewCell: UITableViewCell, ModelTransfer {

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()

    private lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initialization()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialization()
    }

    private func initialization() {
        selectionStyle = .none

        addSubviews()
        setupConstraints()
    }

    func update(with model: ExpenseEntity) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"

        nameLabel.text = model.name
        dateLabel.text = dateFormatter.string(from: model.dateCreate)
        sumLabel.text = L10n.Common.Money.rub(model.value)
    }

    private func addSubviews() {
        contentStackView.addArrangedSubview(nameLabel)
        contentStackView.addArrangedSubview(dateLabel)
        contentStackView.addArrangedSubview(sumLabel)

        contentView.addSubview(contentStackView)
    }

    private func setupConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }

}
