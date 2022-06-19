/*
 * Bench Dog
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
 *
 */

// Parameters
//------------------------------------------------------------------------------

$fn = $preview ? 15 : 90;

pegD = 19.9; // peg diameter
pegH = 17; // peg height (min 10)
pegT = 3; // peg thickness

type = "multi"; // square or round or multi
size = 30;
height = 10;

hole = true; // true or false
holeD = 8; // hole diameter

// Code
//------------------------------------------------------------------------------

difference() {
    union() {
        _peg();
        if (type == "multi") {
            _multi();
        }
        if (type == "round") {
            _round();
        }
        if (type == "square") {
            _square();
        }
    }
    // hole
    if (hole) {
        translate([0, 0, -(height)]) {
            cylinder(height + pegH, d1=holeD, d2=holeD, true);
        }
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// square type
module _square() {
    difference() {
        translate([0, 0, -(height / 2)]) {
            cube([size, size, height], true);
        }
    }
}

// round type
module _round() {
    translate([0, 0, -height]) {
        cylinder(height, d1=size, d2=size, true);
    }
}

// multi type
module _multi() {
    difference() {
        translate([(size * 0.2) / 2, 0, -(height / 2)]) {
            cube([size + (size * 0.2), size, height], true);
        }
        difference() {
            translate([0, 0, -(height / 2)]) {
                cube([size, size, height], true);
            }
            translate([0, 0, -height]) {
                cylinder(height, d1=size, d2=size, true);
            }
            translate([(size / 2), 0, -(height / 2)]) {
                cube([size, size, height], true);
            }
            translate([0, (size / 2), -(height / 2)]) {
                cube([size, size, height], true);
            }
        }
        translate([((size * sqrt(2) / 2) + (pegD / 2) + 2), 0, -(height / 2)]) {
            rotate([0, 0, 45]) {
                cube([size, size, height], true);
            }
        }
        translate([(pegD / 2) + 2 + ((size * 0.1) / 2), 0, -(height / 2)]) {
            cube([size * 0.14, size * 0.1, height], true);
        }
    }
}

// peg
module _peg() {
    difference() {
        // peg base
        union() {
            cylinder(pegH, d1=pegD, d2=pegD, false);

            // round end
            rotate_extrude() {
                translate([(pegD / 2) - (pegT / 2), pegH, 0]) {
                    circle(r = pegT / 2);
                }
            }

            // ring
            difference() {
                rotate_extrude() {
                    translate([(pegD / 2) - (pegT / 2 - 0.4), pegH - 2, 0]) {
                        circle(r = pegT / 2);
                    }
                }
                translate([0, 0, pegH]) {
                    cylinder(pegH, d1=pegD, d2=pegD, false);
                }
                translate([-(pegT + (pegD / 2)), 0, pegH]) {
                    cube([pegD, pegD + 2, pegH], true);
                }
                translate([pegT + (pegD / 2), 0, pegH]) {
                    cube([pegD, pegD + 2, pegH], true);
                }
            }
        }

        // hole
        translate([0, 0, 3]) {
            cylinder(
                pegH,
                d1 = pegD - (pegT * 2),
                d2 = pegD - (pegT * 2),
                false
            );
        }

        // cross
        crossSize = 2.5;
        translate([-(crossSize + (crossSize / 2)), 0, pegH]) {
            cube([crossSize, pegD + 2, pegH], true);
        }
        translate([crossSize + (crossSize / 2), 0, pegH]) {
            cube([crossSize, pegD + 2, pegH], true);
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
