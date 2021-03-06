//
//  ExpenseCategoryEntity.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import RealmSwift

class ExpensesCategoryEntity: Object, Comparable {
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "name"
    }

    static func < (lhs: ExpensesCategoryEntity, rhs: ExpensesCategoryEntity) -> Bool {
        lhs.name < rhs.name
    }
}
