//
//  main.swift
//  too_doo
//
//  Created by YashyZB on 6/5/21.
//  Copyright © 2021 SUT. All rights reserved.
//

import Foundation

func handle_cmd(inp: String) -> Bool{
    let inpArray = inp.components(separatedBy: " ")
    let cmd: String = inpArray[ParamOrder.CMD.rawValue].uppercased()
    let command = Command(rawValue: cmd)
    switch command {
    case .HELP:
        print("Help")
    case .ADD:
        print("Add")
    case .CREATE:
        print("Create")
    case .VIEW:
        print("View")
    case .VIEW_ALL:
        print("View all")
    case .EDIT:
        print("Edit")
    case .DELETE:
        print("Delete")
    case .EXIT:
        return false
    default:
        print("Default")
    }
    return true
}

print("Enter a command. help for commands' help")

var isRunning = true
while isRunning {
    let inp = readLine()
    isRunning = handle_cmd(inp: inp!)
}
