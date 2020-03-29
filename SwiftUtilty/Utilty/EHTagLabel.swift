//
//  EHTagLabel.swift
//  SwiftUtilty
//
//  Created by 黄坤鹏 on 2020/3/29.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import UIKit

class EHTagLabel: UILabel {
    
    var edgeInsets:UIEdgeInsets = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
        
        //根据edgeInsets，修改绘制文字的bounds
        rect.origin.x -= self.edgeInsets.left
        rect.origin.y -= self.edgeInsets.top
        rect.size.width += self.edgeInsets.left + self.edgeInsets.right
        rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom
        return rect
    }
    
    override func drawText(in rect: CGRect) {
        //令绘制区域为原始区域，增加的内边距区域不绘制
        super.drawText(in:UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(self.edgeInsets.top, self.edgeInsets.left, self.edgeInsets.bottom, self.edgeInsets.right)))
    }
}
