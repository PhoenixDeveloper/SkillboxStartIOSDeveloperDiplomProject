//
//  IncomesViewController+Alert.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit

extension IncomesViewController {
    func showAlert() {
        let alert = UIAlertController(title: L10n.Incomes.Alert.description, message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = L10n.Incomes.Alert.placeholder
            textField.keyboardType = .decimalPad
        }

        alert.addAction(UIAlertAction(title: L10n.Incomes.add, style: .default, handler: { [weak alert] (_) in
            guard let alert = alert, let text = alert.textFields?[0].text, let value = Float(text) else { return }

            TransactionStorage.shared.addIncome(value: value)
        }))

        self.present(alert, animated: true, completion: nil)
    }
}
