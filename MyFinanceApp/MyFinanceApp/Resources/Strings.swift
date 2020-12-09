// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Charts {
    /// Графики
    internal static let title = L10n.tr("Localizable", "Charts.title")
  }

  internal enum Expenses {
    /// Расходы
    internal static let title = L10n.tr("Localizable", "Expenses.title")
  }

  internal enum Incomes {
    /// Доходы
    internal static let title = L10n.tr("Localizable", "Incomes.title")
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
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
