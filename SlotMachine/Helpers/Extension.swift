//
//  Extension.swift
//  SlotMachine
//
//  Created by Maya Ghamloush on 13/03/2024.
//

import SwiftUI

extension Text{
    func scoreLabelStyle() -> Text{
        self
            .foregroundColor(.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    func scoreNumberStyle() -> Text{
        self
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
