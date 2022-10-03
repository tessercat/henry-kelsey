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
  introduction.md
echo Built "${OUTPUT}"