/*
 * Plunge Router Ruler (Bosch POF 1400 ACE)
 *
 * Author: Pavel Rampas
 * Version: 1.1.0 (Changelog is at the bottom)
 * License: CC BY-SA 4.0 [https://creativecommons.org/licenses/by-sa/4.0/]
 * Link: https://github.com/pavelrampas/openscad-models
 *
 * OpenSCAD version: 2021.01
 *
 * Instructions:
 * Set up parameters, render and print.
 *
 * Height is layer.
 * Thickness is perimeter.
 */

// Parameters
//------------------------------------------------------------------------------

$fn = $preview ? 15 : 90;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

thickness = 1.67;

height = 24;
width = 130;
length = 150; // divisible by 10

lineX = 10;
lineXMedium = 12;
lineXLarge = 15;
lineY = 0.28;
lineZ = 0.4;
lineMarginTop = 3;

fontSize = 4;
fontMarginTop = 3;

plugD = 4;

holeMargin = 20;

// Code
//------------------------------------------------------------------------------

difference() {
    cube([width, length, height]);

    // Text
    for (i = [1 : 1 : (length - 1) / 10]) {
        translate([
            (fontSize + fontMarginTop) * 2,
            (i * 10) - (fontSize / 2) + lineY,
            height - lineZ]
        ) {
            rotate([0, 0, 90]) {
                linear_extrude(lineZ) {
                    text(str(i), size = fontSize);
                }
            }
        }
        translate([
            fontSize + fontMarginTop,
            (i * 10) - (fontSize / 2) + lineY,
            height - lineZ]
        ) {
            rotate([0, 0, 90]) {
                linear_extrude(lineZ) {
                    text(str((length / 10) - i), size = fontSize);
                }
            }
        }
    }

    // Ruler
    for (i = [1 : 1 : length - 1]) {
        translate([
            (fontSize + fontMarginTop) * 2 + lineMarginTop,
            i - (lineY / 2),
            height - lineZ
        ]) {
            if (_isTen(i)) {
                cube([lineXLarge, lineY, lineZ]);
            } else if (_isFive(i)) {
                translate([lineXLarge - lineXMedium, 0, 0]) {
                    cube([lineXMedium, lineY, lineZ]);
                }
            } else {
                translate([lineXLarge - lineX, 0, 0]) {
                    cube([lineX, lineY, lineZ]);
                }
            }
        }
    }

    // Hole to reduce material cost
    rulerSpace = (fontMarginTop + fontSize) * 2 + lineMarginTop + lineXLarge + 10;
    translate([rulerSpace, 20, 0]) {
        cube([
            width - (rulerSpace + holeMargin),
            length - (holeMargin * 2),
            height
        ]);
    }
}

// Plugs left
translate([60, 0, height - 11.5]) {
    rotate([90, 0, 0]) {
        cylinder(h = 8, d1 = plugD, d2 = plugD);
        translate([60, 0, 0]) {
            cylinder(h = 8, d1 = plugD, d2 = plugD);
        }
    }
}
// Plugs right
translate([60, length + 8, height - 11.5]) {
    rotate([90, 0, 0]) {
        cylinder(h = 8, d1 = plugD, d2 = plugD);
        translate([60, 0, 0]) {
            cylinder(h = 8, d1 = plugD, d2 = plugD);
        }
    }
}


// Functions
//------------------------------------------------------------------------------

function _isTen(x) = (x % 10) == 0;
function _isFive(x) = (x % 5) == 0;

// Modules
//------------------------------------------------------------------------------

// Changelog
//------------------------------------------------------------------------------

// [1.1.0]:
// Both side.

// [1.0.0]:
// Initial release.
