---
title: "Writing your own Azure Data Studio extension, Part 2"
date: 2019-08-09T00:00:00+00:00
author: Spoorthi Satheesha
layout: post
permalink: /writing-your-own-azure-data-studio-extension-part-2/
categories: Programming
tags: [typescript]
excerpt: "Part 2 of the tutorial on how to write your own Azure Data Studio extension"
seo_title: "Writing your own Azure Data Studio extension, Part 2"
seo_description: "Part 2 of the tutorial on how to write your own Azure Data Studio extension"
---

In the following post, we will be building upon the changes done in the [**this**](./2019-06-11-Writing-Your-Own-Azure-Data-Studio-Extension-Part-1.md) post. So, I would recommend going back to that, if you haven’t already done so.

In this post, we will be making the changes to show intellisense regarding the database table and its columns on hover. For this purpose, we have created a documentation.json in the root of the DbScripts repository. We will be reading the documentation text from it and loading it into extension storage. And when a user hovers over a table name, we can fetch the data from the extension storage and create a markdown string and show that.

![Documentation.json](/assets/images/posts/2019-08-09-Writing-Your-Own-Azure-Data-Studio-Extension-Part-2/documentationjson.png "Documentation.json")

![Intellisense](/assets/images/posts/2019-08-09-Writing-Your-Own-Azure-Data-Studio-Extension-Part-2/intellisense.png "Intellisense")

You can find the implementation details and the source below.

## column.ts
This class declares the database table column. It contains the column properties like datatype, nullable etc and a description about the column.

```typescript

export default class Column {
    Name!: string;
    Description!: string;
    DataType!: string;
    DataLength!: number;
    Nullable!: boolean;
}

```

## extension.ts

*  Here we register the hover provider. While instantiating the hover provider, we also pass along the extension context state. The extension storage can be accessed only through this property. So, we need to pass this along so documentation can be read from it.

*  Next we register a command to update the documentation. We wont be reading the documentation from the file every time we wanna refer to it. So, to makes things faster, we store it in the extension storage. This needs to be updated if there are any changes done to the documentation file. So we expose a command to update the documentation.

* We also set a global setting to check if documentation has already been loaded ever before, if it has not, then we load the documentation. This usually happens the very first time you open the extension after setting up the extension settings.

```typescript

'use strict';
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';

import ProBaseDefinitionProvider from './features/proBaseDefinitionProvider';
import ProBaseHoverProvider from './features/proBaseHoverProvider';
import Helper from './utils/helper';

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {

    //Enables Go to Definition and Peek Definition
    context.subscriptions.push(vscode.languages.registerDefinitionProvider({ language: "sql" }, new ProBaseDefinitionProvider()));

    //Enables intellisense on hover
    context.subscriptions.push(vscode.languages.registerHoverProvider({ language: "sql" }, new ProBaseHoverProvider(context.globalState)));

    //Updates documentation
    context.subscriptions.push(vscode.commands.registerCommand('extension.updateDocumentation', () => {
        Helper.LoadDocumentation(context.globalState);
    }));
    
    if (!context.globalState.get(Helper.IsDocumentationLoaded)) {
        Helper.LoadDocumentation(context.globalState);
    }
}

```

## helper.ts

Here we implement the code to read the documentation.json file and load the data to the extension storage.

```typescript

import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';
import ProBaseError from './probaseError';
import Table from './table';

export default class Helper {

    public static IsDocumentationLoaded : string = "IsDocumentationLoaded";

    public static GetDbScriptsPath(): string {
        return vscode.workspace.getConfiguration().get("code.dbscriptsFolderPath") as string;
    }

    public static IsRepositorySetup(): boolean {
        var dbScriptRepoFolder = this.GetDbScriptsPath();
        if (!dbScriptRepoFolder)
            return false;
        else if (dbScriptRepoFolder === "")
            return false;
        return true;
    }
    
    public static LoadDocumentation(state: vscode.Memento): void {

        if (this.IsRepositorySetup()) {
            var documentationFilePath = path.join(this.GetDbScriptsPath(), "documentation.json");
            fs.readFile(documentationFilePath, "utf-8", function (err, content) {

                if (err)
                    throw new ProBaseError(err.name, err.message);

                state.update(Helper.IsDocumentationLoaded, true);
                JSON.parse(content).forEach((element: any) => {
                    var table: Table = Object.assign(new Table(), element);
                    state.update(table.Name.toLowerCase(), table);
                });
            });
        }
    }
}

```

## package.json

Declaration of any new command needs to be added in package.json under the contributes section.

```typescript

{
    "name": "Name",
    "displayName": "Display Name",
    "description": "Extension description",
    "version": "1.0.0",
    "engines": {
        "vscode": "^1.33.0",
        "sqlops": "*"
    },
    "activationEvents": [
        "onLanguage:sql"
    ],
    "main": "./out/extension",
    "contributes": {
      "commands": [
            {
                "command": "extension.updateDocumentation",
                "title": "Probase: Update ProArc DB tables documentation"
            },
        ],
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
}

```

## probaseHoverProvider.ts

Here we implement the logic to read the documentation data and format it into a nice readable markdown. We need to implement the *vscode.HoverProvider* interface and the *provideHover* method needs to return the string which will be shown on hover.

```typescript

import * as vscode from 'vscode'
import Table from '../utils/table';
import Column from '../utils/column';

export default class ProBaseHoverProvider implements vscode.HoverProvider {

    State: vscode.Memento;

    public constructor(state: vscode.Memento) {
        this.State = state;
    }

    provideHover(document: vscode.TextDocument, position: vscode.Position, token: vscode.CancellationToken): vscode.ProviderResult<vscode.Hover> {

        var selectedWord = document.getText(document.getWordRangeAtPosition(position));
        var table = this.State.get(selectedWord.toLowerCase()) as Table;
        if (table)
            return new vscode.Hover(this.buildIntellisenseMarkdown(table));
    }

    private buildIntellisenseMarkdown(table: Table): string | vscode.MarkdownString | { language: string; value: string; } {

        var tableDetails = this.buildTableMarkdown(table);
        var markdown = new vscode.MarkdownString(tableDetails);

        if (table.Columns) {

            markdown.appendMarkdown("\n***\n");

            for (var column of table.Columns) {
                var columnDetails = this.buildColumnMarkdown(column);
                markdown.appendMarkdown(columnDetails + ` - ${column.DataType}[${column.DataLength}]`);
            }
        }

        return markdown;
    }

    private buildColumnMarkdown(column: Column) {
        var columnDetails = `\n\n   \`${column.Name}\``;

        if (column.Nullable) {
            columnDetails += " *(nullable)*";
        }

        if (column.Description) {
            columnDetails += ` - ${column.Description}`;
        }

        return columnDetails;
    }

    private buildTableMarkdown(table: Table) {
        var tableDetails = `### ${table.Name.toUpperCase()}`;
        if (table.Description) {
            tableDetails += ` - ${table.Description}`;
        }
        return tableDetails;
    }
}

```

## table.ts

This class contains the properties of the database table and contains the list of columns the table has.

```typescript

import Column from "./column";

export default class Table {
    Name!: string;
    Description!: string;
    Columns!: Column[]
}

```