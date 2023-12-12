//
//  aoc.swift
//
//  Created by Alexander Balaban.
//

import Foundation

// Fundamental declarations

public typealias Solution = (String) -> Int

public protocol DailyProblem {
    var part1: Solution? { get }
    var part2: Solution? { get }
}

public protocol ProblemSet {
    func problem(for: Day) -> DailyProblem
    func solve() async throws
}

public enum Day: String, CaseIterable {
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

// Basically, API

public func getProblemSet(for year: Int, cookie: String) -> ProblemSet {
    AOCProblemSet(year, cookie)
}

// Below goes boring implementation of the protocols from above

class AOCDailyProblem: DailyProblem {
    var part1: Solution?
    var part2: Solution?
    let loader: InputLoader
    let desc: String
    
    init(_ loader: InputLoader, _ desc: String) {
        self.loader = loader
        self.desc = desc
    }
    
    func solve() async throws {
        let input = try await self.loader.load()
        let output1 = {
            let output = part1?(input)
            return output != nil ? "\(output!)" : "missing"
        }()
        let output2 = {
            let output = part2?(input)
            return output != nil ? "\(output!)" : "missing"
        }()
        
        print(desc)
        print("\tPart 1: \(output1)")
        print("\tPart 2: \(output2)")
        print()
    }
}

class AOCProblemSet: ProblemSet {
    private let year: Int
    private let cookie: String
    private var dailies: [Day: AOCDailyProblem] = [:]
    
    init(_ year: Int, _ cookie: String) {
        self.year = year
        self.cookie = cookie
    }
    
    public func problem(for day: Day) -> DailyProblem {
        if let problem = dailies[day] {
            return problem
        } else {
            let loader = InputLoader("\(year)/day/\(day.rawValue)", cookie)
            let problem = AOCDailyProblem(loader, "Day \(day.rawValue)")
            dailies[day] = problem
            return problem
        }
    }
    
    public func solve() async throws {
        for daily in Day.allCases.compactMap({ dailies[$0] }) {
            try await daily.solve()
        }
    }
}

class InputLoader {
    private static let url = "https://adventofcode.com/"
    private static let filename = "cache.txt"
    private let path: String
    private let cookie: String
 
    init(_ path: String, _ cookie: String) {
        self.path = path
        self.cookie = cookie
    }
    
    func load() async throws -> String {
        if let cached = try load(path) {
            return cached
        }
        
        guard let url = URL(string: "\(Self.url)\(path)") else { fatalError("Can't create url: \(Self.url)\(path)") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(cookie, forHTTPHeaderField: "Cookie")
        
        let response = try await URLSession.shared.data(for: request)
        guard let input = String(bytes: response.0, encoding: .utf8) else {
            fatalError("Failed to load input from \(url)")
        }
        
        try save(input, to: path)
        return input
    }
    
    private func save(_ content: String, to path: String) throws {
        guard let data = content.data(using: .utf8) else { fatalError("Can't encode input with .utf8") }
        let fm = FileManager.default
        let pathUrl = fm.temporaryDirectory.appendingPathComponent(path)
        try fm.createDirectory(atPath: pathUrl.path, withIntermediateDirectories: true, attributes: nil)
        fm.createFile(atPath: pathUrl.appendingPathComponent(Self.filename).relativePath,
                      contents: data)
    }
    
    private func load(_ path: String) throws -> String? {
        let fm = FileManager.default
        let pathUrl = FileManager.default.temporaryDirectory.appendingPathComponent(path)
        if let data = fm.contents(atPath: pathUrl.appendingPathComponent(Self.filename).relativePath) {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
}
