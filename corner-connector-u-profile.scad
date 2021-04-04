/*
 * Corner Connector U-Profile (parametric)
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

sizeA = 15; // profile size A (width)
sizeB = 15; // profile size B (height)

thickness = 0.86; // print wall thickness
height = 0.8; // print bottom part height

length = 50; // length to angle centre

holeDiameter = 2; // holes diameter
holeSpace = 11; // space between holes

cutCorner = true; // cut corner ("true" or "false")

supportingCorner = false; // enable supporting corner ("true" or "false")
cornerHoleDiameter = 3; // hole diameter in supporting corner

// Code
//------------------------------------------------------------------------------

// u-profile with or without corner
if (cutCorner) {
    difference() {
        _profileWithHoles();
        _cornerCube();
        translate([0, 0, height]) {
            cube([sizeA + thickness, sizeA + thickness, sizeB], center = false);
        }
    }

} else  {
    _profileWithHoles();
}

// supporting corner
if (supportingCorner) {
    difference() {
        // corner
        translate(
            [(sizeA * 2) + (2 * thickness), (sizeA * 2) + (2 * thickness), 0]
        ) {
            rotate(a = [0, 0, 180]) {
                difference() {
                    cube(
                        [sizeA + thickness, sizeA + thickness, height],
                        center = false
                    );
                    _cornerCube();
                }
            }
        }
        // hole
        holePosition = sizeA + (2 * thickness) + (sizeA / 3.5);
        translate([holePosition, holePosition, -1]) {
            cylinder(
                h = height + 2,
                d1 = cornerHoleDiameter,
                d2 = cornerHoleDiameter,
                center=false
            );
        }
    }
}

// Functions
//------------------------------------------------------------------------------


// Modules
//------------------------------------------------------------------------------

// u-profile with holes
module _profileWithHoles() {
    difference() {
        _profile();
        _holes();
        translate([sizeA + (2 * thickness), 0, 0]) {
            rotate(a = [0, 0, 90]) {
                _holes();
            }
        }
    }
}

// holes
module _holes() {
    holesStartAt = (sizeA + (2 * thickness) + (sizeA / 1.5));
    holeWithSpace = holeSpace + holeDiameter;
    holes = floor(((length + holeSpace) - holesStartAt) / holeWithSpace) - 1;
    for (i = [0 : holes]) {
        translate([
            holesStartAt + (holeWithSpace * i),
            (sizeA + (2 * thickness)) / 2,
            -1
        ]) {
            cylinder(
                h=height + 2,
                d1=holeDiameter,
                d2=holeDiameter,
                center=false
            );
        }
    }
}

// u-profile
module _profile() {
    difference() {
        union() {
            // x-axis
            cube(
                [length, sizeA + (2 * thickness), height + (sizeB / 2)],
                center = false
            );
            // y-axis
            cube(
                [sizeA + (2 * thickness), length, height + (sizeB / 2)],
                center = false
            );
        }

        union() {
            // x-axis
            translate([thickness, thickness, height]) {
                cube(
                    [length + 1, sizeA, sizeB],
                    center = false
                );
            }
            // y-axis
            translate([thickness, thickness, height]) {
                cube(
                    [sizeA, length + 1, sizeB],
                    center = false
                );
            }
        }
    }
}

// cube to cut corner
module _cornerCube() {
    rotate(a = [0, 0, 45]) {
        cube(sqrt(pow(sizeA + thickness, 2) * 2), center = true);
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
