//
//  TransactionStorage.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 13.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import RealmSwift
import RxSwift

enum PeriodOfTime {
    case week, month, quarter, all
}

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

    func getIncomesForDaySum(day: Date) -> Float {
        incomes.filter({ income -> Bool in
            let dateComponent = Calendar.current.dateComponents([.day, .month, .year], from: income.dateCreate)

            guard let dateCreate = Calendar.current.date(from: dateComponent) else {
                return false
            }

            return dateCreate == day
        }).reduce(0, { $0 + $1.value })
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

    func getExpenses() -> [ExpenseEntity] {
        expenses.sorted()
    }

    func getExpensesForDaySum(day: Date) -> Float {
        expenses.filter({ expense -> Bool in
            let dateComponent = Calendar.current.dateComponents([.day, .month, .year], from: expense.dateCreate)

            guard let dateCreate = Calendar.current.date(from: dateComponent) else {
                return false
            }

            return dateCreate == day
        }).reduce(0, { $0 + $1.value })
    }

    func getNowBalance() -> Float {
        incomes.reduce(0, { $0 + $1.value }) - expenses.reduce(0, { $0 + $1.value })
    }

    func getTransactionsForPeriod(period: PeriodOfTime) -> [Transaction] {
        var dateStart: Date!

        let dateComponent = Calendar.current.dateComponents([.day, .month, .year], from: Date())

        let startCurrentDate = Calendar.current.date(from: dateComponent) ?? Date()

        switch period {
        case .week:
            dateStart = Calendar.current.date(byAdding: .day, value: -7, to: startCurrentDate)
        case .month:
            dateStart = Calendar.current.date(byAdding: .month, value: -1, to: startCurrentDate)
        case .quarter:
            dateStart = Calendar.current.date(byAdding: .month, value: -3, to: startCurrentDate)
        case .all:
            dateStart = Date(timeIntervalSince1970: 0)
        }

        return (getIncomes() + getExpenses()).filter({ $0.dateCreate > dateStart })
    }
}
