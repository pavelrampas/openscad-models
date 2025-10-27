/*
 * Shelf Brackets (parametric)
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
 */

// Parameters
//------------------------------------------------------------------------------

$fn = $preview ? 15 : 90;

shelves = 3; // number of shelves
shelvesThickness = 5;

space = 50; // space between shelves
bottomSpace = 15; // space under bottom shelf

height = 8;
width = 160;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

groove = 5;

holeD = space - 10; // hole diameter
holeSpace = 5; // space between hole and shelf
holeSpaceSide = 15;

length = (shelves * shelvesThickness) + bottomSpace + (space * (shelves - 1)) + 5;

// Code
//------------------------------------------------------------------------------

difference() {
    // base
    cube([width, length, height]);

    translate([0, bottomSpace, 0]) {
        for (i = [0 : 1 : shelves - 1]) {
            // groove
            translate([0, i * (space + shelvesThickness), height - groove]) {
                cube([width, shelvesThickness, groove]);
            }

            // hole side
            translate([
                (holeD / 2) + holeSpaceSide,
                ((i + 1) * (shelvesThickness + space)) - (space / 2),
                0
            ]) {
                cylinder(h = height, d1 = holeD, d2 = holeD);
            }

            // hole side
            translate([
                width - ((holeD / 2) + holeSpaceSide),
                ((i + 1) * (shelvesThickness + space)) - (space / 2),
                0
            ]) {
                cylinder(h = height, d1 = holeD, d2 = holeD);
            }

            // hole center
            translate([
                (holeD / 2) + holeSpaceSide,
                i * (space + shelvesThickness) + (shelvesThickness + holeSpace),
                0
            ]) {
                cube([width - (holeSpaceSide * 2) - holeD, holeD, height]);
            }
        }
    }

    // hole bottom
    // hole side
    translate([
        (holeD / 2) + holeSpaceSide,
        bottomSpace - (holeSpace + (holeD / 2)),
        0
    ]) {
        cylinder(h = height, d1 = holeD, d2 = holeD);
    }

    // hole side
    translate([
        width - ((holeD / 2) + holeSpaceSide),
        bottomSpace - (holeSpace + (holeD / 2)),
        0
    ]) {
        cylinder(h = height, d1 = holeD, d2 = holeD);
    }

    // hole center
    translate([
        (holeD / 2) + holeSpaceSide,
        bottomSpace - (holeSpace + holeD),
        0
    ]) {
        cube([width - (holeSpaceSide * 2) - holeD, holeD, height]);
    }
}

// holder
translate([width / 2, bottomSpace - holeSpace, height]) {
    for (i = [0 : 1 : shelves - 1]) {
        translate([0, i * (space + shelvesThickness), 0]) {
            rotate([-90, 0, 0]) {
                difference() {
                    cylinder(h = holeSpace, d1 = holeD, d2 = holeD);
                    translate([-(holeD / 2), 0, 0]) {
                        cube([holeD, holeD, holeSpace]);
                    }
                    translate([0, -5, 0]) {
                        cylinder(h = holeSpace, d1 = 3.4, d2 = 3.4);
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
