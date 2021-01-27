//
//  IncomeTableViewCell.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit
import DTModelStorage
import SnapKit

class IncomeTableViewCell: UITableViewCell, ModelTransfer {

    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
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

    func update(with model: IncomeEntity) {
        costLabel.text = L10n.Common.Money.rub(model.value)
    }

    private func addSubviews() {
        contentView.addSubview(costLabel)
    }

    private func setupConstraints() {
        costLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }

}
