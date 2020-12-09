//
//  IncomesViewController.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 29.09.2020.
//  Copyright © 2020 MOB. All rights reserved.
//

import UIKit

final class IncomesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        addSubviews()
        setupConstraints()
        configureEvents()
    }

    private func configureEvents() {
    }

    private func configureUI() {
        //view.backgroundColor = Asset.backgroundColor.color
        view.backgroundColor = UIColor.blue
        title = L10n.Incomes.title
    }

    private func addSubviews() {
    }

    private func setupConstraints() {
    }
}
