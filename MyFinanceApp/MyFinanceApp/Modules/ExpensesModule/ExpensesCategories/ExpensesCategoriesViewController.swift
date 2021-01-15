//
//  ExpensesViewController.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 29.09.2020.
//  Copyright © 2020 MOB. All rights reserved.
//

import UIKit
import DTTableViewManager
import RxSwift
import RxCocoa

final class ExpensesCategoriesViewController: UIViewController, DTTableViewManageable {

    // MARK: - Properties

    let disposeBag = DisposeBag()

    private var router: ExpensesCategoriesRouter?

    // MARK: - UI Elements

    var tableView: UITableView! = UITableView(frame: .zero, style: .plain)

    private lazy var addButton: UIButton = {
        let button = DefaultButton()
        button.setTitle(L10n.ExpensesCategories.add, for: .normal)
        return button
    }()

    // MARK: - Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        router = ExpensesCategoriesRouter(viewController: self)

        configureUI()
        addSubviews()
        setupConstraints()
        configureTableView()
        configureEvents()

        manager.memoryStorage.setItems(TransactionStorage.shared.getExpensesCategories())
    }

    private func configureEvents() {
        TransactionStorage.shared.changeExpensesCategories.subscribe(onNext: { [unowned self] in
            self.manager.memoryStorage.setItems(TransactionStorage.shared.getExpensesCategories())
        }).disposed(by: disposeBag)

        addButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [unowned self] in
            self.showAlert()
        }).disposed(by: disposeBag)
    }

    private func configureUI() {
        view.backgroundColor = Asset.backgroundColor.color
        tableView.backgroundColor = Asset.backgroundColor.color

        title = L10n.Expenses.title
    }

    private func configureTableView() {
        manager.memoryStorage.setSectionHeaderModels([L10n.Expenses.title])
        manager.register(ExpensesCategoryTableViewCell.self)

        manager.didSelect(ExpensesCategoryTableViewCell.self) { [unowned self] _, model, _ in
            self.router?.goToExpenses(category: model)
        }
    }

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(addButton)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
