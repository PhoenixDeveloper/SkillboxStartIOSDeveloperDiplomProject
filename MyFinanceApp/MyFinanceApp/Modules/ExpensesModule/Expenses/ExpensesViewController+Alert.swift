//
//  ExpensesViewController+Alert.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 14.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension ExpensesViewController {
    func showAlert() {
        let alert = UIAlertController(title: L10n.Expenses.Alert.description, message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = L10n.Expenses.Alert.placeholderName
        }

        alert.addTextField { (textField) in
            textField.placeholder = L10n.Expenses.Alert.placeholderSum
            textField.keyboardType = .decimalPad
        }

        guard let nameTextField = alert.textFields?[0], let sumTextField = alert.textFields?[1] else {
            return
        }

        let okButton = UIAlertAction(title: L10n.Expenses.add, style: .default, handler: { [unowned self] (_) in
            guard let name = nameTextField.text, let sumString = sumTextField.text, let sum = Float(sumString) else { return }

            TransactionStorage.shared.addExpense(name: name, value: sum, category: self.category)
        })

        okButton.isEnabled = false


        Observable.merge(nameTextField.rx.controlEvent(.editingChanged).asObservable(), sumTextField.rx.controlEvent(.editingChanged).asObservable()).subscribe(onNext: { _ in
            guard let name = nameTextField.text, let sum = sumTextField.text else {
                okButton.isEnabled = false
                return
            }

            okButton.isEnabled = !(name.isEmpty || sum.isEmpty)
        }).disposed(by: disposeBag)

        alert.addAction(okButton)

        self.present(alert, animated: true, completion: nil)
    }
}
