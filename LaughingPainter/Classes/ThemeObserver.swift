//
//  ThemeObserver.swift
//  DesignableThemeManager
//
//  Created by Ben Pelo on 4/8/19.
//  Copyright © 2019 Benjamin Pelo. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol ThemeObserverProtocol: class {
    @objc func updateTheme()
}

public extension ThemeObserverProtocol {
    func registerThemeUpdate() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.updateTheme.name, object: nil)
    }
    func removeThemeObservation() {
        NotificationCenter.default.removeObserver(self, name: Notification.updateTheme.name, object: nil)
    }
}

open class ThemeViewController: UIViewController, ThemeObserverProtocol {
    override open func viewDidLoad() {
        super.viewDidLoad()
        registerThemeUpdate()
        updateTheme()
    }
    
    deinit {
        removeThemeObservation()
    }
    
    @objc public func updateTheme() {
        themeDidUpdate()
    }
    
    open func themeDidUpdate() {}
}
