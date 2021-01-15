//
//  TransactionStorage.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import RealmSwift
import RxSwift

class TransactionStorage {

    static let shared = TransactionStorage()

    var changeIncomes = PublishSubject<Void>()
    var changeExpensesCategories = PublishSubject<Void>()
    var changeExpenses = PublishSubject<Void>()
    var changeBalance = PublishSubject<Void>()

    private let disposeBag = DisposeBag()

    private lazy var incomes: [IncomeEntity] = Array(self.realm.objects(IncomeEntity.self))
    private lazy var expensesCategories: [ExpensesCategoryEntity] = Array(self.realm.objects(ExpensesCategoryEntity.self))
    private lazy var expenses: [ExpenseEntity] = Array(self.realm.objects(ExpenseEntity.self))

    private let realm = try! Realm()

    private init() {
        Observable.merge(changeIncomes, changeExpenses).subscribe(onNext: { [unowned self] in
            self.changeBalance.onNext(())
        }).disposed(by: disposeBag)
    }

    func addIncome(value: Float) {
        let income = IncomeEntity()
        income.value = value

        try! realm.write {
            realm.add(income)
            incomes.append(income)

            changeIncomes.onNext(())
        }
    }

    func getIncomes() -> [IncomeEntity] {
        incomes.sorted()
    }

    func addExpensesCategory(name: String) {
        let expensesCategory = ExpensesCategoryEntity()
        expensesCategory.name = name

        try! realm.write {
            realm.add(expensesCategory)
            expensesCategories.append(expensesCategory)

            changeExpensesCategories.onNext(())
        }
    }

    func getExpensesCategories() -> [ExpensesCategoryEntity] {
        expensesCategories.sorted()
    }

    func addExpense(name: String, value: Float, category: ExpensesCategoryEntity) {
        let expense = ExpenseEntity()
        expense.name = name
        expense.value = value
        expense.category = category

        try! realm.write {
            realm.add(expense)
            expenses.append(expense)

            changeExpenses.onNext(())
        }
    }

    func getExpensesByCategory(category: ExpensesCategoryEntity) -> [ExpenseEntity] {
        expenses.filter({ $0.category == category }).sorted()
    }

    func getNowBalance() -> Float {
        incomes.reduce(0, { $0 + $1.value }) - expenses.reduce(0, { $0 + $1.value })
    }
}
