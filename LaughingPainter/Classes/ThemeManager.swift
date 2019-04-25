//
//  ThemeManager.swift
//  DesignableThemeManager
//
//  Created by Ben Pelo on 4/5/19.
//  Copyright © 2019 Benjamin Pelo. All rights reserved.
//
import Foundation
import UIKit

open class Theme: NSObject {
public let name: String
public let colors: [String: UIColor]
public let fonts: [String: UIFont]
public let statusBarStyle: UIStatusBarStyle
public let shadows: [String:Shadow]
public init (name: String = "default", colors: [String:UIColor] = [:], fonts: [String:UIFont] = [:], statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.default, shadows: [String:Shadow] = [StandardThemeKeys.primaryShadow:Shadow()]){
        self.name = name
        self.colors = colors
        self.fonts = fonts
        self.statusBarStyle = statusBarStyle
        self.shadows = shadows
    }
}

open class Shadow: NSObject {
    public let color: CGColor = UIColor.black.cgColor
    public let offset: CGSize = CGSize(width: 0, height: 1.0)
    public let opacity: Float = 80.0
    public let radius: CGFloat = 1.0
}

public struct StandardThemeKeys {
    public static let primaryBackgroundColor = "PrimaryBackgroundColor"
    public static let primaryTextColor = "PrimaryTextColor"
    public static let primaryNavigationColor = "PrimaryNavigationColor"
    public static let headerFont = "HeaderFont"
    public static let bodyFont = "BodyFont"
    public static let footerFont = "FooterFont"
    public static let primaryShadow = "PrimaryShadow"
}

public protocol ThemeManagerProtocol {
    static func getThemes() -> [String: Theme]
}

open class ThemeManager {
    public var activeTheme: Theme
    public var themes: [String:Theme]
    
    public init(themes: [String:Theme]) {
        self.themes = themes
        if let activeThemeId = UserDefaults.standard.value(forKey: "activeTheme") as? String {
            self.activeTheme = self.themes[activeThemeId] ?? Theme()
            updateTheme(themeId: activeThemeId)
        } else {
            self.activeTheme = self.themes.values.first ?? Theme()
            if let firstThemeId = self.themes.values.first?.name {
             updateTheme(themeId: firstThemeId)
            }
        }
    }
    
    public func updateTheme(themeId: String) {
        guard let newTheme = self.themes[themeId] else { return }
        self.activeTheme = newTheme
        UserDefaults.standard.set(themeId, forKey: "activeTheme")
        NotificationCenter.default.post(Notification.updateTheme)
    }
}
