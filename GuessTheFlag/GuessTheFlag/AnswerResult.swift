//
//  AnswerResult.swift
//  GuessTheFlag
//
//  Created by EDGARDO AGNO on 27/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

enum AnswerResult {
    case none, lose, win
}

extension AnswerResult {
    var gradient: [UIColor] {
        switch self {
        case .none: return [.primaryBlack, .primaryGray]
        case .lose: return [.primaryBlack, .red]
        case .win: return [.primaryBlack, .green]
        }
    }
}

