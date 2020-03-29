//
//  EHNoNetView.swift
//  SwiftUtilty
//
//  Created by 黄坤鹏 on 2020/3/29.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//



import UIKit
import SnapKit

let EHScale_W = UIScreen.main.bounds.size.width/375
let EHScale_H = UIScreen.main.bounds.size.height/812
func EHScale_Value(_ value:CGFloat) -> CGFloat {
    return EHScale_W*value
}

class EHNoNetView: UIView {
    
    /// 重新加载block
    fileprivate var reloadBlock:(() -> (Void))?
    
    
    /// 容器
    fileprivate lazy var viewContainer: UIView = {
        let viewContainer = UIView()
        return viewContainer
    }()
    
    
    /// 没有网络的图片
    fileprivate lazy var imgvNoNet: UIImageView = {
        let imgvNoNet = UIImageView()
        imgvNoNet.image = UIImage(named: "")
        return imgvNoNet
    }()
    
    
    /// 提示语
    fileprivate lazy var lbTips: UILabel = {
        let lbTips = UILabel.eh_creatLabel(text: "网络突然开小差", textAlignment: .center, textColor: UIColor.color(RGB: 0x444444), font: UIFont.systemFont(ofSize: EHScale_Value(18), weight: .medium))
        return lbTips
    }()
    
    
    /// 重新加载提示
    fileprivate lazy var lbReloadTips: UILabel = {
        let lbReloadTips = UILabel.eh_creatLabel(text: "请点击页面刷新", textAlignment: .center, textColor: UIColor.color(RGB: 0xBBBBBB), font: UIFont.systemFont(ofSize: EHScale_Value(13), weight: .regular))
        lbReloadTips.isUserInteractionEnabled = true
        return lbReloadTips
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUI()
        _layoutUI()
    
    }
    
    // MARK: - 初始化
    fileprivate func _setupUI(){
       
        backgroundColor = .clear
        addSubview(self.viewContainer)
        viewContainer.addSubview(self.imgvNoNet)
        viewContainer.addSubview(self.lbTips)
        viewContainer.addSubview(self.lbReloadTips)
        
        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(onReload)))
        
    }
    
    fileprivate func _layoutUI(){
        
        viewContainer.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(imgvNoNet)
            make.bottom.equalTo(lbReloadTips)
        }
        
        imgvNoNet.snp.makeConstraints { (make) in
            make.centerX.equalTo(viewContainer)
            make.top.equalTo(viewContainer)
            make.size.equalTo(CGSize(width: EHScale_Value(143), height: EHScale_Value(121)))
            
        }
        
        lbTips.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.imgvNoNet)
            make.left.right.equalTo(viewContainer)
            make.top.equalTo(self.imgvNoNet.snp.bottom).offset(EHScale_Value(20))
        }
      
        lbReloadTips.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.imgvNoNet)
            make.left.right.equalTo(viewContainer)
            make.top.equalTo(self.lbTips.snp.bottom).offset(EHScale_Value(13))
        }
           
    }
    
    
    // MARK: - Action
    @objc fileprivate func onReload(){
        if let b = reloadBlock {
            b()
        }
    }
    
    // MARK: - 公共的方法
    /// 重新加载回调
    func onReloadBlock(block:(() -> (Void))?) {
        reloadBlock = block
    }
    
    /// 移除
    func hide() {
        removeFromSuperview()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


