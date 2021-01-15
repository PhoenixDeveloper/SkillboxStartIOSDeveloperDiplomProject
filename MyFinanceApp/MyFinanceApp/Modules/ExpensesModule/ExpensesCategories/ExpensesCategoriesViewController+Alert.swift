//
//  ExpensesCategoriesViewController+Alert.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ExpensesCategoriesViewController {
    func showAlert() {
        let alert = UIAlertController(title: L10n.ExpensesCategories.Alert.description, message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = L10n.ExpensesCategories.Alert.placeholder
        }

        guard let nameTextField = alert.textFields?[0] else {
            return
        }

        let okButton = UIAlertAction(title: L10n.ExpensesCategories.add, style: .default, handler: { (_) in
            guard let name = nameTextField.text else { return }

            TransactionStorage.shared.addExpensesCategory(name: name)
        })

        okButton.isEnabled = false

        nameTextField.rx.controlEvent(.editingChanged).subscribe(onNext: { _ in
            guard let text = nameTextField.text else {
                okButton.isEnabled = false
                return
            }

            okButton.isEnabled = !text.isEmpty
        }).disposed(by: disposeBag)

        alert.addAction(okButton)

        self.present(alert, animated: true, completion: nil)
    }
}
