/*
 * Kovona Drumy Shelf Support Peg
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

// Code
//------------------------------------------------------------------------------

difference() {
    // cube
    cube([36, 36, 28], center = true);
    translate([3, 3, 3]) {
        cube([36, 36, 28], center = true);
    }

    // hole
    translate([0, -37/2, 0]) {
        rotate(a = [90, 0, 0]) {
            cylinder(h = 37, d1 = 6.8, d2 = 6.8, center = true);
        }
    }

    // hole
    translate([0, 2, 0]) {
        rotate(a = [90, 0, 0]) {
            cylinder(h = 36, d1 = 8.8, d2 = 8.8, center = true);
        }
    }

    // cut corner
    translate([33, 33, 0]) {
        rotate(a = [0, 0, 45]) {
            cube([100, 100, 100], center = true);
        }
    }

    // cut top
    translate([0, 0, 57]) {
        cube([100, 100, 100], center = true);
    }

    // cut walls
    translate([60, 0, 0]) {
        cube([100, 100, 100], center = true);
    }
    translate([0, 60, 0]) {
        cube( [100, 100, 100], center = true);
    }
}


// stump
translate([-37/2, 0, 0]) {
    rotate([0, 90, 0]) {
        cylinder(h = 6, d1 = 6.8, d2 = 6.8, center = true);
    }
}

// plug
translate([50, 0, 0]) {
    rotate([0, 0, 0]) {
        cylinder(h = 6, d1 = 6.8, d2 = 6.8, center = false);
    }
    rotate(a = [0, 0, 0]) {
        cylinder(h = 1, d1 = 8.7, d2 = 8.7, center = false);
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
