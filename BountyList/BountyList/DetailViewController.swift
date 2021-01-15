//
//  DetailViewController.swift
//  BountyList
//
//  Created by meng on 2021/01/15.
//

import UIKit

class DetailViewController: UIViewController {
    
    //******************************** MVVM ******************************************

    //------------------------Model----------------------------
    // - BountyInfo 만들자
    
    //------------------------View-----------------------------
    // - imgView, nameLabel, bountyLabel 들은 viewmodel을 통해서 구성되기
    
    //------------------------View Model-----------------------
    // - view에서 필요한 메서드 만들기
    // - 모델 가지고 있기 BountyInfo 등등
    
    

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    let viewModel = DetailViewModel()
    
    //이부분은 화면이 바로 보여지기 직전에 수행되는 것들
    //수행되고 화면이 뜸.
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        if let bountyInfo = viewModel.bountyInfo{
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

class DetailViewModel {
    var bountyInfo: BountyInfo?
    
    func update(model: BountyInfo?){
        bountyInfo = model
    }
}
