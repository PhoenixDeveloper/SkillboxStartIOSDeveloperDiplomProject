//
//  DefaultButton.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialization()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initialization()
    }

    private func initialization() {
        backgroundColor = Asset.buttonColor.color
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 24
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

}
