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

length = 100;

// Code
//------------------------------------------------------------------------------

rotate([-90, 0, 0]) {
    difference() {
        union(){
            linear_extrude(height = length) {
                offset(r = 1) {
                    polygon([[-0.5, 0], [0.5, 0], [2, 2.5], [-2, 2.5]]);
                }
            }

            translate([0, -1, 0]) {
                linear_extrude(height = 2) {
                    offset(r = 2) {
                        polygon([[-0.5, 0], [0.5, 0], [2, 2.5], [-2, 2.5]]);
                    }
                }
            }
        }

        translate([0, -5, 50]) {
            cube([10, 10, length], true);
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
