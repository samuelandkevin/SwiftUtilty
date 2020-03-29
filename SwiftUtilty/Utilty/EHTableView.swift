//
//  EHTableView.swift
//  SwiftUtilty
//
//  Created by 黄坤鹏 on 2020/3/28.
//  Copyright © 2020 黄坤鹏. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire

/// 刷新类型
public enum EHRefreshType:Int {
    /// 下拉刷新
    case loadNew = 1
    /// 上拉加载
    case loadMore
}

class EHTableView: UITableView {
    /// 允许下拉刷新
    var enableLoadNew = false
    /// 允许上拉加载
    var enableLoadMore = false
    /// 上拉加载无更多数据
    var noMoreData = false
    
    /// albeView的边距
    var edgeInsets = UIEdgeInsets.zero
    
    ///  禁止显示网络状态变化视图，eg：无网提示
    var disableShowNetStatusView = false
    
    /// 正在加载
    var isLoading = false
    
    /// 可以同时识别多种手势
    var shouldRecognizeSimultaneously = false
    
    /// 键盘高度
    fileprivate var keyBoardHeight:CGFloat = 0
    /// 键盘显示中
    fileprivate var isShowingKeyboard = false
    fileprivate var refreshBlock:(() -> (Void))?
    fileprivate var loadNewBlock:(() -> (Void))?
    fileprivate var loadMoreBlock:(() -> (Void))?
    fileprivate var operBlock:((_ text:String?) -> (Void))?
    
    fileprivate lazy var viewNoNet: EHNoNetView? = {
        let viewNoNet = EHNoNetView()
        return viewNoNet
    }()
    
    
    fileprivate lazy var viewNoData : EHNoDataView? = {
        let viewNoData = EHNoDataView()
        return viewNoData
    }()
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        NotificationCenter.default.addObserver(self, selector: #selector(networkChange(aNoti:)), name:
            Notification.Name(rawValue: "networkChange"), object: self)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(aNoti:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(aNoti:)),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //kun调试
    // MARK: - 通知
    @objc func networkChange(aNoti: Notification){
        if disableShowNetStatusView {return}
        
    }
    
    @objc func keyboardWillShow(aNoti: Notification){
        guard let frame = aNoti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else {return}
        isShowingKeyboard = true
        keyBoardHeight    = frame.height
    }
    
    @objc func keyboardWillHide(aNoti: Notification){
        isShowingKeyboard = false
        keyBoardHeight    = 0
    }
    
    // MARK: - private
    fileprivate func createHeaderView() {
        if  self.mj_header == nil {
            let header = MJRefreshNormalHeader.init {
                
            }
            header.ignoredScrollViewContentInsetTop = self.edgeInsets.top
            self.mj_header = header
        }
    }
    
    fileprivate func removeHeaderView(){
        self.mj_header = nil
    }
    
    fileprivate func creatFooterView() {
        if  self.mj_footer == nil {
            let footer = MJRefreshAutoNormalFooter.init {
                
            }
            footer.ignoredScrollViewContentInsetBottom = self.edgeInsets.bottom
            
            self.mj_footer = footer
        }
    }
    
    fileprivate func removeFooterView() {
        self.mj_footer = nil
    }
    
    fileprivate func _hideNoDataView() {
        viewNoData?.removeFromSuperview()
        viewNoData = nil
    }
    
    fileprivate func _hideNoNetWorkView() {
        viewNoNet?.removeFromSuperview()
        viewNoNet = nil
    }
    
    fileprivate func _showNoNetView() {
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 0.3 ) {[weak self] in
            guard let weakSelf = self else {return}
            weakSelf._hideNoDataView()
            let centerPoint = weakSelf.convert(weakSelf.center, to: UIApplication.shared.windows[0])
            let deltaY =  centerPoint.y - UIApplication.shared.windows[0].center.y;
            var centerY:CGFloat = 0
            if deltaY > 0 {//tableView中心点Y比屏幕中心点Y大
                centerY = weakSelf.center.y - deltaY
            }else{
                centerY = weakSelf.center.y + deltaY
            }
            
            if weakSelf.viewNoNet == nil{
                weakSelf.viewNoNet = EHNoNetView()
                weakSelf.viewNoNet?.mj_size = CGSize(width:UIScreen.main.bounds.size.width, height:250)
                weakSelf.viewNoNet?.center  = CGPoint(x:weakSelf.center.x, y:centerY);
                weakSelf.addSubview(weakSelf.viewNoNet ?? UIView())
                
            }
            weakSelf.viewNoNet?.mj_size = CGSize(width:UIScreen.main.bounds.size.width, height:250)
            weakSelf.viewNoNet?.center  = CGPoint(x:weakSelf.center.x, y:centerY)
            
        }
    }
    
    
    override func reloadData() {
        super.reloadData()
        if let dataSource = self.dataSource , dataSource.responds(to: #selector(numberOfRows(inSection:))){
            if dataSource.responds(to: #selector(getter: numberOfSections)){
                if (((dataSource.numberOfSections?(in: self))!) > 0), dataSource.tableView(self, numberOfRowsInSection: 0) > 0 {
                    //移除无数据视图
                    _hideNoDataView()
                    _hideNoNetWorkView()
                    
                }
            }else{
                //判断是否无网络
                if NetworkReachabilityManager(host: "www.baidu.com")?.isReachable == false {
                    _showNoNetView()
                }
                
            }
            
        }else{
            
            if let dataSource = self.dataSource ,((dataSource.numberOfSections?(in: self))!) > 0{
                //移除无数据视图
                _hideNoDataView()
                _hideNoNetWorkView()
                
            }else{
                //判断是否无网络
                if NetworkReachabilityManager(host: "www.baidu.com")?.isReachable == false {
                    _showNoNetView()
                }
            }
            
            
            
        }
    }
    
    
}


