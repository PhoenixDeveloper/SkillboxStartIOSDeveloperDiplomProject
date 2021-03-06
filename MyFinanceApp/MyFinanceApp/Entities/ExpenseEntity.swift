//
//  ExpenseEntity.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import RealmSwift

class ExpenseEntity: Object, Comparable, Transaction {

    @objc dynamic var name: String = ""
    @objc dynamic var dateCreate: Date = Date()
    @objc dynamic var value: Float = 0

    @objc dynamic var category: ExpensesCategoryEntity?
    
    static func < (lhs: ExpenseEntity, rhs: ExpenseEntity) -> Bool {
        lhs.dateCreate < rhs.dateCreate
    }
}
