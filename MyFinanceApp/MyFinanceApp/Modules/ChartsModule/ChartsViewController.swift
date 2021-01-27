//
//  ChartsViewController.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 29.09.2020.
//  Copyright © 2020 MOB. All rights reserved.
//

import UIKit
import Charts
import RxSwift
import RxCocoa

final class ChartsViewController: UIViewController {

    private let disposeBag = DisposeBag()

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: L10n.Charts.Segmented.first, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: L10n.Charts.Segmented.second, at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: L10n.Charts.Segmented.third, at: 2, animated: true)
        segmentedControl.insertSegment(withTitle: L10n.Charts.Segmented.fourth, at: 3, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()

    private lazy var chartsView: LineChartView = {
        let charts = LineChartView()
        charts.rightAxis.enabled = false
        charts.xAxis.labelPosition = .bottom
        charts.animate(yAxisDuration: 1)
        return charts
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        addSubviews()
        setupConstraints()
        configureEvents()
        changeSegment()
    }

    private func changeSegment() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            setData(period: .week)
        case 1:
            setData(period: .month)
        case 2:
            setData(period: .quarter)
        case 3:
            setData(period: .all)
        default:
            fatalError(L10n.Error.emptySegment)
        }
    }

    private func setData(period: PeriodOfTime) {
        var incomesChartDataEntries: [ChartDataEntry] = []
        var expensesChartDataEntries: [ChartDataEntry] = []

        let transactionArray = TransactionStorage.shared.getTransactionsForPeriod(period: period)

        let dateArray = Array(Set(transactionArray.map({ transaction -> Date in
            let dateComponent = Calendar.current.dateComponents([.day, .month, .year], from: transaction.dateCreate)

            return Calendar.current.date(from: dateComponent) ?? transaction.dateCreate
        }))).sorted()

        for (index, date) in dateArray.enumerated() {

            incomesChartDataEntries.append(ChartDataEntry(x: Double(index), y: Double(TransactionStorage.shared.getIncomesForDaySum(day: date))))

            expensesChartDataEntries.append(ChartDataEntry(x: Double(index), y: Double(TransactionStorage.shared.getExpensesForDaySum(day: date))))
        }

        chartsView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateArray.map({ date -> String in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM"

            return dateFormatter.string(from: date)
        }))
        chartsView.xAxis.setLabelCount(dateArray.count, force: true)

        let incomesSetData = LineChartDataSet(entries: incomesChartDataEntries, label: L10n.Incomes.title)
        let expensesSetData = LineChartDataSet(entries: expensesChartDataEntries, label: L10n.Expenses.title)

        incomesSetData.colors = .init(arrayLiteral: .systemGreen)
        incomesSetData.circleColors = .init(arrayLiteral: .systemGray)

        expensesSetData.colors = .init(arrayLiteral: .systemRed)
        expensesSetData.circleColors = .init(arrayLiteral: .systemGray)

        let lineChartData = LineChartData(dataSets: [incomesSetData, expensesSetData])
        lineChartData.setDrawValues(false)

        chartsView.data = lineChartData
    }

    private func configureEvents() {
        Observable.merge(TransactionStorage.shared.changeBalance, segmentedControl.rx.controlEvent(.valueChanged).asObservable()).subscribe(onNext: { [unowned self] in
            self.changeSegment()
        }).disposed(by: disposeBag)
    }

    private func configureUI() {
        view.backgroundColor = Asset.backgroundColor.color
        title = L10n.Charts.title
    }

    private func addSubviews() {
        view.addSubview(segmentedControl)
        view.addSubview(chartsView)
    }

    private func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        chartsView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
}
