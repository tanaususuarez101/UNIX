#! /bin/bash

chmod u+x /snapshot/compare_snapshot.sh /snapshot/snapshot.sh
59 23 * * 1 /snapshot/compare_snapshot.sh
/snapshot/snapshot.sh