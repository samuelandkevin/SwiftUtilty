//
//  UILabel+Extentsion.swift
//  SwiftUtilty
//
//  Created by 黄坤鹏 on 2020/3/29.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 创建UILabel
    class func eh_creatLabel(text:String?,textAlignment:NSTextAlignment,textColor:UIColor,font:UIFont) -> UILabel {
        let v = UILabel()
        v.text = text
        v.textAlignment = textAlignment
        v.font = font
        v.textColor = textColor
        v.textAlignment = textAlignment
        return v
    }
}

