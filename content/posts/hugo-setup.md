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
    EnableGitInfo = true
    ```
3. Tweaking *theme* config
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
        name = "Github"
        link = "https://github.com/codingezio"
    [[params.socials]]
        name = "HOME"
        link = "https://codingezio.github.io"
    ```
4. Tweaking *theme* template
    - HTML: `HUGO/themes/THEME/layouts/_default/{list,single}.html`
        ```html
        <ul class="git-metainfo">
            <li>commit: {{ .GitInfo.Subject }}</li>
            <li>author: {{ .GitInfo.AuthorName }}</li>
            <li>datetm: {{ .GitInfo.CommitDate }}</li>
        </ul>
        ```
    - CSS: `HUGO/assets/CSS_FILE.css`


### Prepare for Deployment
- one more thing: if you wanna maintain the third-party themes by yourself
    ```bash
    # step1
    #   remove any .git folders under `themes/THEME/`
    #   remove any .gitignore   under `themes/THEME/`

    # step2
    #   git rm -rf --cached themes/THEME    # if your git can't find this dir!
    #   git add themes/THEME/
    ```
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
