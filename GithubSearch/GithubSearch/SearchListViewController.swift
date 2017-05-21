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
class SearchListViewController: ASViewController<ASCollectionNode> {
    lazy var adapter: IGListAdapter = {
        IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let searchToken = NSNumber(integerLiteral: 0)
    let searchSection = SearchSectionController()
    var list = [IGListDiffable]()
    let disposeBag = DisposeBag()
    var lastRequest: Disposable?
    
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(node: ASCollectionNode(collectionViewLayout: flowLayout))
        searchSection.delegate = self
        adapter.setASDKCollectionNode(node)
        adapter.dataSource = self
        title = "GitHubSearch"
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SearchListViewController: IGListAdapterDataSource {
    func listAdapter(_: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
        if object is NSNumber {
            return searchSection
        }
        return UserSectionController()
    }
    
    func emptyView(for _: IGListAdapter) -> UIView? {
        return nil
    }
    
    func objects(for _: IGListAdapter) -> [IGListDiffable] {
        return [searchToken] + list
    }
}
extension SearchListViewController: SearchSectionControllerDelegate {
    
    func searchSectionController(_: SearchSectionController, didChangeText text: String) {
        UserTrackerModel.shar.search(username: text).subscribe { event in
            switch event {
            case .next(let element): self.list = element
                self.adapter.performUpdates(animated: true, completion: nil)
            default: return
            }
        }.addDisposableTo(disposeBag)
    }
}
    
