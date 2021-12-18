/*
 * Dodecahedron Star (parametric)
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

size = 20;
pointLength = 30;
print = "base"; // (base or point)

pegLength = 2;
pegRadius = 3;

// Code
//------------------------------------------------------------------------------

if(print == "base") {
    dodecahedron(size);

    cylinder(size + (2 * pegLength), pegRadius, pegRadius, true);
    for(i = [0:4]) {
        rotate([0, 0, 72 * i]) {
            rotate([116.565, 0, 0]) {
                cylinder(size + (2 * pegLength), pegRadius, pegRadius, true);
            }
        }
    }
}

if(print == "point") {
    difference() {
        linear_extrude(pointLength, center = false, scale=[0,0]) {
            difference() {
                square(size, center = true);
                projection() {
                    difference() {
                        translate([0, 0, 0.1]) {
                            cube([size, size, 0.2], true);
                        }
                        translate([0, 0, size / 2]) {
                            dodecahedron(size);
                        }
                    }
                }
            }
        }
        translate([0, 0, pegLength / 2]) {
            cylinder(pegLength, pegRadius, pegRadius, true);
        }
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// dodecahedron
module dodecahedron(size) {
    intersection() {
        cube([2 * size, 2 * size, size], center = true);
        intersection_for(i = [0:4]) {
            rotate([0, 0, 72 * i]) {
                rotate([116.565, 0, 0]) {
                    cube([2 * size, 2 * size, size], center = true);
                }
            }
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
