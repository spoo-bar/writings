---
title: "Writing your own Azure Data Studio extension, Part 1"
date: 2019-06-11T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /writing-your-own-azure-data-studio-extension-part-1/
categories: Programming
tags: [typescript]
---

You don’t need to have an extensive background in Javascript or TypeScript to write an Azure Data Studio extension. However, being familiar with the languages makes it easy. You can find the preliminary steps on [**this**](https://code.visualstudio.com/api/get-started/your-first-extension) page. This post is part one of a series on making Azure Data Studio extensions.

We are considering a sample git repository which contains all the SQL required to set up an application. It has install scripts, for first time installations, and also upgrade scripts, to upgrade from any of the previous product versions. The application supports MS SQL and Oracle for the client to choose to run the application on top of, so that’s twice the amount of SQL scripts to deal with. Table structures change every release. With over 250 tables, many of which haven’t been touched for years, it is hard for developers to know what data a table contains and why it exists. The goal of this extension is to make working with these database scripts easier.

In the first part, we will add support for **Go to Definition** (F12) and **Peek Definition** for any table related to the product. Sure, you could just run a simple query against the database to fetch this information. But we already have the source code which sets up the whole database. There is no need to connect to the database server at fetch this information.

You can find the implementation details and the source below.

## package.json

You can get information regarding the manifest format [**here**](https://code.visualstudio.com/api/references/extension-manifest). Configuration for two extension settings is done here.
1. `code.dbscriptsFolderPath` – The file system path to the repository. So we know where to search for the table definitions.
2. `code.sqlSource` – This is an enum field based on which value we look for table definition in MS SQL source folder or Oracle source folder.

```json

{
    "name": "Name",
    "displayName": "Display Name",
    "description": "Extension description",
    "version": "1.0.0",
    "publisher": "spoorthi",
    "engines": {
        "vscode": "^1.33.0",
        "sqlops": "*"
    },
    "main": "./out/extension",
    "contributes": {
        "configuration": [
            {
                "title": "ProBase",
                "properties": {
                    "code.dbscriptsFolderPath": {
                        "type": "string",
                        "description": "The path to DbScripts repository",
                        "scope": "application"
                    },
                    "code.sqlSource": {
                        "type": "string",
                        "enum": [
                            "MS SQL",
                            "Oracle"
                        ],
                        "default": "MS SQL",
                        "description": "SQL source to fetch data for intellisense and other tools",
                        "scope": "application"
                    }
                }
            }
        ]
    },
    "devDependencies": {
        "@types/mocha": "^2.2.42",
        "@types/node": "^7.10.6",
        "sqlops": "github:anthonydresser/sqlops-extension-sqlops",
        "tslint": "^5.8.0",
        "typescript": "^2.6.1",
        "vscode": "^1.1.6"
    }
}

```

## extension.ts

The activate function in extension.ts is the entry point to the extension. Here we will set up the definition provider for SQL language documents. We will be implementing `ProBaseDefinitionProvider` class to fetch us the definitions.

```typescript

'use strict';
import * as vscode from 'vscode';
import ProBaseDefinitionProvider from './features/proBaseDefinitionProvider';

// Extry point to the extension
export function activate(context: vscode.ExtensionContext) {
    //Enables Go to Definition and Peek Definition
    //Runs when document langauge is SQL
    context.subscriptions.push(vscode.languages.registerDefinitionProvider({ language: "sql" }, new ProBaseDefinitionProvider()))
}

```

## proBaseDefinitionProvider.ts

To be a valid definition provider for any language, `vscode.DefinionProvider` interface must be implemented. Here, we are fetching the selected word and checking if there is a `table_name.sql` in the source location. If a file is found, we return the file uri along with the location of the first character in the file.

```typescript

import * as vscode from 'vscode'
import Helper from '../utils/helper';
import * as fs from 'fs';
import * as path from 'path';

export default class ProBaseDefinitionProvider implements vscode.DefinitionProvider {

    provideDefinition(
        document: vscode.TextDocument,
        position: vscode.Position,
        token: vscode.CancellationToken): vscode.ProviderResult<vscode.Location | vscode.Location[] | vscode.LocationLink[]> {

        // Get hover word
        var selectedWord = document.getText(document.getWordRangeAtPosition(position));
        // Get definition file path
        var tableDefinitionFile = path.join(Helper.GetTablesFolderPath(), selectedWord + ".sql");
        if (fs.existsSync(tableDefinitionFile)) {
            var fileUri = vscode.Uri.file(tableDefinitionFile);
            var position = new vscode.Position(0, 0);
            return new vscode.Location(fileUri, position)
        }
        return null;
    }

}

```

## helper.ts

`GetTablesFolderPath()` helper method reads the DbScripts folder path from the extension settings and checks whether MS SQL source or Oracle source is a valid path within that repository.

```typescript

import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';
import ProBaseError from './probaseError';
import Table from './table';

export default class Helper {

    public static GetTablesFolderPath(): string {
        if (Helper.IsRepositorySetup()) {
            if (fs.existsSync(Helper.GetDbScriptsPath())) {
                var tablesFolder = path.join(Helper.GetDbScriptsPath(), "Source", this.GetSQLFolder(), "tables"); // ../DbScripts/Source/mssql_source/tables
                if (fs.existsSync(tablesFolder)) {
                    return tablesFolder;
                }
                else {
                    throw new ProBaseError("DbScriptsPathInvalid", "The path " + tablesFolder + " is invalid.");
                }
            }
            else {
                throw new ProBaseError("DbScriptsPathInvalid", "DbScript Repository path is invalid and does not exist.");
            }
        }
        else {
            throw new ProBaseError("RepositoryNotSetup", "DbScripts Repository path not setup in File > Preferences > Settings");
        }
    }

    private static GetDbScriptsPath(): string {
        return vscode.workspace.getConfiguration().get("code.dbscriptsFolderPath") as string;
    }

    private static IsRepositorySetup(): boolean {
        var dbScriptRepoFolder = this.GetDbScriptsPath();
        if (!dbScriptRepoFolder)
            return false;
        else if (dbScriptRepoFolder === "")
            return false;
        return true;
    }   

    private static GetSQLFolder(): string {
        var sqlSource = this.GetSqlSource();
        switch (sqlSource) {
            case SQLSource.MSSQL: return "mssql_source";
            case SQLSource.Oracle: return "oracle_source";
            default: throw new ProBaseError("SqlSourceInvalid", sqlSource + " is not a valid Sql Source value.");
        }
    }

    private static GetSqlSource(): SQLSource {
        var sqlSourceValue = vscode.workspace.getConfiguration().get("code.sqlSource") as string;
        if (sqlSourceValue === "MS SQL")
            return SQLSource.MSSQL;
        else
            return SQLSource.Oracle;
    }
}

enum SQLSource {
    MSSQL,
    Oracle
}

```

## proBaseError.ts

Throwing a `vscode.Error` does not show on Azure Data Studio application that something went wrong. So, `ProBaseError` wrapper class around vscode.Error was implemented to throw an error message to the user in case of unexpected behavior.

```typescript

import * as vscode from 'vscode'

export default class ProBaseError implements Error {
    name: string;
    message: string;
    stack?: string | undefined;
    
    public constructor(errorName : string, errorMessage : string, errorStack? : string | undefined) {
        this.name = errorName;
        this.message = errorMessage;
        this.stack = errorStack;
        
        vscode.window.showErrorMessage(this.message);
    }

}

```