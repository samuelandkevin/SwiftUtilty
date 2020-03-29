//
//  EHNoDataView.swift
//  SwiftUtilty
//
//  Created by 黄坤鹏 on 2020/3/29.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import UIKit

class EHNoDataView: UIView {
    

        
    /// 初始化方式，0：默认是logo+文字 ，1：logo+文字+按钮
    var style:Int = 0 {
        didSet {
            lbOper.isHidden = style == 1 ? false:true
            
            switch style {
                case 1:
                   viewContainer.snp.remakeConstraints { (make) in
                        make.width.equalTo(self)
                        make.centerX.equalTo(self)
                        make.top.equalTo(imgvNoData)
                        make.bottom.equalTo(self.lbOper)
                    }
               
            default :
                
                viewContainer.snp.remakeConstraints { (make) in
                    make.width.equalTo(self)
                    make.centerX.equalTo(self)
                    make.top.equalTo(imgvNoData)
                    make.bottom.equalTo(self.lbTips)
                }

                break
                
            }
        }
    }

    /// 图片宽
    var imgW = EHScale_Value(143)
    /// 图片高度
    var imgH = EHScale_Value(121)
    
    fileprivate var operBlock:((_ text:String?) -> (Void))?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUI()
        _layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 容器
    fileprivate lazy var viewContainer: UIView = {
        let viewContainer = UIView()
        return viewContainer
    }()
    
    
    /// 没有数据的图片
    lazy var imgvNoData: UIImageView = {
        let imgvNoNet = UIImageView()
        imgvNoNet.image = UIImage(named: "")
        return imgvNoNet
    }()
    
    
    /// 提示语
    lazy var lbTips: UILabel = {
        let lbTips = UILabel.eh_creatLabel(text: "暂无数据", textAlignment: .center, textColor: UIColor.color(RGB: 0xBBBBBB), font: UIFont.systemFont(ofSize: EHScale_Value(15), weight: .regular))
        return lbTips
    }()
    
    
    /// 操作按钮
    lazy var lbOper: EHTagLabel = {
        let lbOper = EHTagLabel()
        lbOper.backgroundColor = UIColor.color(RGB: 0x1C82FF)
        lbOper.font = .systemFont(ofSize: 12, weight: .semibold)
        lbOper.textColor = .white
        lbOper.layer.cornerRadius = 20
        lbOper.layer.masksToBounds = true
        lbOper.isUserInteractionEnabled = true
        lbOper.edgeInsets = UIEdgeInsets(top: 14, left: 36, bottom: 14, right: 36)
        return lbOper
    }()
    
    fileprivate func _setupUI(){
        addSubview(viewContainer)
        viewContainer.addSubview(imgvNoData)
        viewContainer.addSubview(lbTips)
        viewContainer.addSubview(lbOper)
        lbOper.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onOper)))
         
    }
    
    fileprivate func _layoutUI(){
        viewContainer.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.top.equalTo(imgvNoData)
            make.bottom.equalTo(lbOper)
        }
        
        imgvNoData.snp.makeConstraints { (make) in
            make.centerX.equalTo(viewContainer)
            make.top.equalTo(viewContainer)
            make.size.equalTo(CGSize(width: imgW, height: imgH))
            
        }
        
        lbTips.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.imgvNoData)
            make.left.right.equalTo(viewContainer)
            make.top.equalTo(self.imgvNoData.snp.bottom).offset(EHScale_Value(20))
        }
        
        lbOper.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.imgvNoData)
            make.top.equalTo(self.lbTips.snp.bottom).offset(EHScale_Value(20));
            make.height.equalTo(40)
        }
        
        
    }
    
    
    // MARK: - Action
    @objc func onOper() {
        debugPrint("点击操作按钮");
        if let b = self.operBlock{
            b(self.lbOper.text);
        }
    }
    
    
    // MARK: - 方法
    /// 移除
    func hide() {
        removeFromSuperview()
    }
    
    /// 点击底部按钮回调
    func onOperBlock(complete:@escaping (_ text:String?)->Void) {
        operBlock = complete
    }
    
    /// 获取高度
    func getHeight() -> CGFloat {
        if style == 1 {
            return 250
        }else{
            return 200
        }
    }
    
    
}
