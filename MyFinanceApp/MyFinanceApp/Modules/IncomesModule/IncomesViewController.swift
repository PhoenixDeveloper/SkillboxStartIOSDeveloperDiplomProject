//
//  IncomesViewController.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 29.09.2020.
//  Copyright © 2020 MOB. All rights reserved.
//

import UIKit
import DTTableViewManager
import RxSwift
import RxCocoa

final class IncomesViewController: UIViewController, DTTableViewManageable {

    // MARK: - Properties

    private let disposeBag = DisposeBag()

    // MARK: - UI Elements

    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var nowBalanceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = L10n.Incomes.nowBalance
        label.textAlignment = .left
        return label
    }()

    private lazy var nowBalanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = L10n.Common.Money.rub(TransactionStorage.shared.getNowBalance())
        label.textAlignment = .right
        return label
    }()

    var tableView: UITableView! = UITableView(frame: .zero, style: .plain)

    private lazy var addButton: UIButton = {
        let button = DefaultButton()
        button.setTitle(L10n.Incomes.add, for: .normal)
        return button
    }()

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        addSubviews()
        setupConstraints()
        configureTableView()
        configureEvents()
    }

    private func configureEvents() {
        TransactionStorage.shared.changeIncomes.subscribe(onNext: { [unowned self] in
            self.manager.memoryStorage.setItems(TransactionStorage.shared.getIncomes())
        }).disposed(by: disposeBag)
        
        TransactionStorage.shared.changeBalance.subscribe(onNext: { [unowned self] in
            self.nowBalanceLabel.text = L10n.Common.Money.rub(TransactionStorage.shared.getNowBalance())
        }).disposed(by: disposeBag)

        addButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] in
            self.showAlert()
        }).disposed(by: disposeBag)
    }

    private func configureUI() {
        view.backgroundColor = Asset.backgroundColor.color
        tableView.backgroundColor = Asset.backgroundColor.color

        title = L10n.Incomes.title
    }

    private func configureTableView() {
        manager.memoryStorage.setSectionHeaderModels([L10n.Incomes.title])
        manager.register(IncomeTableViewCell.self)

        manager.memoryStorage.setItems([Float(10000), Float(15000), Float(25000)])
    }

    private func addSubviews() {
        topStackView.addArrangedSubview(nowBalanceTitleLabel)
        topStackView.addArrangedSubview(nowBalanceLabel)

        view.addSubview(topStackView)
        view.addSubview(tableView)
        view.addSubview(addButton)
    }

    private func setupConstraints() {
        topStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
