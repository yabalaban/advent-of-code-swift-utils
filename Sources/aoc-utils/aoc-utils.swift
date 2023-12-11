//
//  aoc.swift
//
//
//  Created by Alexander Balaban.
//

import Foundation

public typealias Solution = (String) -> Int

public protocol Problem {
    var day1: Solution? { get }
    var day2: Solution? { get }
}

public protocol ProblemSet {
    func problem(for: Day) -> Problem
    func solve()
}

public enum Day: String {
    case day1 = "1"
    case day2 = "2"
    case day3 = "3"
    case day4 = "4"
    case day5 = "5"
    case day6 = "6"
    case day7 = "7"
    case day8 = "8"
    case day9 = "9"
    case day10 = "10"
    case day11 = "11"
    case day12 = "12"
    case day13 = "13"
    case day14 = "14"
    case day15 = "15"
    case day16 = "16"
    case day17 = "17"
    case day18 = "18"
    case day19 = "19"
    case day20 = "20"
    case day21 = "21"
    case day22 = "22"
    case day23 = "23"
    case day24 = "24"
    case day25 = "25"
}
