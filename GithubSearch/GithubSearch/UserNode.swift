//
//  UserCellNode.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/20.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import AsyncDisplayKit
class UserNode: ASCellNode {
    let nameNode = ASTextNode()
    let avatarNode = ASNetworkImageNode()
    let languageNode = ASTextNode()
    override func didLoad() {
        avatarNode.delegate = self
        avatarNode.placeholderFadeDuration = 0.5
        avatarNode.placeholderColor = ASDisplayNodeDefaultPlaceholderColor()
        addSubnode(nameNode)
        addSubnode(avatarNode)
        addSubnode(languageNode)
    }
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        avatarNode.style.preferredSize = CGSize(width: 40, height: 40)
        let nlStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .center, children: [nameNode,languageNode])
        let anlStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, children: [avatarNode,nlStack])
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: anlStack)
    }
}
extension UserNode: ASNetworkImageNodeDelegate {
    
}
