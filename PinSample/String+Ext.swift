//
//  String+Ext.swift
//  PinSample
//
//  Created by Golden Chimusinde on 2023/01/09.
//  Copyright © 2023 Udacity. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func isValidUrl() -> Bool {
        guard !self.isEmpty else { return false }
        guard let url = URL(string: self) else { return false }
        
        return UIViewController.canOpenUrl(url: url)
    }
}

