//
//  RootTabBarController.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 29.09.2020.
//  Copyright © 2020 MOB. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = getItems()
    }

    private func getItems() -> [UIViewController] {
        return [getIncomesModule(), getChartsModule(), getExpensesModule()]
    }
    

    private func getIncomesModule() -> UIViewController {
        let incomesModule = IncomesViewController()

        incomesModule.tabBarItem = UITabBarItem(title: L10n.Root.incomes, image: Asset.incomeIcon.image, tag: 0)

        return incomesModule
    }

    private func getChartsModule() -> UIViewController {
        let chartsModule = ChartsViewController()

        chartsModule.tabBarItem = UITabBarItem(title: L10n.Root.charts, image: Asset.chartsIcon.image, tag: 1)

        return chartsModule
    }

    private func getExpensesModule() -> UINavigationController {
        let expensesModule = ExpensesCategoriesViewController()
        let navigationController = UINavigationController()

        expensesModule.tabBarItem = UITabBarItem(title: L10n.Root.expenses, image: Asset.expensiveIcon.image, tag: 2)

        navigationController.viewControllers = [expensesModule]

        return navigationController
    }

}
