# VIM Marp v0.4.0

A simple presentation tool to present marp files from within vim

## Installation

Choose your preferred method of installation

## Getting Started

Open the marp markdown file and invoke `:MarpStart`, this starts the marp
presentation session. It will close all existing windows / tabs and save that
in a temporary session and open a new buffer to display the presentation page
content to remove distractions. Once your presentation is done, you can invoke
`:MarpStop` to end the presentation, this will restore your session as it was
before you started your presentation.

Alternatively you can also start presentation view with the `:MarpFileStart`
command giving the marp file as an input.

For more information please refer `:h marp`

## Contributing

### Reporting an Issue :

Use <a href="https://github.com/dhruvasagar/vim-marp/issues">Github Issue
Tracker</a>

### Contributing to code :

- Fork it.
- Commit your changes and give your commit message some love.
- Push to your fork on github.
- Open a Pull Request.

## Credits

This plugin was inspired by Marp (https://yhatt.github.io/marp/) and uses
compatible markdown files for presenting within vim.
