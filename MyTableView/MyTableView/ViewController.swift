//
//  ViewController.swift
//  MyTableView
//
//  Created by meng on 2021/06/14.
//

import UIKit
import AVFoundation

class ViewController: UIViewController  {
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        
        return table
    }()
    
    private var models = [CellModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpModels()
        view.addSubview(table)
        table.tableHeaderView = createTableHeader()
        table.delegate = self
        table.dataSource  = self
    }
    
    private func createTableHeader() -> UIView?{
        guard let path = Bundle.main.path(forResource: "video", ofType: "mp4") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.volume = 0
        
        let headerView  = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = headerView.bounds
        headerView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = .resizeAspectFill
        player.play()
        
        return headerView
    }
    
    private func setUpModels(){
        models.append(.collectionView(models: [
            CollectionTableCellModel(title: "Car 1", imageName: "car1"),
            CollectionTableCellModel(title: "Car 2", imageName: "car2"),
            CollectionTableCellModel(title: "Car 3", imageName: "car3"),
            CollectionTableCellModel(title: "Car 4", imageName: "car4"),
            CollectionTableCellModel(title: "Car 5", imageName: "car5"),
            CollectionTableCellModel(title: "Car 6", imageName: "car6"),
            CollectionTableCellModel(title: "Car 7", imageName: "car7")
        ], rows: 2))
        models.append(.list(models: [
            ListCellModel(title: "First Thing"),
            ListCellModel(title: "Second Thing"),
            ListCellModel(title: "Another Thing"),
            ListCellModel(title: "Other Thing"),
            ListCellModel(title: "More Thing"),
        ]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case .list(models: let models): return models.count
        case .collectionView(_, _): return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
        case .list(let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
            cell.textLabel?.text = model.title
            return cell
        case .collectionView(let models, _):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            cell.delegate = self
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Did select normal item")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch models[indexPath.section] {
        case .list(_): return 50
        case .collectionView(_, let rows): return CGFloat(180 * rows)
        }
    }
}

extension ViewController: CollectionTableViewCellDelegate {
    func didSelectItem(with model: CollectionTableCellModel) {
        print("Selected \(model.title)")
    }
}