extension EHTableView {
    // MARK: - Public
    
    /// 开始下拉刷新动画，并进行网络请求
    func beginRefreshing() {
        self.mj_header?.beginRefreshing()
    }
    
    /// 开始加载
    func loadBegin(type:EHRefreshType) {
        isLoading = true
        switch (type)
        {
        case .loadNew:
            createHeaderView()
        case .loadMore:
            creatFooterView()
            
        }
    }
    
    /// 结束加载
    func loadFinish() {
        isLoading = false
        if self.mj_header?.isRefreshing ?? false {
            self.mj_header?.endRefreshing()
        }else {
            self.mj_footer?.endRefreshing()
        }
    }
    
    
    /// 点击无数据底部按钮回调
    func onOperBlock(complete:@escaping (_ text:String?)->Void) {
        operBlock = complete
    }
    
    
    /// 点击页面刷新（用于网络失败，点击页面刷新）
    func refreshPageBlock(complete:@escaping () -> (Void))  {
        refreshBlock = complete
    }
    
    
    /// 下拉刷新block
    func loadNew(complete:@escaping () -> (Void)) {
        loadNewBlock = complete
    }
    
    
    /// 上拉加载block
    func loadMore(complete:@escaping () -> (Void)){
        loadMoreBlock = complete
    }
    
    
    /// 设置无数据，默认显示在屏幕中间
    func setNoData(noData:Bool,tips:String?) {
        setNoData(noData: noData, tips: tips, btnText: nil, type: 0, centerYoffset: 0)
    }
    
    
    /// 设置无数据，centerYoffset：距离window中心点的偏移量，（用于键盘挡住无数据视图)
    func setNoData(noData:Bool,tips:String?,centerYoffset:CGFloat){
        setNoData(noData: noData, tips: tips, btnText: nil, type: 0, centerYoffset: centerYoffset)
    }
    
    /// 设置无数据  type:(0：默认是logo+文字 ，1：logo+文字+按钮文本) ，默认显示在屏幕中间
    func setNoData(noData:Bool,tips:String?,btnText:String?,type:Int){
        setNoData(noData: noData, tips: tips, btnText: btnText, type: type, centerYoffset: 0)
    }
    
    
    /// 设置无数据  type:(0：默认是logo+文字 ，1：logo+文字+按钮文本)，centerYoffset：距离window中心点的偏移量，（用于键盘挡住无数据视图）
    func setNoData(noData:Bool,tips:String?,btnText:String?,type:Int,centerYoffset:CGFloat){
        if noData {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {[weak self] in
                guard let weakSelf = self else {return}
                //隐藏无网络
                weakSelf._hideNoNetWorkView()
                
                //无数据图默认位于屏幕正中心
                let centerPoint = weakSelf.convert(weakSelf.center, to: UIApplication.shared.windows[0])
                let deltaY =  centerPoint.y - UIApplication.shared.windows[0].center.y;
                var centerY:CGFloat = 0
                if deltaY > 0 {//tableView中心点Y比屏幕中心点Y大
                    centerY = weakSelf.center.y - deltaY
                }else{
                    centerY = weakSelf.center.y + deltaY
                }
                
                if weakSelf.viewNoData == nil{
                    weakSelf.viewNoData = EHNoDataView()
                    weakSelf.viewNoData?.mj_size = CGSize(width:UIScreen.main.bounds.size.width, height:250)
                    weakSelf.viewNoData?.center  = CGPoint(x:weakSelf.center.x, y:centerY);
                    weakSelf.addSubview(weakSelf.viewNoData ?? UIView())
                    weakSelf.viewNoData?.onOperBlock(complete: { [weak self](text) in
                        if let weakSelf = self , let b = weakSelf.operBlock{
                            b(text)
                        }
                    })
                    
                }
                weakSelf.viewNoData?.lbOper.text = btnText
                weakSelf.viewNoData?.mj_size = CGSize(width:UIScreen.main.bounds.size.width, height: weakSelf.viewNoData?.getHeight() ?? 0)
                weakSelf.viewNoData?.lbTips.text = tips
                if centerYoffset > 0 {
                    //自定义了偏移量
                    weakSelf.viewNoData?.center  = CGPoint(x:weakSelf.center.x, y:centerY+centerYoffset);
                }else{
                    //非自定义偏移量，键盘弹出的时候，无数据视图放在键盘上面
                    if weakSelf.isShowingKeyboard {
                        let point_Nodata = weakSelf.convert(weakSelf.viewNoData?.frame.origin ?? .zero, to: UIApplication.shared.windows[0])
                        let delta = UIScreen.main.bounds.size.height - (point_Nodata.y+(weakSelf.viewNoData?.frame.size.height ?? 0))
                        
                        if delta < weakSelf.keyBoardHeight {
                            let distance = fabs(delta-weakSelf.keyBoardHeight)
                            debugPrint("被挡住了,挡住的高度是:\(distance)")
                            //无数据图偏离屏幕中心一定距离
                            weakSelf.viewNoData?.center  = CGPoint(x:weakSelf.center.x, y:centerY-distance)
                        }
                        
                    }else{
                        weakSelf.viewNoData?.center  = CGPoint(x:weakSelf.center.x, y:centerY+centerYoffset);
                    }
                }
                
                
            }
        }
    }
}


