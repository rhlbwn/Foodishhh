//
//  SearchBarView.swift
//  Maveric
//
//  Created by Rahul Bawane on 11/05/21.
//

import UIKit

protocol SearchProtocol {
    func search(item: String)
}

class SearchBarView: UITableViewHeaderFooterView {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: SearchProtocol!
    
    override func awakeFromNib() {
        searchBar.delegate = self
        searchBar.placeholder = "Search food"
    }
}

extension SearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate.search(item: searchText)
    }
}
