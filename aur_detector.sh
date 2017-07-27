#!/bin/bash
#
# This script lists new orphaned AUR packages since it's last execution.
# Dependencies: coreutils grep cower

old_list=$HOME/.old-aur-orphaned.txt
new_list=$HOME/.new-aur-orphaned.txt

if [ ! -f ${old_list} ]; then
  echo "First run, creating initial list of orphaned packages."
  cower -qm "" | sort > ${old_list}
  exit 0
fi

echo "Creating list of current orphaned packages"
cower -qm "" | sort > ${new_list}
orphans=$(comm -13 ${old_list} ${new_list})

echo "Orphaned packages since last run:"
cower --color=always -i ${orphans} 2>/dev/null | grep -E "Name|Description"

mv ${new_list} ${old_list}
