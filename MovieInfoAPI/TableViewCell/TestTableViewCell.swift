//
//  TestTableViewCell.swift
//  MovieInfoAPI
//
//  Created by 황재현 on 2023/05/04.
//

import UIKit
import RxSwift
import RxCocoa

class TestTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .yellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
