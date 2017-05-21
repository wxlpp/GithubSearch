//
//  SearchListViewController.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/20.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import AsyncDisplayKit
import IGListKit
import Moya
import RxSwift
import RxCocoa
import ESPullToRefresh
class SearchListViewController: ASViewController<ASCollectionNode> {
    lazy var adapter: IGListAdapter = {
        IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let searchBar = UISearchBar()
    var list = [UserCellModel]()
    var lastSearStr = ""
    var totalCount = 0
    let disposeBag = DisposeBag()
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(node: ASCollectionNode(collectionViewLayout: flowLayout))
        
        node.view.es_addInfiniteScrolling {
            if self.list.count >= self.totalCount {
                self.node.view.es_noticeNoMoreData()
            }
            UserTrackerModel.shar.search(username: self.searchBar.text!, self.list.count/30 + 1).subscribe({ (event) in
                switch event {
                case .next(let element):
                    self.totalCount = element.totalCount
                    self.list = self.list + element.cellModels
                    self.adapter.performUpdates(animated: true, completion: nil)
                default: break
                }
                self.node.view.es_stopLoadingMore()
            }).addDisposableTo(self.disposeBag)
        }
        adapter.setASDKCollectionNode(node)
        adapter.dataSource = self
        prepareSearchBar()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func prepareSearchBar() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "搜索"
        navigationItem.titleView = searchBar
        searchBar.rx.text.throttle(0.3, scheduler: MainScheduler.instance).distinctUntilChanged(==).flatMapLatest { (query) -> Observable<UserListModel> in
            if self.lastSearStr != "" && self.list.count >= self.totalCount && query!.lowercased().contains(self.lastSearStr){
                var listModel = UserListModel()
                listModel.cellModels = self.list.filter({ $0.name.lowercased().contains(query!)})
                listModel.totalCount = listModel.cellModels.count
                return Observable<UserListModel>.create({ (observer) -> Disposable in
                    observer.on(.next(listModel))
                    observer.on(.completed)
                    self.lastSearStr = query ?? ""
                    return Disposables.create()
                })
            }
            self.lastSearStr = query ?? ""
            return UserTrackerModel.shar.search(username: query!)
        }.subscribe { event in
            switch event {
            case .next(let element):
                self.list = element.cellModels
                self.totalCount = element.totalCount
                self.adapter.performUpdates(animated: true, completion: nil)
            default: return
            }
        }.addDisposableTo(disposeBag)
    }
}

extension SearchListViewController: IGListAdapterDataSource {
    func listAdapter(_: IGListAdapter, sectionControllerFor _: Any) -> IGListSectionController {
        return UserSectionController()
    }
    
    func emptyView(for _: IGListAdapter) -> UIView? {
        return nil
    }
    
    func objects(for _: IGListAdapter) -> [IGListDiffable] {
        return list
    }
}
