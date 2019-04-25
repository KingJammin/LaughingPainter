//
//  Notification+Ext.swift
//  DesignableThemeManager
//
//  Created by Ben Pelo on 4/8/19.
//  Copyright © 2019 Benjamin Pelo. All rights reserved.
//

import Foundation


public extension Notification{
    static let updateTheme = Notification(name: Notification.Name("updateTheme"), object: nil, userInfo: nil)
}
