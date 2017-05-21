
//
//  SearchNode.swift
//  GithubSearch
//
//  Created by wxlpp on 2017/5/20.
//  Copyright © 2017年 wxlpp. All rights reserved.
//

import AsyncDisplayKit

final class SearchBarNode: ASDisplayNode {
    
    weak var delegate: UISearchBarDelegate?
    
    init(delegate: UISearchBarDelegate?) {
        self.delegate = delegate
        super.init()
        setViewBlock { () -> UIView in
            UISearchBar()
        }
        style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 44)
    }
    
    var searchBar: UISearchBar {
        return view as! UISearchBar
    }
    
    override func didLoad() {
        super.didLoad()
        searchBar.delegate = delegate
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .black
        searchBar.backgroundColor = .white
        searchBar.placeholder = "搜索"
    }
}
