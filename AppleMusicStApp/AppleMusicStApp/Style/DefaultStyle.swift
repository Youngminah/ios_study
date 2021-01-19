//
//  DefaultStyle.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/03/15.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit


public enum DefaultStyle {
    public enum Colors {
        public static let tint: UIColor = {
            if #available(iOS 13.0, *) {
                //UIColor 를 반환할 것인데 , traitCollction를 통하여 현재 다크모드인지 아닌지를 알 수 있음.
                return UIColor { traitCollction in
                    //다크모드라면 검은색, 다크모드아니라면 흰색으로 출력된다. 
                    if traitCollction.userInterfaceStyle == .dark {
                        return .white
                    } else {
                        return .black
                    }
                }
            } else {
                return .black
            }
        }()
    }
}
