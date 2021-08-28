//
//  ScoresTableViewCell.swift
//  line on
//
//  Created by Recep Bayraktar on 28.08.2021.
//

import UIKit

class ScoresTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    //MARK: - Functions
    func loadScoresData(data: Match) {
        homeLabel.text = data.teamA.displayName
        awayLabel.text = data.teamB.displayName
        scoreLabel.text = "\(data.ftsA)" + " - " + "\(data.ftsB)"
    }
    
}
