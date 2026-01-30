#!/bin/bash

ps aux | grep -iE '.*[0-9] /opt/Citrix/.*' | awk '{print $2}' | xargs kill
