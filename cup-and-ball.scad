/*
 * Cup And Ball
 *
 * Author: Pavel Rampas
 * Version: 1.0.0 (Changelog is at the bottom)
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

ballDiamater = 16;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

thickness = 1.67;
height = 2 * ballDiamater;
topDiameter = ballDiamater + (2 * thickness) + 1.2;
bottomHeight = 1.2;

// Code
//------------------------------------------------------------------------------

// cup
difference() {
    // outer
    union() {
        translate([0, 0, height - (ballDiamater / 2)]) {
            cylinder(h = ballDiamater / 2, d = topDiameter);
        }

        cylinder(
            h = height - (ballDiamater / 2),
            d2 = topDiameter,
            d1 = topDiameter * 0.7
        );
    }

    // inner
    translate([0, 0, height - (ballDiamater / 2)]) {
            cylinder(h = ballDiamater / 2, d = topDiameter - (2 * thickness));
    }
    translate([0, 0, bottomHeight]) {
        cylinder(
            h = height - (ballDiamater / 2) - bottomHeight,
            d2 = topDiameter - (2 * thickness),
            d1 = (topDiameter * 0.7) - (2 * thickness)
        );
    }

    // hole
    cylinder(h = bottomHeight, d = 1.8);
}

// ball
translate([3 * ballDiamater, 0, 0]) {
    difference() {
        sphere(d = ballDiamater);

        // hole
        translate([0, 0, -ballDiamater / 2]) {
            cylinder(h = ballDiamater, d = 1.8);
        }

        translate([0, 0, -ballDiamater / 2]) {
            cylinder(h = 3, d = 4);
        }
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
