#! /bin/bash



chmod u+x /snapshot/snapshotV2.sh /snapshot/compare_snapshotV2.sh
59 23 * * 1 /snapshot/compare_snapshotV2.sh
/snapshot/snapshotV2.sh