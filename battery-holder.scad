/*
 * Battery Holder
 *
 * Author: Pavel Rampas
 * Version: 1.0.0 (Changelog is at the bottom)
 * License: CC BY-SA 4.0 [https://creativecommons.org/licenses/by-sa/4.0/]
 * Link: https://github.com/pavelrampas/openscad-models
 *
 * OpenSCAD version: 2019.05
 *
 * Instructions:
 * Set up parameters, render and print.
 *
 * Height is layer.
 * Thickness is perimeter.
 *
 *
 *
 * Remixed from:
 *
 * Vase Mode Battery Holder - 16xAA or 16xAAA
 * Author: Fredslund
 * Instagram: fredslund3d
 * https://www.prusaprinters.org/cs/prints/30472-vase-mode-battery-holder-16xaa-or-16xaaa
 */

// Parameters
//------------------------------------------------------------------------------

$fn = $preview ? 15 : 90;

batteryD = 14.7; // battery diameter

height = 16;
baseHeight = 0.8;
wallThickness = 0.4; // nozzle size
space = 2;

columns = 5;
lines = 3;

// Code
//------------------------------------------------------------------------------

wall = wallThickness * 2;

// base part
linear_extrude(baseHeight) {
    offset(r = (batteryD + wall) / 2) {
        square([
            (lines - 1) * (batteryD + wall + space),
            (columns - 1) * (batteryD + wall + space)
        ]);
    }
}

// batteries part
// columns y
for (y = [0:columns - 1]) {
    // lines x
    for (x = [0:lines - 1]) {
        translate([
            x * (batteryD + wall + space),
            y * (batteryD + wall + space),
            baseHeight
        ]) {
            _battery(height);

            // connect lines x
            if (x < lines - 1) {
                translate([0, -1, 0]) {
                    cube([batteryD + wall, 2, height]);
                }
            }

            // connect columns x
            if ((_isOdd(y + 1) && x == 0 && y < columns - 1) ||
                (!_isOdd(y + 1) && x == lines - 1 && y < columns - 1)
            ) {
                translate([-1, 0, 0]) {
                    cube([2, batteryD + wall, height]);
                }
            }
        }
    }
}

// Functions
//------------------------------------------------------------------------------

function _isOdd(x) = (x % 2) == 1;

// Modules
//------------------------------------------------------------------------------

// battery with wall around
module _battery(height) {
    cylinder(
        height,
        d1=batteryD + wall,
        d2=batteryD + wall,
        false
    );
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
