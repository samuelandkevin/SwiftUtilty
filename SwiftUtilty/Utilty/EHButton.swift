//
//  EHButton.swift
//  SwiftUtilty
//
//  Created by 黄坤鹏 on 2020/3/29.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import UIKit
import Kingfisher
//图片位置
public enum EHImagePosition:Int {
    /// 图片在左，文字在右，默认
    case left = 0
    /// 图片在右，文字在左
    case right = 1
    /// 图片在上，文字在下
    case top = 2
    /// 图片在下，文字在上
    case bottom = 3
}

class EHButton: UIView {
    
    /// 开启长按动画
    var enableLongAnimation = false
    
    fileprivate var tapBlock:(() -> (Void))?
    
    /// 图片宽度
    fileprivate var imgWidth:CGFloat  = 0;
    /// 图片高度
    fileprivate var imgHeight:CGFloat = 0;
    
    
    /// 容器
    fileprivate lazy var viewContainer: UIButton = {
        let viewContainer = UIButton()
        return viewContainer
    }()
    
    /// 图标
    fileprivate lazy var imgvLogo: UIImageView = {
        let imgvLogo = UIImageView()
        return imgvLogo
    }()
    
    /// 标题
    fileprivate lazy var lbTitle: UILabel = {
        let lbTitle = UILabel()
        lbTitle.setContentHuggingPriority(UILayoutPriority(rawValue: 248), for: .horizontal)
        lbTitle.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 748), for: .horizontal)
        
        lbTitle.setContentHuggingPriority(UILayoutPriority(rawValue: 248), for: .vertical)
        lbTitle.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 748), for: .vertical)
        return lbTitle
    }()
    
    // MARK: - 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUI()
        _layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func _setupUI(){
        addSubview(viewContainer)
        viewContainer.addSubview(imgvLogo)
        viewContainer.addSubview(lbTitle)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapFinish)))
        
        viewContainer.addTarget(self, action: #selector(tapBegin), for: .touchDown)
        viewContainer.addTarget(self, action: #selector(tapFinish), for: .touchUpInside)
        viewContainer.addTarget(self, action: #selector(tapFinish), for: .touchUpOutside)
        
    }
    
    fileprivate func _layoutUI(){
        
    }
    
    
    // MARK: - Action
    @objc fileprivate func tapBegin(){
        if enableLongAnimation {
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                
            }
        }
    }
    
    @objc fileprivate func tapFinish(){
        if enableLongAnimation {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { [weak self] _ in
                if let weakSelf = self,let b = weakSelf.tapBlock {
                    b();
                }
            }
            
        }else{
            if let b = self.tapBlock {
                b();
            }
        }
    }
    
    
    // MARK: - private
    /// 设置图片位置，图片和文字的间距。
    fileprivate func _setImage(position:EHImagePosition,spacing:CGFloat){
        
        switch position {
        case .left:
            
            imgvLogo.snp.makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.left.greaterThanOrEqualTo(self)
                make.width.equalTo(self.imgWidth)
                make.height.equalTo(self.imgHeight)
                
            }
            
            lbTitle.snp.makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.right.lessThanOrEqualTo(self)
                make.left.equalTo(self.imgvLogo.snp.right).offset(spacing)
            }
            viewContainer.snp.makeConstraints { (make) in
                make.center.equalTo(self)
                make.left.equalTo(self.imgvLogo)
                make.right.equalTo(self.lbTitle)
                make.height.equalTo(self)
            }
            
        case .right:
            imgvLogo.snp.makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.right.lessThanOrEqualTo(self)
                make.width.equalTo(self.imgWidth)
                make.height.equalTo(self.imgHeight)
                
            }
            
            lbTitle.snp.makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.left.greaterThanOrEqualTo(self)
                make.right.equalTo(self.imgvLogo.snp.left).offset(-spacing)
            }
            viewContainer.snp.makeConstraints { (make) in
                make.center.equalTo(self);
                make.right.equalTo(self.imgvLogo)
                make.left.equalTo(self.lbTitle)
                make.height.equalTo(self)
            }
            
        case .top:
            imgvLogo.snp.makeConstraints { (make) in
                make.centerX.equalTo(self);
                make.top.greaterThanOrEqualTo(self)
                make.width.equalTo(self.imgWidth)
                make.height.equalTo(self.imgHeight)
                
            }
            
            lbTitle.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.bottom.lessThanOrEqualTo(self)
                make.top.equalTo(self.imgvLogo.snp.bottom).offset(spacing)
            }
            viewContainer.snp.makeConstraints { (make) in
                make.center.equalTo(self)
                make.top.equalTo(self.imgvLogo)
                make.bottom.equalTo(self.lbTitle)
                make.width.equalTo(self)
            }
            
        case .bottom:
            imgvLogo.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.bottom.lessThanOrEqualTo(self)
                make.width.equalTo(self.imgWidth)
                make.height.equalTo(self.imgHeight)
                
            }
            
            lbTitle.snp.makeConstraints { (make) in
                make.centerX.equalTo(self)
                make.top.greaterThanOrEqualTo(self);
                make.bottom.equalTo(self.imgvLogo.snp.top).offset(-spacing)
            }
            viewContainer.snp.makeConstraints { (make) in
                make.center.equalTo(self)
                make.bottom.equalTo(self.imgvLogo)
                make.top.equalTo(self.lbTitle)
                make.width.equalTo(self)
            }
        }
    }
    
    
    
    // MARK: - 方法
    
    ///同时显示图片和文字，注意imageName：可以是本地图片名字，网络图片路径
    func showImageAndText(text:String?,textColor:UIColor,textFont:UIFont,imageName:String,placeholderImage:String?,imgWidth:CGFloat,imgHeight:CGFloat,renderingMode:UIImage.RenderingMode,imagePosition:EHImagePosition,spacing:CGFloat)  {
        self.lbTitle.text = text
        self.lbTitle.textColor = textColor
        self.lbTitle.font = textFont
        if imageName.hasPrefix("http") {
            imgvLogo.kf.setImage(with: URL(string: imageName), placeholder: UIImage(named: placeholderImage ?? ""), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            imgvLogo.image = UIImage(named: imageName)?.withRenderingMode(renderingMode)
            
        }
        
        self.imgWidth  = imgWidth
        self.imgHeight = imgHeight
        _setImage(position: imagePosition, spacing: spacing)
        
    }
    
    
    /// 只显示文字
    func showOnlyText(text:String?,textColor:UIColor,textFont:UIFont){
        self.lbTitle.text = text
        self.lbTitle.textColor = textColor
        self.lbTitle.font = textFont
        _setImage(position: .left, spacing: 0)
    }
    
    
    /// 只显示图片
    func showOnlyImage(imageName:String,placeholderImage:String,imgWidth:CGFloat,imgHeight:CGFloat,imagePosition:EHImagePosition,spacing:CGFloat){
        if imageName.hasPrefix("http") {
            imgvLogo.kf.setImage(with: URL(string: imageName), placeholder: UIImage(named: placeholderImage), options: nil, progressBlock: nil, completionHandler: nil)
        }else{
            imgvLogo.image = UIImage(named: imageName)
        }
        
        self.imgWidth  = imgWidth
        self.imgHeight = imgHeight
        _setImage(position: imagePosition, spacing: spacing)
    }
    
    
    
}
