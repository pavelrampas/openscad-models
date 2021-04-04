/*
 * Prusament Spool Holder Rail
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
 */

// Parameters
//------------------------------------------------------------------------------

$fn = $preview ? 15 : 90;

bottomThickness = 8;
bottomHeight = 2;

teethThickness = 2;
teethHeight = bottomHeight + 3;

width = 86; // petg 86, pla 83
length = 52 + bottomThickness;

holderWidth = 14.2;
holderRailHoleSize = 4;

holeD = 3.3;

// Code
//------------------------------------------------------------------------------

difference() {
    _rail();
    translate([bottomThickness / 2, width / 2, 0]) {
        cylinder(h = bottomHeight, d = holeD);
    }
}
translate([length, 0, 0]) {
    difference() {
        _rail(false);
        translate([bottomThickness / 2, width / 2, 0]) {
            cylinder(h = bottomHeight, d = holeD);
        }
    }
}

translate([0, holderWidth + (2 * teethThickness), 0]) {
    cube([length, bottomThickness, bottomHeight], false);
}

translate(
    [0, width - holderWidth - (2 * teethThickness) - bottomThickness, 0]
) {
    cube([length, bottomThickness, bottomHeight], false);
}

// Functions
//------------------------------------------------------------------------------


// Modules
//------------------------------------------------------------------------------

module _rail(holder = true) {
    // bottom
    cube([bottomThickness, width, bottomHeight], false);

    // teeth
    cube([bottomThickness, teethThickness, teethHeight], false);
    translate([0, holderWidth + teethThickness, 0]) {
        cube([bottomThickness, teethThickness, teethHeight], false);
    }
    translate([0, width - holderWidth - (2 * teethThickness), 0]) {
        cube([bottomThickness, teethThickness, teethHeight], false);
    }
    translate([0, width - teethThickness, 0]) {
        cube([bottomThickness, teethThickness, teethHeight], false);
    }

    // holder
    if (holder) {
        translate([0, teethThickness, 0]) {
            cube([holderRailHoleSize, holderWidth, teethHeight], false);
        }
        translate([0, width - holderWidth - teethThickness, 0]) {
            cube([holderRailHoleSize, holderWidth, teethHeight], false);
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.1.0]:
// Move holes to the center.

// [1.0.0]:
// Initial release.
