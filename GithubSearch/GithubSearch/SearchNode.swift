//
//  SearchNode.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/21.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import AsyncDisplayKit

class SearchNode: ASCellNode {
    var searchBarNode: SearchBarNode
    
    init(delegate: UISearchBarDelegate?) {
        self.searchBarNode = SearchBarNode(delegate: delegate)
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: .zero, child: searchBarNode)
    }
}
