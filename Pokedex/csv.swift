//
//  csv.swift
//  Pokedex
//
//  Created by Alexey Ly on 1/18/16.
//  Copyright © 2016 AlbaSoft. All rights reserved.
//

import Foundation


public class CSV
{
    public var headers: [String] = [];
    public var rows: [Dictionary<String, String>] = [];
    public var columns = Dictionary<String, [String]>();
    
    
    public init(contents: String?) {
        let newline = NSCharacterSet.newlineCharacterSet();
        
        if let textToParse = contents {
            var lines = textToParse.componentsSeparatedByCharactersInSet(newline);
            
            // 1. Extract headers
            headers = parseLine(lines[0]);
            
            // 2. Init columns
            for header in headers {
                columns[header] = [];
            }
            
            // 3. Set rows to dictionaries of header-value pairs.
            for (var i = 1; i < lines.count; ++i) {
                let line = lines[i];
                if (line.isEmpty) {
                    break;
                }
                var values = parseLine(line);
                var row = Dictionary<String, String>();
                for (index, header) in headers.enumerate() {
                    row[header] = values[index];
                    columns[header]?.append(values[index]);
                }
                rows.append(row);
            }
        }
    }
    
    public convenience init(url: String) {
        let contents = try? String(contentsOfFile: url, encoding: NSUTF8StringEncoding);
        
        self.init(contents: contents);
    }
    
    
    func parseLine(line: String) -> [String] {
        return line.componentsSeparatedByString(",");
    }
    
}