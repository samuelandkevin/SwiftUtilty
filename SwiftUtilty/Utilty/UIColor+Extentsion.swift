//
//  UIColor+Extentsion.swift
//  SwiftUtilty
//
//  Created by 黄坤鹏 on 2020/3/29.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import UIKit


func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}

extension UIColor {
    class func color(RGB rgbValue: Int) -> UIColor {
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0xFF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0xFF) / 255.0,
                       alpha: 1.0)
    }
    
    func equals(_ rhs: UIColor) -> Bool {
        var lhsR: CGFloat = 0
        var lhsG: CGFloat = 0
        var lhsB: CGFloat = 0
        var lhsA: CGFloat = 0
        self.getRed(&lhsR, green: &lhsG, blue: &lhsB, alpha: &lhsA)
        
        var rhsR: CGFloat = 0
        var rhsG: CGFloat = 0
        var rhsB: CGFloat = 0
        var rhsA: CGFloat = 0
        rhs.getRed(&rhsR, green: &rhsG, blue: &rhsB, alpha: &rhsA)
        
        return  lhsR == rhsR &&
            lhsG == rhsG &&
            lhsB == rhsB &&
            lhsA == rhsA
    }
    
    static let homepageOtherText = rgba(0x83, 0x46, 0x95, 1.0)
    static let homepageMainText = rgba(0x95, 0x59, 0xA4, 1.0)
    
    static let chartsGrid = rgba(0x99, 0x99, 0x99, 0.5)
    static let chartsLine = rgba(0x6B, 0xB9, 0xF0, 1.0)
    static let chartsPeriod = rgba(0xF6, 0xD9, 0xDA, 0.5)
    static let chartsFetile = rgba(0xEC, 0xE1, 0xEF, 0.5)
    static let chartsOvulationDay = rgba(0xA6, 0x7B, 0xCC, 0.8)
    static let chartsOvulation = rgba(0x81, 0x45, 0x90, 1.0)
    static let chartsTcRatio = rgba(0x9D, 0x9A, 0xC3, 1.0)
    static let chartsTcRatioSemi = rgba(0x77, 0x33, 0x91, 1.0)
    static let chartsCoverline = rgba(0xF8, 0x94, 0x06, 1.0)
    static let chartsSex = rgba(0xEC, 0x67, 0x67, 1.0)
    static let chartsMood = rgba(0xFD, 0xAD, 0x50, 1.0)
    static let chartsCM = rgba(0xFF, 0x9A, 0x9A, 1.0)
    static let chartsSymptoms = rgba(0x5D, 0xAD, 0xBD, 1.0)
    static let chartsMedication = rgba(0x61, 0xC3, 0x98, 1.0)
    static let chartsTitleBg = rgba(0xE7, 0xDA, 0xEB, 1.0)
    static let chartsPopViewLine = rgba(202, 172, 209, 1.0)
    static let chartsPopViewLabel = rgba(24, 126, 153, 1.0)
    
    static let main = rgba(175, 118, 208, 1.0)
//    static let main = rgba(166, 106, 236, 1.0)
    static let guaranteeMain = rgba(149, 89, 164, 1)
    static let guaranteeQAContentTextColor = rgba(126, 126, 126, 1)
    static let guaranteeNavbarBgColor = rgba(86, 19, 147, 1)
    static let guaranteelightMain = rgba(252, 236, 255, 1)
    static let guaranteeSeparateLineMain = rgba(212, 180, 255, 1)
    static let mainGradient = rgba(201, 96, 195, 1.0)
    static let loginOption = rgba(14, 127, 151, 1.0)
    static let loginOptionGradient = rgba(62, 171, 195, 1.0)
    static let textDefault = rgba(131, 68, 147, 1.0)
    static let whiteOpaque = rgba(255, 255, 255, 0.3)
    static let shopMain = rgba(254, 186, 41, 1.0)
    static let shopGradient = rgba(254, 153, 32, 1.0)
    static let profileBtnText = rgba(0x99, 0x99, 0x99, 1.0)
    static let leftViewSeperateLine = profileBtnText
    static let seperateLine = color(RGB: 0xCCCCCC)
    static let bgViewTop = rgba(201, 162, 224, 1.0)
    static let bgViewBottom = rgba(168, 86, 195, 1.0)
    static let bbtTableTop = rgba(0xE7, 0xDA, 0xEB, 1.0)
    static let tempText = loginOptionGradient
    
    static let profileTitle = rgba(0x33, 0x33, 0x33, 1.0)
    static let profileSubtitle = rgba(0x99, 0x99, 0x99, 1.0)
    static let connected = rgba(0x71, 0xd1, 0x4b, 1.0)
    static let messageBackground = rgba(0xF8, 0xF8, 0xF8, 1.0)
    
    static let lhPeak = UIColor.color(RGB: 0xBB85E5)
    static let paperPositive = rgba(255, 211, 48, 1.0)
    static let paperNegative = rgba(0, 202, 97, 1.0)
    
    static let calendarMain = homepageMainText
    static let period = rgba(0xEB, 0x9B, 0x9A, 1.0)
    static let forecastPeriod = rgba(0xF1, 0xDF, 0xDF, 1.0)
    static let fertileWindow = rgba(0xD0, 0xB5, 0xD7, 1.0)
    static let forecastFertile = rgba(0xD0, 0xB5, 0xD7, 0.6)
    static let lhSurge = rgba(0xF8, 0x94, 0x06, 1.0)
    static let ovulationDay = calendarMain
    static let forecastOvuDay = rgba(0x95, 0x59, 0xA4, 0.6)
    static let bbtSpike = rgba(0x6B, 0xB9, 0xF0, 1.0)
    static let pdgPositive = rgba(0x66, 0xCC, 0x99, 1.0)
    static let pregnancyCalendar = rgba(0xB7, 0x8C, 0xC1, 1.0)
    static let pregnancyCalendarFuture = rgba(0xB7, 0x8C, 0xC1, 0.5)
    
    static let calendarDefaultTitle = rgba(0x88, 0x88, 0x88, 1.0)
    static let calendarFutureTitle = rgba(0xBB, 0xBB, 0xBB, 1.0)
    
//    public class func calendarTitle(_ date: Date, _ isPregnant: Bool = false) -> UIColor {
//        if (date as NSDate).isFutureDate() {
//            return isPregnant ? .pregnancyCalendarFuture : .calendarFutureTitle
//        }
//        return isPregnant ? .pregnancyCalendar : .calendarDefaultTitle
//    }
    
    static let ovulationTestMain = calendarMain
    
    
    // 新增色值
    static let pickerTopBgColor = rgba(0xF0, 0xF0, 0xF0, 1.0)
    static let profileTextColor = rgba(0x75, 0x75, 0x75, 1.0)
    static let cellSelectColor = rgba(0xf6, 0xf6, 0xf6, 1.0)
}

// 根据颜色生成图片
extension UIColor {
    var imageRepresentation : UIImage {
      let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
      UIGraphicsBeginImageContext(rect.size)
      let context = UIGraphicsGetCurrentContext()

      context?.setFillColor(self.cgColor)
      context?.fill(rect)

      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()

    return image!
  }
}
