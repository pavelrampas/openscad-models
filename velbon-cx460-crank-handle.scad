/*
 * Velbon CX 460 Crank Handle
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

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

crankHeight = 11.8;
crankThickness = 6;

endDiamater = 7.5;
crankThicknessPlus = crankThickness + 1;

x = endDiamater;
y = 12 - (endDiamater / 2);
x2 = 36;
y2 = y + 15;

// Code
//------------------------------------------------------------------------------

//body
_body();
translate([0, 0, crankHeight]) {
    mirror([0, 0, 1]) {
        _body();
    }
}

// holder end
yMove = 28 - 5;
difference() {
    union() {
        translate([30, y2 + yMove, crankHeight / 2]) {
            rotate([0, 90, 0]) {
                cylinder(h = crankThickness, d = crankHeight);
            }
        }

        translate([x2, y2 + yMove, crankHeight / 2]) {
            rotate([0, 90, 0]) {
                cylinder(h = 10, d = 6.8);
            }
        }

        translate([x2 + 10, y2 + yMove, crankHeight / 2]) {
            rotate([0, 90, 0]) {
                cylinder(h = 5.5, d = 5.2);
            }
        }

        translate([x2 + 10 + 5.5, y2 + yMove, crankHeight / 2]) {
            rotate([0, 90, 0]) {
                cylinder(h = 2, d = 6.5);
            }
        }

        translate([x2 + 10 + 5.5 + 2, y2 + yMove, crankHeight / 2]) {
            rotate([0, 90, 0]) {
                cylinder(h = 2, d1 = 6.5, d2 = 5);
            }
        }
    }

    translate([x2 + 10, y2 + yMove - (1.5 / 2), 0]) {
        cube([20, 1.5, crankHeight]);
    }
}


// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

module _body() {
    difference() {
        linear_extrude(crankHeight / 2) {
            // end
            translate([endDiamater / 2, 0, 0]) {
                circle(d = endDiamater);
            }
            square([endDiamater, y]);

            // part a
            polygon(points=[
                [x, y - crankThicknessPlus],
                [x2, y2],
                [x2, y2 + crankThicknessPlus],
                [x, y]
            ]);

            // part b
            translate([36 - crankThickness, y2]) {
                square([crankThickness, 24]);
            }
        }

        // hole
        holeSize = 3.2;
        translate([0, -(endDiamater / 2), (crankHeight / 2) - (holeSize / 2)]) {
            cube([18, 40, holeSize]);
        }
    }

    // end pin
    difference() {
        translate([endDiamater / 2, 0, -2]) {
            cylinder(h = 2, d = 3);
        }
        translate([0, -1.2, -13.5]) {
            rotate([50, 0, 0]) {
                cube([10, 10, 10]);
            }
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
