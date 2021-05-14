#!/bin/bash
k1="Subject"
k2="CommitDate"

# I just found that my script can ONLY get the penultimate commit message..

# I could just commit twice (the 2nd one is dummy message) to resolve this,
# although it's not elegant, this is probably the best I could think of while
# the built-in .GitInfo isn't working properly!

Subject=`git log -1 --format=%B $(pwd) | head -1`
CommitDate=`git log -1 --format=%cd $(pwd)`
output_file="`pwd -P`/data/MyGitInfo.json"

echo "{ \"${k1}\": \"${Subject}\" ,\"${k2}\": \"${CommitDate} CST\" }" > ${output_file}
