//
//  ExpenseHeaderSectionView.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 27.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit
import DTModelStorage

class ExpenseHeaderSectionView: UITableViewHeaderFooterView, ModelTransfer {

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private var labelArray: [UILabel] = []

    func update(with model: [String]) {
        for title in model {
            labelArray.append(createLabel(text: title))
        }

        contentStackView.removeAllArrangedSubviews()

        addSubviews()
        setupConstraints()
    }

    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = Asset.tableHeaderColor.color
        label.textAlignment = .center
        label.text = text
        return label
    }

    private func addSubviews() {
        for label in labelArray {
            contentStackView.addArrangedSubview(label)
        }

        contentView.addSubview(contentStackView)
    }

    private func setupConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
