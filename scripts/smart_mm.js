#!/bin/node

const { spawnSync, execSync } = require('child_process');
const process = require('process');

const exts = [ 'cpp', 'c', 'js', 'sh', 'py', 'rs' ];
const cmds = {
    'cpp': function(name) { return 'make && ./main'; },
    'c':   function(name) { return 'make && ./main'; },
    'js':  function(name) { return `node ${name}`; },
    'sh':  function(name) { return `bash ${name}`; },
    'py':  function(name) { return `python ${name}`; },
    'rs':  function(name) { return 'cargo run'; },
};

// Grab an array of items in the directory
let dir_items = execSync('ls').toString().split('\n');
dir_items = dir_items.slice(0, dir_items.length - 1); // remove empty newline

// Remove any directories from the array
let files = [];
for (let item of dir_items) {
    let str = execSync(`file ${item}`).toString();
    if (!str.match(/\sdirectory/)) {
        files.push(item);
    }
}

// Get number of files that have an extension
let files_with_exts = 0;
for (let file of files) {
    if (file.match(/[a-zA-Z0-9_-]+\.[a-zA-Z]+$/)) {
        files_with_exts++;
    }
}

for (let file of files) {
    if (file.match(/^main\..+/)) {
        // Found a 'main' with an extension
        let ext = file.substring(file.lastIndexOf('.') + 1, file.length);

        if (exts.indexOf(ext) != -1) {
            let cmd = cmds[ext](file);
            console.log(cmd);
        }
    }
    else if (file.match(/^main$/)) {
        // Found a 'main' without an extension
        console.log("Found a main (no ext):", file);
    }
}

