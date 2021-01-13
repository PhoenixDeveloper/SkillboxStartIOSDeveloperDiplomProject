//
//  IncomeEntity.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import RealmSwift

class IncomeEntity: Object, Comparable {
    @objc dynamic var value: Float = 0
    @objc dynamic var dateCreate: Date = Date()

    static func < (lhs: IncomeEntity, rhs: IncomeEntity) -> Bool {
        lhs.dateCreate < rhs.dateCreate
    }
}
