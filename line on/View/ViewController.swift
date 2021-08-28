//
//  ViewController.swift
//  line on
//
//  Created by Recep Bayraktar on 28.08.2021.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    //MARK: - Properties
    var menuIsVisible = false
    var newsViewModel = NewsViewModel()
    var scoresViewModel = ScoresViewModel()
    
    //MARK: - Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var menuStackVİew: UIStackView!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var scoresTableView: UITableView!
    @IBOutlet weak var newsButtonView: UIView!
    @IBOutlet weak var scoresButtonView: UIView!
    @IBOutlet weak var standingButtonView: UIView!
    @IBOutlet weak var nothingView: UIView!
    @IBOutlet weak var menuLabel: UILabel!
    
    
    //MARK: - LİfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        let newsTappedGesture = UITapGestureRecognizer(target: self, action: #selector(newsTapped))
        newsButtonView.addGestureRecognizer(newsTappedGesture)
        
        let scoresTappedGesture = UITapGestureRecognizer(target: self, action: #selector(scoresTapped))
        scoresButtonView.addGestureRecognizer(scoresTappedGesture)
        
        let standingTappedGesture = UITapGestureRecognizer(target: self, action: #selector(standingTapped))
        standingButtonView.addGestureRecognizer(standingTappedGesture)
    }
    
    //MARK: - Functions
    
    @objc func newsTapped() {
        
        newsTableView.isHidden = false
        scoresTableView.isHidden = true
        nothingView.isHidden = true
        
        menuStackVİew.isHidden = true
        menuLabel.text = "News"
        
        self.newsTableView.reloadData()
        
    }
    
    @objc func scoresTapped() {
        
        newsTableView.isHidden = true
        scoresTableView.isHidden = false
        nothingView.isHidden = true
        
        menuStackVİew.isHidden = true
        menuLabel.text = "Scores"
        
        self.scoresTableView.reloadData()
    }
    
    @objc func standingTapped() {
        newsTableView.isHidden = true
        scoresTableView.isHidden = true
        nothingView.isHidden = false
        
        menuStackVİew.isHidden = true
        menuLabel.text = "Menu"
    }
    
    
    func loadNewsData() {
        newsViewModel.onErrorResponse = { error in
            self.showAlert(message: error)
        }
        newsViewModel.onSuccessResponse = {
            self.newsTableView.reloadData()
        }
        newsViewModel.fetchData()
    }
    
    func loadScoresData() {
        scoresViewModel.onErrorResponse = { error in
            self.showAlert(message: error)
        }
        scoresViewModel.onSuccessResponse = {
            self.scoresTableView.reloadData()
        }
        scoresViewModel.fetchData()
    }
    
    //MARK: - Error Alert Response
    func showAlert(title: String = "Something Wrong", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        if !menuIsVisible {
            menuIsVisible = true
            menuStackVİew.isHidden = true
        } else {
            menuIsVisible = false
            menuStackVİew.isHidden = false
        }
    }
    
    
    //MARK: - Set UI
    
    func setUI() {
        nothingView.isHidden = false
        menuStackVİew.isHidden = true
        newsTableView.isHidden = true
        scoresTableView.isHidden = true
        menuButton.tintColor = UIColor.white
        
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 120
        
        loadNewsData()
        loadScoresData()
    }
    
}

//MARK: - TableView DataSource & Delegate Extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == newsTableView {
            return newsViewModel.news?.news.count ?? 0
        } else {
            return scoresViewModel.scores?.matches.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == newsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
            cell.loadNewsData(data: (newsViewModel.news?.news[indexPath.row])!)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "scoresCell", for: indexPath) as! ScoresTableViewCell
            cell.loadScoresData(data: (scoresViewModel.scores?.matches[indexPath.row])!)
            let colors = [UIColor.systemGray4, UIColor.white]
            
            cell.backgroundColor = colors[indexPath.row % colors.count]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == scoresTableView {
            return scoresViewModel.scores?.date ?? ""
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == newsTableView {
            let url = URL(string: newsViewModel.news?.news[indexPath.row].link ?? "")
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url!, configuration: config)
            present(vc, animated: true)
            
        }
    }

}


