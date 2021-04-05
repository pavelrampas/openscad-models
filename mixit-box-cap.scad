/*
 * Mixit Box Cap
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

$fn = $preview ? 30 : 90;

baseHeight = 0.8;
wallThickness = 0.86; // ideal for 0.4 nozzle

outerD = 102;
innerD = 99;

infill = "star"; // (empty, full, star)

// Code
//------------------------------------------------------------------------------

wallThicknessD = wallThickness * 2;

difference() {
    union() {
        cylinder(h = baseHeight, d1 = outerD, d2 = outerD);
        cylinder(h = baseHeight + 4, d1 = innerD, d2 = innerD);
    }
    translate([0, 0, baseHeight]) {
        cylinder(
            h = baseHeight + 5,
            d1 = innerD - wallThicknessD,
            d2 = innerD - wallThicknessD
        );
    }
    if(infill == "empty") {
        cylinder(
            h = baseHeight + 5,
            d1 = innerD - wallThicknessD - 4,
            d2 = innerD - wallThicknessD - 4
        );
    }
    if(infill == "star") {
        linear_extrude(height = baseHeight) {
            offset(3) {
                difference() {
                    circle(d = innerD - wallThicknessD - 10);
                    for (a = [1:3]) {
                        rotate([0, 0, 60 * a]) {
                            square([10, innerD], true);
                        }
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
