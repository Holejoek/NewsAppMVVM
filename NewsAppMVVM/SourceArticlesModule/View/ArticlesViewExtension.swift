//
//  ArticlesViewExtension.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 14.12.2021.
//

import Foundation
import UIKit

extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ArticleCell()
    }
    
    
}
