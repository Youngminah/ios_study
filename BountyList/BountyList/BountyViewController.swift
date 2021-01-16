//
//  BountyViewController.swift
//  BountyList
//
//  Created by meng on 2021/01/14.
//

import UIKit


//flowout프로토콜은 자유롭게 우리가 배치하기위해 추가함.
class BountyViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //******************************** MVVM ******************************************

    //------------------------Model----------------------------
    // - BountyInfo 만들자
    
    //------------------------View-----------------------------
    // - ListCell 에 필요한 정보를 View Model에서 받기
    // - ListCell 은 ViewModel으로부터 받은 정보를 업데이트
    
    //------------------------View Model-----------------------
    // - BountyViewModel을 만들고, view에서 필요한 메서드 만들기
    // - 모델 가지고 있기 BountyInfo 등등
    
    
    let viewModel = BountyViewModel()
    
    //Segue를 호출할 떄, 밑에 perfromSegue함수 호출로 segue가 실행되기 직전에 준비하여 실행되는 함수.
    //따라서 굳이 호출해주지 않아도 되며, 이미 있는 함수이기 때문에 오버라이딩하여 사용한 것.
    //DetailViewController한테 데이터를 줄 것임
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{  //어떤 세그웨이?
            
            // 목적지세그웨이를 DetailViewController 로 캐스팅하여 vc에 넣기
            let vc = segue.destination as? DetailViewController
            
            //이부분에서 if문을 사용하는 이유는 밑에서 index를 이용하여 대입을 하고있기 때문이다
            //윗줄도 vc는 옵셔널 타입형이지만 if를 쓰지 않은 이유는 대입하고 있지 않기 때문이다
            //if를 써도 되고 guard를 써도되며, !를 써도되는등 4가지 박스까기 방법이 있었다.
            if let index = sender as? Int{    //밑에 performSegue 함수로부터 sender를 받아왔음. 그것을 Int변환
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //UICollectionViewDataSource 프로토콜
    //몇개를 보여줄까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    //UICollectionViewDataSource 프로토콜
    //셸은 어떻게 표현할까요? 에 대한 답
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        cell.update(info: bountyInfo)
        return cell
    }
    
    //UICollectionViewDelegate 프로토콜
    //셸이 클릭되었을때 어쩔까요? 에 대한 답
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //뒷부분에 sender는 showDetail로 넘어가기 전에 넘겨주어야할 것을 prepare 로 넘겨준다.
        //showDetail은 segue에 id임.
        performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
    
    //UICollectionViewDelegateFlowLayout 프로토콜
    //cell사이즈를  계산할꺼 - 다양한 디바이스에서 일관적인 디자인을 보여주기 위해 에 대한 답
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        return CGSize(width: width, height: height)
    }
    
}


class BountyViewModel {
    let bountyInfoList: [BountyInfo] = [
        BountyInfo(name: "brook", bounty: 33000000),
        BountyInfo(name: "chopper", bounty: 50),
        BountyInfo(name: "franky", bounty: 44000000),
        BountyInfo(name: "luffy", bounty: 300000000),
        BountyInfo(name: "nami", bounty: 16000000),
        BountyInfo(name: "robin", bounty: 8000000),
        BountyInfo(name: "sanji", bounty: 77000000),
        BountyInfo(name: "zoro", bounty: 120000000)
    ]
    
    var sortedList: [BountyInfo] {
        let sortedList = bountyInfoList.sorted{ prev, next in
            return prev.bounty > next.bounty
        }
        return sortedList
    }

    var numOfBountyInfoList: Int {
        return bountyInfoList.count
    }
    
    func bountyInfo(at index: Int) -> BountyInfo{
        return sortedList[index]
    }
}

class GridCell: UICollectionViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo) {
        self.imgView?.image = info.image
        self.nameLabel.text = info.name
        self.bountyLabel.text = "\(info.bounty)"
    }
}

