local baton = require 'libraries.baton'

Bindings = baton.new {
    controls = {
        up     = {'key:w', 'key:up',    'button:dpup',    'axis:lefty-', 'wheel:y+'},
        down   = {'key:s', 'key:down',  'button:dpdown',  'axis:lefty+', 'wheel:y-'},
        left   = {'key:a', 'key:left',  'button:dpleft',  'axis:leftx-', 'wheel:x-'},
        right  = {'key:d', 'key:right', 'button:dpright', 'axis:leftx+', 'wheel:x+'},

        a = {'key:e', 'button:a', 'mouse:1', 'key:space',  'key:return'},    -- jump
        b = {'key:q', 'button:b', 'mouse:2', 'key:backspace'},               -- attack
        x = {'key:f', 'button:x', 'mouse:3', 'key:tab'},                     -- projectile
        y = {'key:c', 'button:y'},                                           -- defend

        pause = {'key:escape', 'button:start'}
    },
    pairs = {
        move = {'left', 'right', 'up', 'down'}
    },
    joystick = love.joystick.getJoysticks()[1],
}
