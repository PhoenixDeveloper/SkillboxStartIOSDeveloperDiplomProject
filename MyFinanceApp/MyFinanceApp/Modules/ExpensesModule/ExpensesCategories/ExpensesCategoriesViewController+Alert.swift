//
//  ExpensesCategoriesViewController+Alert.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit

extension ExpensesCategoriesViewController {
    func showAlert() {
        let alert = UIAlertController(title: L10n.ExpensesCategories.Alert.description, message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = L10n.ExpensesCategories.Alert.placeholder
        }

        alert.addAction(UIAlertAction(title: L10n.ExpensesCategories.add, style: .default, handler: { [weak alert] (_) in
            guard let alert = alert, let text = alert.textFields?[0].text else { return }

            TransactionStorage.shared.addExpensesCategory(name: text)
        }))

        self.present(alert, animated: true, completion: nil)
    }
}
