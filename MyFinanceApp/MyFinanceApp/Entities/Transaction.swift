//
//  Transaction.swift
//  MyFinanceApp
//
//  Created by Михаил Беленко on 27.01.2021.
//  Copyright © 2021 MOB. All rights reserved.
//

import Foundation

protocol Transaction {
    var value: Float { get }
    var dateCreate: Date { get }
}
