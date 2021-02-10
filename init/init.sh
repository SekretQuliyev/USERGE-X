#!/bin/bash
#
# Copyright (C) 2020 by UsergeTeam@Github, < https://github.com/UsergeTeam >.
#
# This file is part of < https://github.com/UsergeTeam/Userge > project,
# and is released under the "GNU v3.0 License Agreement".
# Please see < https://github.com/uaudith/Userge/blob/master/LICENSE >
#
# All rights reserved.

. init/logbot/logbot.sh
. init/utils.sh
. init/checks.sh

trap handleSigTerm TERM
trap handleSigInt INT

initUserge() {
    printLogo
    assertPrerequisites
    sendMessage "Initializing USERGE-X ..."
    assertEnvironment
    editLastMessage "Starting USERGE-X ..."
    printLine
}

startUserge() {
    startLogBotPolling
    runPythonModule graph "$@"
}

stopUserge() {
    sendMessage "Exiting USERGE-X ..."
    endLogBotPolling
    exit 0
}

handleSigTerm() {
    log "Exiting With SIGTERM (143) ..."
    stopUserge
    exit 143
}

handleSigInt() {
    log "Exiting With SIGINT (130) ..."
    stopUserge
    exit 130
}

runUserge() {
    initUserge
    startUserge "$@"
    stopUserge
}
