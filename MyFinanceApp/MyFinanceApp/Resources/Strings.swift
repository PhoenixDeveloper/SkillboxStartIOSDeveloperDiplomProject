// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Charts {
    /// Графики
    internal static let title = L10n.tr("Localizable", "Charts.title")
  }

  internal enum Common {
    internal enum Money {
      /// %.2f ₽
      internal static func rub(_ p1: Float) -> String {
        return L10n.tr("Localizable", "Common.Money.rub", p1)
      }
    }
  }

  internal enum Expenses {
    /// Добавить расход
    internal static let add = L10n.tr("Localizable", "Expenses.add")
    /// График платежей
    internal static let goToCharts = L10n.tr("Localizable", "Expenses.goToCharts")
    /// Расходы
    internal static let title = L10n.tr("Localizable", "Expenses.title")
    internal enum Alert {
      /// Введите расход
      internal static let description = L10n.tr("Localizable", "Expenses.Alert.description")
      /// Наименование
      internal static let placeholderName = L10n.tr("Localizable", "Expenses.Alert.placeholderName")
      /// Сумма
      internal static let placeholderSum = L10n.tr("Localizable", "Expenses.Alert.placeholderSum")
    }
    internal enum Header {
      /// На что
      internal static let first = L10n.tr("Localizable", "Expenses.Header.first")
      /// Когда
      internal static let second = L10n.tr("Localizable", "Expenses.Header.second")
      /// Сколько
      internal static let third = L10n.tr("Localizable", "Expenses.Header.third")
    }
  }

  internal enum ExpensesCategories {
    /// Добавить категорию расходов
    internal static let add = L10n.tr("Localizable", "ExpensesCategories.add")
    internal enum Alert {
      /// Введите наименование категории
      internal static let description = L10n.tr("Localizable", "ExpensesCategories.Alert.description")
      /// Наименование
      internal static let placeholder = L10n.tr("Localizable", "ExpensesCategories.Alert.placeholder")
    }
  }

  internal enum Incomes {
    /// Добавить доход
    internal static let add = L10n.tr("Localizable", "Incomes.add")
    /// Текущий баланс
    internal static let nowBalance = L10n.tr("Localizable", "Incomes.nowBalance")
    /// Доходы
    internal static let title = L10n.tr("Localizable", "Incomes.title")
    internal enum Alert {
      /// Введите сумму
      internal static let description = L10n.tr("Localizable", "Incomes.Alert.description")
      /// Сумма
      internal static let placeholder = L10n.tr("Localizable", "Incomes.Alert.placeholder")
    }
  }

  internal enum Root {
    /// График
    internal static let charts = L10n.tr("Localizable", "Root.charts")
    /// Расходы
    internal static let expenses = L10n.tr("Localizable", "Root.expenses")
    /// Доходы
    internal static let incomes = L10n.tr("Localizable", "Root.incomes")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
// swiftlint:enable convenience_type
