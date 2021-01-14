//
//  BountyViewController.swift
//  BountyList
//
//  Created by meng on 2021/01/14.
//

import UIKit

class BountyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let nameList = ["brook", "chopper", "franky", "luffy", "nami", "robin", "sanji", "zoro"]
    let bountyList = [33000000, 50 , 44000000, 3000000, 16000000, 8000000, 77000000, 120000000]
    
    //Segue를 호출할 떄, 밑에 perfromSegue함수 호출로 segue가 실행되기 직전에 준비하여 실행되는 함수.
    //따라서 굳이 호출해주지 않아도 되며, 이미 있는 함수이기 때문에 오버라이딩하여 사용한 것.
    //DetailViewController한테 데이터를 줄 것임
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{  //어떤 세그웨이?
            let vc = segue.destination as? DetailViewController // 목적지세그웨이를 DetailViewController 로 캐스팅하여 vc에 넣기
            
            //이부분에서 if문을 사용하는 이유는 밑에서 index를 이용하여 대입을 하고있기 때문이다
            //윗줄도 vc는 옵셔널 타입형이지만 if를 쓰지 않은 이유는 대입하고 있지 않기 때문이다
            //if를 써도 되고 guard를 써도되며, !를 써도되는등 4가지 박스까기 방법이 있었다.
            
            if let index = sender as? Int{    //밑에 performSegue 함수로부터 sender를 받아왔음. 그것을 Int변환
                vc?.name = nameList[index]
                vc?.bounty = bountyList[index]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //UITableViewDataSource 질문에 대한 답 .
    //셸이 몇개?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bountyList.count
    }
    
    //셸을 어떻게 표현할 거니?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //부드럽게 박스 까는법.
        //withIdentifier하면 id를 쓰라는말.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? ListCell else{
            return UITableViewCell()
        }

        //뷰에 넣어주는 부분들
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        cell.imageView?.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.bountyLabel.text = "\(bountyList[indexPath.row])"
        return cell
    }
    
    //UITableViewDelegate 질문에 대한 답
    //클릭 했을 때, 어떻게 할꺼야?
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //뒷부분에 sender는 showDetail로 넘어가기 전에 넘겨주어야할 것을 prepare 로 넘겨준다.
        //showDetail은 segue에 id임.
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
}

class ListCell: UITableViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
}
