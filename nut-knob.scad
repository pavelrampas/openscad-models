/*
 * Nut Knob
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

height = 10;
boltD = 3.2; // bolt diameter M3
nutHeight = 3; // M3
nutWidth = 6.5; // M3

surfaceCylinderNumber = 11;

// Code
//------------------------------------------------------------------------------

rotate([180, 0, 0]) {
    difference() {
        union() {
            // center
            cylinder(h = height, d1 = nutWidth + 4, d2 = nutWidth + 4);
            // surface
            for (i = [0:(surfaceCylinderNumber - 1)]) {
                rotate([0, 0, 360 / surfaceCylinderNumber * i]) {
                    translate([((nutWidth + 4) / 2) - 0.5, 0, 0]) {
                        cylinder(h = height, d1 = 3, d2 = 3);
                    }
                }
            }
        }
        _bolt_hole();
        _nut_hole();
    }
}


// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// bolt hole
module _bolt_hole() {
    cylinder(h = height, d1 = boltD, d2 = boltD);
}

// nut hole
module _nut_hole() {
    cylinder(h = nutHeight, d1 = nutWidth, d2 = nutWidth, $fn=6);
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
