//
//  ExpensesViewController.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 14.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit
import DTTableViewManager
import RxSwift
import RxCocoa

class ExpensesViewController: UIViewController, DTTableViewManageable {

    // MARK: - Properties

    var category: ExpensesCategoryEntity!
    let disposeBag = DisposeBag()

    private var router: ExpensesRouter?
    private let addButtonSize: CGSize = .init(width: 56, height: 56)

    // MARK: - UI Elements

    private lazy var goToChartsButton: UIButton = {
        let button = DefaultButton()
        button.setTitle(L10n.Expenses.goToCharts, for: .normal)
        return button
    }()

    var tableView: UITableView! = UITableView(frame: .zero, style: .plain)

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Asset.buttonColor.color
        button.setImage(Asset.iconAdd.image, for: .normal)
        button.layer.cornerRadius = 28
        return button
    }()

    private lazy var addLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.text = L10n.Expenses.add
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        router = ExpensesRouter(viewController: self)

        configureUI()
        addSubviews()
        setupConstraints()
        configureTableView()
        configureEvents()

        manager.memoryStorage.setItems(TransactionStorage.shared.getExpensesByCategory(category: category))
    }

    private func configureEvents() {
        TransactionStorage.shared.changeExpenses.subscribe(onNext: { [unowned self] in
            self.manager.memoryStorage.setItems(TransactionStorage.shared.getExpensesByCategory(category: self.category))
        }).disposed(by: disposeBag)

        addButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] in
            self.showAlert()
        }).disposed(by: disposeBag)

        goToChartsButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] in
            self.router?.goToCharts()
        }).disposed(by: disposeBag)
    }

    private func configureUI() {
        view.backgroundColor = Asset.backgroundColor.color
        tableView.backgroundColor = Asset.backgroundColor.color
    }

    private func configureTableView() {
        manager.memoryStorage.setSectionHeaderModels([["На что", "Когда", "Сколько"]])
        manager.register(ExpenseTableViewCell.self)
    }

    private func addSubviews() {
        view.addSubview(goToChartsButton)
        view.addSubview(tableView)
        view.addSubview(addButton)
        view.addSubview(addLabel)
    }

    private func setupConstraints() {

        goToChartsButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(goToChartsButton.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(addButtonSize)
        }

        addLabel.snp.makeConstraints { make in
            make.top.equalTo(addButton.snp.bottom).offset(4)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

}
