---
title: "Hugo Setup"
date: 2021-05-12T15:50:37+08:00
draft: false
---

### Preparation
- Download [*hugo*](https://gohugo.io)
    - The [binary](https://github.com/gohugoio/hugo/releases)
    - Move the binary into your existing `$PATH` or append your path to it
- Create [repositories](https://github.com/new)
    > To make things easy, make sure all the default branches are `master`
    - One for *storing the code* <small>(e.g. BLOG)</small>
    - One for *hosting* provided by Github Pages <small>(name: `GH_USERNAME.github.io`)</small>

### Basic Setup
- Linking your *code* repository with Github
    ```bash
    hugo new site           HUGO_LOCAL_DIRNAME_WHATEVER

    git remote add origin   https://github.com/GH_USERNAME/BLOG
    git push -u origin master
    ```
- Try it out
    ```bash
    hugo new posts/TITLE.md

    # assuming you want 'write -> build -> publish'
    # change 'draft: false' to 'draft: true' in the TITLE.md
    ```

### My Own Configuration
> the theme I'm using: [*yinyang*](https://github.com/joway/hugo-theme-yinyang)
1. Adding theme
    ```bash
    cd HUGO_LOCAL_DIRNAME_WHATEVER
    git clone https://github.com/joway/hugo-theme-yinyang themes/yinyang
    ```
2. Tweaking *hugo*
    ```toml
    languageCode = "en-us"
    title = "Hey there!"
    theme = "yinyang"
    enableEmoji = true                          # convert \:smile\: into emoji
    disableHugoGeneratorInject = true           # remove hugo from <meta>
    paginate = 25
    hasCJKLanguage = true
    ```
3. Tweaking *theme*
    ```toml
    [author]
        name = "Mensch"
        homepage = "https://codingezio.github.io/"

    [markup]
    [markup.goldmark]
    [markup.goldmark.renderer]
        unsafe = true
    [markup.highlight]
        guessSyntax = true
        tabWidth = 4

    [params]
        mainSections = ["posts"]
        headTitle = "Mensch"
    [[params.socials]]
        name = "About Me"
        link = "https://codingezio.github.io"
    [[params.socials]]
        name = "Github"
        link = "https://github.com/codingezio"
    ```

### Prepare for Deployment
- The repository for *hosting*
    ```bash
    # ROOT
    # - HUGO_LOCAL_DIRNAME_WHATEVER/    created by `hugo new site` and linked
    # - GH_USERNAME.github.io/          receive build files in the future
    git clone https://github.com/GH_USERNAME/GH_USERNAME.github.io


    # change config in HUGO_LOCAL_DIRNAME_WHATEVER/config.toml
    publishDir = "../codingezio.github.io"      # default: './public'


    # build
    hugo --buildDrafts
    ```
- Commit workflow
    ```bash
    # repo :: code
    hugo new posts/TITLE.md
    hugo --buildDrafts

    git add . && git commit -m "hmm"
    git push -u origin master


    # repo :: hosting
    git add . && git commit -m "hmm"
    git push -u origin master
    ```