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
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()
    
    //이부분은 화면이 바로 보여지기 직전에 수행되는 것들
    //수행되고 화면이 뜸.
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation() //애니메이션 준비단계
    }
    
    //화면이 보여지고 실행되는 것
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    private func prepareAnimation(){
//        nameLabelCenterX.constant = view.bounds.width
//        bountyLabelCenterX.constant = view.bounds.width
        
        //3배로 키우고 180도 회전되어있음.
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x: 3, y: 3).rotated(by: 180)
        //투명도
        nameLabel.alpha = 0
        bountyLabel.alpha = 0
    }
    
    
    private func showAnimation(){
//        //레이아웃이 바뀌면 레이아웃팅을 다시 해야됨 그과정에 애니메이션으로 레이아웃팅한 것
//        //레이아웃에 관한 애니메이션
//        nameLabelCenterX.constant = 0
//        bountyLabelCenterX.constant = 0
//
//        여러가지 다른 애니메이션
//        UIView.animate(withDuration: 0.3){
//            self.view.layoutIfNeeded()
//        }
//        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn,
//                       animations: {self.view.layoutIfNeeded()}, completion: nil)
//
//        //animation에 nil을 안넣은 이유는 constant는 레이아웃에 해당하는 것이기 때문에,
//        //self.view.layoutIfNeed() (레이아웃을 다시할필요있다면 다시해라) 라는 함수를 이용.
//        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.6,
//                       initialSpringVelocity: 2, options: .allowUserInteraction,
//                       animations: {self.view.layoutIfNeeded()}, completion: nil)
//
//        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
        //이름이랑 현상금 따로 애니메이션 걸어줌.
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6,initialSpringVelocity: 2, options: .allowUserInteraction,
                       animations: {
                        //변하기 전의 모습으로는 identity로 접근이 가능함.
                        self.nameLabel.transform = CGAffineTransform.identity
                        self.nameLabel.alpha = 1
                       }, completion: nil)
        UIView.animate(withDuration: 1, delay: 0.2, usingSpringWithDamping: 0.6,initialSpringVelocity: 2, options: .allowUserInteraction,
                       animations: {
                        //변하기 전의 모습으로는 identity로 접근이 가능함.
                        self.bountyLabel.transform = CGAffineTransform.identity
                        self.bountyLabel.alpha = 1
                       }, completion: nil)
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
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
