//
//  NewsTableViewCell.swift
//  line on
//
//  Created by Recep Bayraktar on 28.08.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    //MARK: - Functions
    
    func loadNewsData(data: News) {
        newsImage.downloadedFrom(link: data.picUrl)
        newsTitle.text = data.title
        newsDate.text = data.date
    }
    
}
