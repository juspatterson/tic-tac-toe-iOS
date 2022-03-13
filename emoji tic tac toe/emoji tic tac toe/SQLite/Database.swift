//
//  Database.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 2/9/21.
//

import Foundation
import SQLite3

struct HighScore {
    let playerName: NSString
    let numberOFMoves: Int32
    let dateTime: NSString
}

protocol SQLTable {
  static var createStatement: String { get }
}

extension HighScore: SQLTable {
  static var createStatement: String {
    return """
    CREATE TABLE IF NOT EXISTS HighScores(
        playerName CHAR(255) NOT NULL,
        numberOFMoves INTEGER NOT NULL,
        dateTime CHAR(255) NOT NULL
    );
    """
  }
}

class Database  {
    
    let DirectoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    lazy var path = DirectoryUrl?.appendingPathComponent("database.sqlite").relativePath
    
    init() {}
        //addHighScore(playerName: "justin", numberOFMoves: 3, dateTime: "test")
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func accessDatabase() -> [HighScore] {
        var db: SQLiteDatabase
        do {
            db = try SQLiteDatabase.open(path: path ?? "" )
            
            guard let database = db.highScoreInAscendingOrder() else { return [] }
                //print("\(first[0].playerName)")
            return database
            
            
        } catch SQLiteError.OpenDatabase(_) {
            print("Unable to open database.")
        } catch {}
        return []
        
    }
    
    func addHighScore(playerName: String, numberOFMoves: Int, dateTime: String){
        var db: SQLiteDatabase
        do {
            db = try SQLiteDatabase.open(path: path ?? "" )
            do {
                try db.insertHighScore(highScores: HighScore(playerName: playerName as NSString, numberOFMoves: Int32(numberOFMoves as Int), dateTime: dateTime as NSString))
            } catch {
              print(db.errorMessage)
            }
            print("Successfully opened connection to database.")
        } catch SQLiteError.OpenDatabase(_) {
            print("Unable to open database.")
        } catch {}
    }
    
    func createTable() {
        let db: SQLiteDatabase
        do {
            db = try SQLiteDatabase.open(path: path ?? "" )
            do {
              try db.createTable(table: HighScore.self)
            } catch {
                print(db.errorMessage)
            }
        } catch SQLiteError.OpenDatabase(_) {
            print("Unable to open database.")
        } catch {}
    }
    

    
    
    
    
}
