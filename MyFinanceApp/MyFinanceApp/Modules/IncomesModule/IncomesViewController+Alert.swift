//
//  IncomesViewController+Alert.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension IncomesViewController {
    func showAlert() {
        let alert = UIAlertController(title: L10n.Incomes.Alert.description, message: nil, preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = L10n.Incomes.Alert.placeholder
            textField.keyboardType = .decimalPad
        }

        guard let sumTextField = alert.textFields?[0] else { return }

        let okButton = UIAlertAction(title: L10n.Incomes.add, style: .default, handler: { (_) in
            guard let text = sumTextField.text, let value = Float(text) else { return }

            TransactionStorage.shared.addIncome(value: value)
        })

        okButton.isEnabled = false

        sumTextField.rx.controlEvent(.editingChanged).subscribe(onNext: { _ in
            guard let text = sumTextField.text else {
                okButton.isEnabled = false
                return
            }

            okButton.isEnabled = !text.isEmpty
        }).disposed(by: disposeBag)

        alert.addAction(okButton)

        alert.addAction(UIAlertAction(title: L10n.Common.cancel, style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
