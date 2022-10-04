# Build the ebook. Requires git and pandoc.

# Pre-process foreward template version.
if [[ -n $(git status -s) ]]; then
    COMMIT="#######"
    EPOCH=$(date +%s)
else
    COMMIT=$(git log -1 --format=%h)
    EPOCH=$(git log -1 --format=%ct)
    TAG=$(git describe --tags --candidates=0 $COMMIT 2>/dev/null)
    if [[ -n $TAG ]]; then
        COMMIT=$TAG
    fi
fi
DATE="@$EPOCH"
VERSION="Commit $COMMIT, $(date -d $DATE +'%B %d, %Y')."
sed "s/{{ version }}/$VERSION/g" foreward.tpl.md > foreward.md
echo "${VERSION}"

OUTPUT="TheKelseyPapers-${COMMIT}.epub"
pandoc \
    --output "${OUTPUT}" \
    --toc \
    --css style.css \
  meta.yaml \
  foreward.md \
  001.md \
  002.md \
  003.md \
  004.md \
  005.md \
  006.md \
  007.md \
  008.md \
  009.md \
  010.md \
  011.md \
  012.md \
  013.md \
  014.md \
  015.md \
  016.md \
  017.md \
  018.md \
  019.md \
  125.md \
  126.md \
  127.md \
  128.md \
  README.md
echo Built "${OUTPUT}"
