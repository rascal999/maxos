#!/usr/bin/env bash

# Determine name of today's journal entry
DATE_JOURNAL=`date "+%Y_%m_%d"`

# Get file path of today's journal entry
JOURNAL_LOCATION="/home/user/Data/logseq/journals/${DATE_JOURNAL}.md"

# Make temp copy of journal entry
cp ${JOURNAL_LOCATION} ${JOURNAL_LOCATION}_tmp

# Get meetings (run script)
MEETINGS=`python logseq_calendar_today.py`

# Place script output in today's journal
awk -v insert="$MEETINGS" '
    BEGIN {found=0}
    {
        if (!found && /\*\*Meetings\*\*/) {
            print $0 "\n" insert;
            found=1;
        } else {
            print $0;
        }
    }
' "${JOURNAL_LOCATION}_tmp" > ${JOURNAL_LOCATION}

# Remove temp copy of journal entry
rm ${JOURNAL_LOCATION}_tmp

# Hash Jira codes
sed -i -E 's/ ([A-Z]{2,8}-[0-9]{1,8})/ #\1/g' ${JOURNAL_LOCATION}
