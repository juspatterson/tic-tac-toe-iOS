//
//  SQLiteDatabase.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 2/9/21.
//

import Foundation
import SQLite3

enum SQLiteError: Error {
    case OpenDatabase(message: String)
    case Prepare(message: String)
    case Step(message: String)
    case Bind(message: String)
}

class SQLiteDatabase {
    private let dbPointer: OpaquePointer?
    private init(dbPointer: OpaquePointer?) {
        self.dbPointer = dbPointer
    }
    deinit {
        sqlite3_close(dbPointer)
    }
    
    static func open(path: String) throws -> SQLiteDatabase {
      var db: OpaquePointer?
      // 1
      if sqlite3_open(path, &db) == SQLITE_OK {
        // 2
        return SQLiteDatabase(dbPointer: db)
      } else {
        // 3
        defer {
          if db != nil {
            sqlite3_close(db)
          }
        }
        if let errorPointer = sqlite3_errmsg(db) {
          let message = String(cString: errorPointer)
          throw SQLiteError.OpenDatabase(message: message)
        } else {
          throw SQLiteError
            .OpenDatabase(message: "No error message provided from sqlite.")
        }
      }
    }
    
    var errorMessage: String {
      if let errorPointer = sqlite3_errmsg(dbPointer) {
        let errorMessage = String(cString: errorPointer)
        return errorMessage
      } else {
        return "No error message provided from sqlite."
      }
    }
}

extension SQLiteDatabase {
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        var statement: OpaquePointer?
        guard sqlite3_prepare_v2(dbPointer, sql, -1, &statement, nil) == SQLITE_OK
        else {
            throw SQLiteError.Prepare(message: errorMessage)
        }
        return statement
    }
}

extension SQLiteDatabase {
    func createTable(table: SQLTable.Type) throws {
        // 1
        let createTableStatement = try prepareStatement(sql: table.createStatement)
        // 2
        defer {
            sqlite3_finalize(createTableStatement)
        }
        // 3
        guard sqlite3_step(createTableStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
    }
}

extension SQLiteDatabase {
    func insertHighScore(highScores: HighScore) throws {
        let insertSql = "INSERT INTO HighScores (playerName, numberOFMoves, dateTime) VALUES (?, ?, ?);"
        let insertStatement = try prepareStatement(sql: insertSql)
        defer {
            sqlite3_finalize(insertStatement)
        }
        let playersName: NSString = highScores.playerName
        let dateTime: NSString = highScores.dateTime
        guard
            sqlite3_bind_text(insertStatement, 1, playersName.utf8String, -1, nil) == SQLITE_OK &&
            sqlite3_bind_int(insertStatement, 2, highScores.numberOFMoves) == SQLITE_OK  &&
            sqlite3_bind_text(insertStatement, 3, dateTime.utf8String, -1, nil) == SQLITE_OK
      
        else {
            throw SQLiteError.Bind(message: errorMessage)
        }
        guard sqlite3_step(insertStatement) == SQLITE_DONE else {
            throw SQLiteError.Step(message: errorMessage)
        }
        print("Successfully inserted row.")
    }
    
}

extension SQLiteDatabase {
    func highScoreInAscendingOrder() -> [HighScore]? {
        let querySql = "SELECT * FROM HighScores ORDER BY numberOFMoves ASC;"
        var arrayOfHighScores: [HighScore] = []
        
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            return nil
        }
        defer {
            sqlite3_finalize(queryStatement)
        }
        
        while sqlite3_step(queryStatement) == SQLITE_ROW {
        
            guard let queryResultCol1 = sqlite3_column_text(queryStatement, 0) else {
                print("Query result is nil.")
                return nil
            }
    
            let queryResultCol2 = sqlite3_column_int(queryStatement, 1)
        
            guard let queryResultCol3 = sqlite3_column_text(queryStatement, 2) else {
                print("Query result is nil.")
                return nil
            }
    
            let playersName = String(cString: queryResultCol1) as NSString
            let numberOfMoves = queryResultCol2
            let dateTime = String(cString: queryResultCol3) as NSString
        
            
            arrayOfHighScores.append(HighScore(playerName: playersName, numberOFMoves: numberOfMoves, dateTime: dateTime))
        }
        
        return arrayOfHighScores
    }
}


