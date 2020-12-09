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
    

    private func getIncomesModule() -> UINavigationController {
        let incomesModule = IncomesViewController()
        let navigationController = UINavigationController()

        incomesModule.tabBarItem = UITabBarItem(title: L10n.Root.incomes, image: Asset.incomeIcon.image, tag: 0)

        navigationController.viewControllers = [incomesModule]

        return navigationController
    }

    private func getChartsModule() -> UINavigationController {
        let chartsModule = ChartsViewController()
        let navigationController = UINavigationController()

        chartsModule.tabBarItem = UITabBarItem(title: L10n.Root.charts, image: Asset.chartsIcon.image, tag: 1)

        navigationController.viewControllers = [chartsModule]

        return navigationController
    }

    private func getExpensesModule() -> UINavigationController {
        let expensesModule = ExpensesViewController()
        let navigationController = UINavigationController()

        expensesModule.tabBarItem = UITabBarItem(title: L10n.Root.expenses, image: Asset.expensiveIcon.image, tag: 2)

        navigationController.viewControllers = [expensesModule]

        return navigationController
    }

}
