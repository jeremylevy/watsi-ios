//
//  Color.swift
//  Watsi
//
//  Created by Jeremy Levy on 01/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit

struct Color {
    static func hexStr(_ hexStr : NSString, alpha : CGFloat) -> UIColor {
        let hexStr = hexStr.replacingOccurrences(of: "#", with: "") as NSString
        let scanner = Scanner(string: hexStr as String)
        
        var color: UInt32 = 0
        
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            
            return UIColor(red:r, green:g, blue:b, alpha:alpha)
        } else {
            print("Invalid hex string.", terminator: "")
            
            return UIColor.white
        }
    }
    
    // MARK: - Globals
    
    static func blue() -> UIColor {
        return self.hexStr("#00b2D8", alpha: 1)
    }
    
    // Mark: - Window
    
    static func windowTintColor() -> UIColor {
        return UIColor.white
    }
    
    static func windowBgColor() -> UIColor {
        return self.hexStr("#f8f9fb", alpha: 1)
    }
    
    // MARK: - Navigation bar
    
    static func navigationBarTitleTextColor() -> UIColor {
        return UIColor.white
    }
    
    static func navigationBarBackgroundColor() -> UIColor {
        return self.blue()
    }
    
    // MARK: - Page menu
    
    static func pageMenuScrollMenuBackgroundColor() -> UIColor {
        return UIColor.white
    }
    
    static func pageMenuViewBackgroundColor() -> UIColor {
        return self.hexStr("#f8f9fb", alpha: 1)
    }
    
    static func pageMenuSelectionIndicatorColor() -> UIColor {
        return self.blue()
    }
    
    static func pageMenuBottomMenuHairlineColor() -> UIColor {
        return self.hexStr("#e2e6ea", alpha: 1)
    }
    
    static func pageMenuSelectedMenuItemLabelColor() -> UIColor {
        return self.hexStr("#37474f", alpha: 1)
    }
    
    static func pageMenuUnselectedMenuItemLabelColor() -> UIColor {
        return self.hexStr("#607d8b", alpha: 1)
    }
    
    // MARK: - Patient Collection View Cell
    
    static func patientCollectionViewCellDescriptionLabelColor() -> UIColor {
        return self.hexStr("#254254", alpha: 1)
    }
    
    static func patientCollectionViewCellAmountRemainingLabelColor() -> UIColor {
        return self.hexStr("#244255", alpha: 1)
    }
    
    static func patientCollectionViewCellAmountRemainingLegendLabelColor() -> UIColor {
        return self.hexStr("#89949b", alpha: 1)
    }
    
    static func patientCollectionViewCellAmountRaisedLabelColor() -> UIColor {
        return self.hexStr("#244255", alpha: 1)
    }
    
    static func patientCollectionViewCellAmountRaisedLegendLabelColor() -> UIColor {
        return self.hexStr("#89949b", alpha: 1)
    }
    
    static func patientCollectionViewCellPercentFundedLabelColor() -> UIColor {
        return self.hexStr("#244255", alpha: 1)
    }
    
    static func patientCollectionViewCellPercentFundedLegendLabelColor() -> UIColor {
        return self.hexStr("#89949b", alpha: 1)
    }
    
    static func patientCollectionViewCellPercentFundedProgressTintColor() -> UIColor {
        return self.hexStr("#ffc627", alpha: 1)
    }
    
    static func patientCollectionViewCellPercentFundedProgressTrackTintColor() -> UIColor {
        return self.hexStr("#e2e6ea", alpha: 1)
    }
    
    // MARK: - Donor VC
    
    static func donorNameLabelColor() -> UIColor {
        return self.hexStr("#244255", alpha: 1)
    }
    
    static func donorUsernameLabelColor() -> UIColor {
        return self.hexStr("#89949b", alpha: 1)
    }
    
    static func donorHistoryLabelColor() -> UIColor {
        return self.hexStr("#254254", alpha: 1)
    }
    
    // MARK: Patient profil VC
    
    static func patientProfilReadMoreButtonColor() -> UIColor {
        return self.hexStr("#d2d5dc", alpha: 1.0)
    }
    
    // MARK: - Donate VC
    
    static func donateVCDollarLabelDisabledColor() -> UIColor {
        return self.hexStr("#1c1c1c", alpha: 1.0)
    }
    
    static func donateVCDollarLabelEnabledColor() -> UIColor {
        return self.hexStr("#14c04d", alpha: 1.0)
    }
}
