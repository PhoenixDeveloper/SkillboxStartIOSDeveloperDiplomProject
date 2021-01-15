//
//  ExpensesCategoriesRouter.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit

class ExpensesCategoriesRouter {

    // MARK: - Properties
    private weak var viewController: ExpensesCategoriesViewController?

    // MARK: - Init
    init(viewController: ExpensesCategoriesViewController) {
        self.viewController = viewController
    }

    // MARK: - Methods
    func goToExpenses(category: ExpensesCategoryEntity) {
        let expensesVC = ExpensesViewController()
        expensesVC.category = category
        expensesVC.hidesBottomBarWhenPushed = true

        viewController?.navigationController?.pushViewController(expensesVC, animated: true)
    }
}
