// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Inbox
  internal static let aInbox = L10n.tr("Localizable", "a_inbox", fallback: "Inbox")
  /// Localizable.strings
  ///   LapseClone
  /// 
  ///   Created by George Leadbeater on 16/04/2023.
  internal static let aJournal = L10n.tr("Localizable", "a_journal", fallback: "Journal")
  /// Me
  internal static let aMe = L10n.tr("Localizable", "a_me", fallback: "Me")
  /// Memories
  internal static let aMemories = L10n.tr("Localizable", "a_memories", fallback: "Memories")
  /// Opens the journal camera
  internal static let accessibilityCamera = L10n.tr("Localizable", "accessibility_camera", fallback: "Opens the journal camera")
  ///  is now your friend on Journal 💕
  internal static let dActivityNewFriend = L10n.tr("Localizable", "d_activity_new_friend", fallback: " is now your friend on Journal 💕")
  ///  reacted %@ to your snap
  internal static func dActivityReaction(_ p1: Any) -> String {
    return L10n.tr("Localizable", "d_activity_reaction", String(describing: p1), fallback: " reacted %@ to your snap")
  }
  /// All activity
  internal static let dAllActivity = L10n.tr("Localizable", "d_all_activity", fallback: "All activity")
  /// I hope this Journal by Lapse clone demonstrates my attention to detail, that I deliver quickly and that I will always go the extra mile.
  /// 
  /// I would look forward to the opportunity to work with you and thank you for considering me!
  /// 
  /// George
  internal static let dThankYouDescription = L10n.tr("Localizable", "d_thank_you_description", fallback: "I hope this Journal by Lapse clone demonstrates my attention to detail, that I deliver quickly and that I will always go the extra mile.\n\nI would look forward to the opportunity to work with you and thank you for considering me!\n\nGeorge")
  /// Thank you!
  internal static let dThankYouTitle = L10n.tr("Localizable", "d_thank_you_title", fallback: "Thank you!")
  /// This month
  internal static let dThisMonth = L10n.tr("Localizable", "d_this_month", fallback: "This month")
  /// This week
  internal static let dThisWeek = L10n.tr("Localizable", "d_this_week", fallback: "This week")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
