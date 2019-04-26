//
//  ViewController.swift
//  ThemeManager
//
//  Created by Ben Pelo on 4/8/19.
//  Copyright © 2019 Benjamin Pelo. All rights reserved.
//
import Foundation
import UIKit
import LaughingPainter

class ExampleViewController: ThemeViewController {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var toggle: UISwitch!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        changeTheme(self)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return ThemeManager.instance.activeTheme.statusBarStyle
    }
    
    override func themeDidUpdate() {
        DispatchQueue.main.async {
            self.mainLabel.textColor = ThemeManager.instance.activeTheme.colors[StandardThemeKeys.primaryTextColor]
            self.mainLabel.font = ThemeManager.instance.activeTheme.fonts[StandardThemeKeys.headerFont]
            self.view.backgroundColor = ThemeManager.instance.activeTheme.colors[StandardThemeKeys.primaryBackgroundColor]
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        switch toggle.isOn {
            case true: ThemeManager.instance.updateTheme(themeId: ThemeManager.darkModeTheme.name)
            self.mainLabel.text = "Dark"
            case false: ThemeManager.instance.updateTheme(themeId: ThemeManager.defaultTheme.name)
            self.mainLabel.text = "Light"
        }
    }
    
}

extension ThemeManager: ThemeManagerProtocol {
    static let instance = ThemeManager(themes: getThemes())
    static let defaultTheme = Theme(name: "defaultTheme", colors: [StandardThemeKeys.primaryTextColor:#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), StandardThemeKeys.primaryBackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)], fonts: [StandardThemeKeys.headerFont: UIFont.systemFont(ofSize: 34, weight: .bold)], statusBarStyle: .default)
    static let darkModeTheme = Theme(name: "darkMode", colors: [StandardThemeKeys.primaryTextColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), StandardThemeKeys.primaryBackgroundColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)], fonts: [StandardThemeKeys.headerFont: UIFont.systemFont(ofSize: 34, weight: .light)], statusBarStyle: .lightContent)
    public static func getThemes() -> [String: Theme] {
        let themes = [defaultTheme.name: defaultTheme, darkModeTheme.name: darkModeTheme]
        return themes
    }
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
