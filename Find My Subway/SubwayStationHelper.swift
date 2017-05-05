//
//  SubwayStationHelper.swift
//  Find My Subway
//
//  Created by Mike Lepore on 4/25/17.
//  Copyright © 2017 Ameropel. All rights reserved.
//

import UIKit

class SubwayStationHelper: NSObject {

    // MARK: - Station Lines
    
    enum StationLineType {
        case line_1
        case line_2
        case line_3
        
        case line_4
        case line_5
        case line_6
        case line_6_express
        
        case line_7
        case line_7_express
        
        case line_A
        case line_C
        case line_E
        
        case line_B
        case line_D
        case line_F
        case line_M
        
        case line_G
        
        case line_J
        case line_Z
        
        case line_L
        
        case line_N
        case line_Q
        case line_R
        
        case line_S
        
        case line_SIR
        
        case line_Unknown
    }
    
    func getSubwayLineName(line: StationLineType) -> String {
        
        switch line {
        case .line_1: return "1"
        case .line_2: return "2"
        case .line_3: return "3"
        case .line_4: return "4"
        case .line_5: return "5"
        case .line_6: return "6"
        case .line_6_express: return "<6>"
        case .line_7: return "7"
        case .line_7_express: return "<7>"
        case .line_A: return "A"
        case .line_C: return "C"
        case .line_E: return "E"
        case .line_B: return "B"
        case .line_D: return "D"
        case .line_F: return "F"
        case .line_M: return "M"
        case .line_G: return "G"
        case .line_J: return "J"
        case .line_Z: return "Z"
        case .line_L: return "L"
        case .line_N: return "N"
        case .line_Q: return "Q"
        case .line_R: return "R"
        case .line_S: return "S"
        case .line_SIR: return "SIR"
        case .line_Unknown: return "?"
        }
    }
    
    func getSubwayLineIcon(line: StationLineType) -> String {
        
        switch line {
        case .line_1: return "subway_line_1"
        case .line_2: return "subway_line_2"
        case .line_3: return "subway_line_3"
        case .line_4: return "subway_line_4"
        case .line_5: return "subway_line_5"
        case .line_6: return "subway_line_6"
        case .line_6_express: return "subway_line_6_express"
        case .line_7: return "subway_line_7"
        case .line_7_express: return "subway_line_7_express"
        case .line_A: return "subway_line_a"
        case .line_C: return "subway_line_c"
        case .line_E: return "subway_line_e"
        case .line_B: return "subway_line_b"
        case .line_D: return "subway_line_d"
        case .line_F: return "subway_line_f"
        case .line_M: return "subway_line_m"
        case .line_G: return "subway_line_g"
        case .line_J: return "subway_line_j"
        case .line_Z: return "subway_line_z"
        case .line_L: return "subway_line_l"
        case .line_N: return "subway_line_n"
        case .line_Q: return "subway_line_q"
        case .line_R: return "subway_line_r"
        case .line_S: return "subway_line_s"
        case .line_SIR: return "subway_line_sir"
        case .line_Unknown: return "subway_line_unknown"
        }
    }
    
    func getSubwayLineEnum(line: String) -> StationLineType {
        
        if      line == "1" { return .line_1 }
        else if line == "2" { return .line_2 }
        else if line == "3" { return .line_3 }
        else if line == "4" { return .line_4 }
        else if line == "5" { return .line_5 }
        else if line == "6" { return .line_6 }
        else if line == "<6>" { return .line_6_express }
        else if line == "7" { return .line_7 }
        else if line == "<7>" { return .line_7_express }
        else if line == "A" { return .line_A }
        else if line == "C" { return .line_C }
        else if line == "E" { return .line_E }
        else if line == "B" { return .line_B }
        else if line == "D" { return .line_D }
        else if line == "F" { return .line_F }
        else if line == "M" { return .line_M }
        else if line == "G" { return .line_G }
        else if line == "J" { return .line_J }
        else if line == "Z" { return .line_Z }
        else if line == "L" { return .line_L }
        else if line == "N" { return .line_N }
        else if line == "Q" { return .line_Q }
        else if line == "R" { return .line_R }
        else if line == "S" { return .line_S }
        else if line == "SIR" { return .line_SIR }
        else { return .line_Unknown }
    }

    func listOfSubwayLines() -> [StationLineType] {
        
        var lines: [StationLineType] = []
        
        lines.append(.line_1)
        lines.append(.line_2)
        lines.append(.line_3)
        lines.append(.line_4)
        lines.append(.line_5)
        lines.append(.line_6)
        lines.append(.line_6_express)
        lines.append(.line_7)
        lines.append(.line_7_express)
        lines.append(.line_A)
        lines.append(.line_C)
        lines.append(.line_E)
        lines.append(.line_B)
        lines.append(.line_D)
        lines.append(.line_F)
        lines.append(.line_M)
        lines.append(.line_G)
        lines.append(.line_J)
        lines.append(.line_Z)
        lines.append(.line_L)
        lines.append(.line_N)
        lines.append(.line_Q)
        lines.append(.line_R)
        lines.append(.line_S)
        lines.append(.line_SIR)
        
        return lines
        
    }
    
}
