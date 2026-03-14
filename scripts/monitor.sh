#!/bin/bash
# Used to debug QS's memory usage
# There is probably a better way to do this
watch -n1 "ps -C qs -o rss= | awk '{printf \"%.2f MB\n\", \$1/1024}'"