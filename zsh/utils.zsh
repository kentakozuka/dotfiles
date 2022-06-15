
#-----------------------------------------#
# gctx
#-----------------------------------------#
function gcloud-config-select() {
    local select=$(gcloud config configurations list --format='[no-heading]' | awk '{ print $1,$2,$3,$4 }' | column -t | fzf | awk '{ print $1 }')
    print -z gcloud config configurations activate ${select}
}
alias gctx="gcloud-config-select"

#-----------------------------------------#
# gc: checkout with inc search
#-----------------------------------------#
function peco-git-checkout () {
    local branch=$(git branch -a | peco | tr -d ' ')
    if [[ "$branch" =~ "remotes/" ]]; then
        local b=$(echo $branch | awk -F'/' '{for(i=3;i<NF;i++){printf("%s%s",$i,OFS="/")}print $NF}')
        print -z git checkout -b ${b} ${branch}
    else
        print -z git checkout ${branch}
    fi
    CURSOR=$#BUFFER
}
alias gc="peco-git-checkout"

#-----------------------------------------#
# ^g: pick branch with inc search
#-----------------------------------------#
function pick-git-branch {
    local picked=$(git branch | peco | tr -d ' ')
    BUFFER="${BUFFER}${picked}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N pick-git-branch
bindkey '^g' pick-git-branch

#-----------------------------------------#
# hs: inc search in command history
#-----------------------------------------#
function peco-history-selection() {
    print -z `\history -n 1 | tail -r | peco --layout bottom-up --prompt "[hs]"`
    CURSOR=$#BUFFER
}
alias hs="peco-history-selection"


#-----------------------------------------#
# conv-image: convert heic to jpg and remove exif
#-----------------------------------------#
function conv-image() {
    find . -name '*.heic' | xargs -IT basename T .heic | xargs -IT sips --setProperty format jpeg ./T.heic --out ./T.jpg;
    find . -name '*.HEIC' | xargs -IT basename T .HEIC | xargs -IT sips --setProperty format jpeg ./T.HEIC --out ./T.jpg;
    exiftool -all= -overwrite_original *.jpg
}
alias convimg="conv-image"
