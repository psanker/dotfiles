#!/usr/bin/env bash

/usr/local/bin/tw_gcal_sync -c tw -t sync --google-secret ~/.local/share/task/tw-gcal-sync.json --prefer-scheduled-date
/usr/local/bin/tw_gcal_sync -c tw-home -t home --google-secret ~/.local/share/task/tw-gcal-sync.json --prefer-scheduled-date
/usr/local/bin/tw_gcal_sync -c tw-work -t work --google-secret ~/.local/share/task/tw-gcal-sync.json --prefer-scheduled-date
