#!/bin/bash


function pagesplit() {
path=$1
export page=$(echo $path | awk -F'/' '{print $NF}')
export dir=$(echo $path | sed "s,/$page,,g")
}

function newpage() {
  target=${1}
  title=${2}
  cat <<EOF
  layout: page
  title: "${title}"
  permalink: /${target}/${title}

  # ${title}
EOF
}


case $1 in
  newpage)
    shift
    pagesplit $1
    if [ ! -f "${dir}/${page}.md" ]; then
      newpage ${dir} ${page} > ${dir}/${page}.md
    else
      echo "Page ${dir}/${page}.md already exists. Delete and try again"
      exit 1
    fi
    ;;
esac