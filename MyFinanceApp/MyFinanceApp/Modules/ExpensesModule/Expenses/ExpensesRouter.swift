//
//  ExpensesRouter.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 14.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import Foundation

class ExpensesRouter {

    // MARK: - Properties
    private weak var viewController: ExpensesViewController?

    // MARK: - Init
    init(viewController: ExpensesViewController) {
        self.viewController = viewController
    }

    // MARK: - Methods
    func goToCharts(category: ExpensesCategoryEntity) {
        let chartsVC = ChartsViewController()
        chartsVC.category = category
        chartsVC.hidesBottomBarWhenPushed = true

        viewController?.navigationController?.pushViewController(chartsVC, animated: true)
    }
}
