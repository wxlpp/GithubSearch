//
//  UserSectionController.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/21.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import AsyncDisplayKit
import IGListKit
import RxSwift

final class UserSectionController: IGListSectionController, IGListSectionType, ASSectionController {
    var object: UserCellModel?
    static var count = 0
    let disposeBag = DisposeBag()
    func nodeBlockForItem(at _: Int) -> ASCellNodeBlock {
        
        return {
            let node = UserNode()
            guard let user = self.object else { return node }
            node.nameNode.attributedText = NSAttributedString(string: user.name)
            node.avatarNode.url = URL(string: user.avatarPath)
            UserTrackerModel.shar.getLanguage(for: user.name).subscribe(onNext: { language in
                node.languageNode.attributedText = NSAttributedString(string: language)
            }).addDisposableTo(self.disposeBag)
            return node
        }
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? UserCellModel
    }
    
    func didSelectItem(at _: Int) {}
    
    // ASDK Replacement
    func sizeForItem(at index: Int) -> CGSize {
        return ASIGListSectionControllerMethods.sizeForItem(at: index)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }
}
