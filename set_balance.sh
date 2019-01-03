#!/usr/bin/env osascript
# Restore balance to 50/50 if it shifts for some reason

-- Check if output is muted
set isMuted to (output muted of (get volume settings))

-- Use the "reset volume" side effect to reset the output balance
set volume output volume (output volume of (get volume settings))

-- Restore muted output state
if (isMuted) is true then
	set volume with output muted
end if
