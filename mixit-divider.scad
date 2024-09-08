/*
 * Mixit Box Divider
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

$fn = $preview ? 30 : 90;

height = 70;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

wallThickness = 0.86; // ideal for 0.4 nozzle
innerD = 99;

// Code
//------------------------------------------------------------------------------

wallThicknessD = wallThickness * 2;

difference() {
    cylinder(
        h = height,
        d1 = innerD - wallThicknessD,
        d2 = innerD - wallThicknessD
    );
    linear_extrude(height = height) {
        offset(3) {
            difference() {
                circle(d = innerD);
                for (a = [1:3]) {
                    rotate([0, 0, 60 * a]) {
                        square([10, innerD], true);
                    }
                }
            }
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
