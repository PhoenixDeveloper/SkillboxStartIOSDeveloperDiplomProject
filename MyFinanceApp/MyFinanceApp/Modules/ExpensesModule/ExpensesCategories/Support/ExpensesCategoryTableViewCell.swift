//
//  ExpensesCategoryTableViewCell.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit
import DTModelStorage

class ExpensesCategoryTableViewCell: UITableViewCell, ModelTransfer {

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
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
        accessoryView = UIImageView(image: Asset.disclosureIndicator.image)

        addSubviews()
        setupConstraints()
    }

    func update(with model: ExpenseCategoryEntity) {
        nameLabel.text = model.name
    }

    private func addSubviews() {
        contentView.addSubview(nameLabel)
    }

    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
