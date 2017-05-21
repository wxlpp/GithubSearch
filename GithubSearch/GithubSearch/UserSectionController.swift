//
//  UserSectionController.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/21.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import AsyncDisplayKit
import IGListKit

final class UserSectionController: IGListSectionController, IGListSectionType, ASSectionController {
    var object: UserCellModel?
    
    func nodeBlockForItem(at index: Int) -> ASCellNodeBlock {
        return {
            let node = UserNode()
            node.nameNode.attributedText = NSAttributedString(string: self.object?.name ?? "")
            node.avatarNode.url = URL(string: (self.object?.avatarPath)!)
            return node
        }
    }
    
    func numberOfItems() -> Int {
        return 1
    }
    
    func didUpdate(to object: Any) {
        self.object = object as? UserCellModel
    }
    
    func didSelectItem(at index: Int) {}
    
    //ASDK Replacement
    func sizeForItem(at index: Int) -> CGSize {
        return ASIGListSectionControllerMethods.sizeForItem(at: index)
    }
    
    func cellForItem(at index: Int) -> UICollectionViewCell {
        return ASIGListSectionControllerMethods.cellForItem(at: index, sectionController: self)
    }
}
