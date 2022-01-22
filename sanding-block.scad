/*
 * Sanding Block
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

width = 20;
lengthUp = 50;
lengthDown = 100;
height = 10;

boltD = 3.2; // bolt diameter M3
boltHead = 3.5; // bolt head height M3
boltHeadD = 5.7; // bolt head diameter M3

nutHeight = 3; // M3
nutWidth = 6.5; // M3

offsetR = 2;

// Code
//------------------------------------------------------------------------------

// basis
difference() {
    rotate ([-90, 0, 0]) {
        linear_extrude(height = width) {
            _2d_basis();
        }
    }
    // holes
    translate([14 + (boltD / 2), width / 2, -(height + offsetR)]) {
        _bolt_hole();
        _nut_hole();
        _bolt_head_hole();
    }
    translate([lengthUp - (14 + (boltD / 2)), width / 2, -(height + offsetR)]) {
        _bolt_hole();
        _nut_hole();
        _bolt_head_hole();
    }
}

// holders
holderLengt = 12 + boltD + 3;
translate([0, width + 10, -(height + offsetR)]) {
    _holder();
}
translate([0, (width * 2) + 20, -(height + offsetR)]) {
    _holder();
}


// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// holder
module _holder() {
    difference() {
        // cube
        cube([holderLengt, width, 4]);
        // hole
        translate([10 + (boltD / 2) - 0.5, width / 2, 0]) {
            _bolt_hole();
        }
        // round corner
        translate([offsetR, 0, offsetR]) {
            difference() {
                translate([-offsetR, 0, 0]) {
                    cube([offsetR, width, offsetR]);
                }
                rotate ([-90, 0, 0]) {
                    cylinder(h = width, d1 = offsetR * 2, d2 = offsetR * 2);
                }
            }
        }
    }
}

// 2D basis
module _2d_basis() {
    offset(r = offsetR) {
        union() {
            _2d_basis_half();
            translate([lengthUp, 0]) {
                mirror([1, 0]) {
                    _2d_basis_half();
                }
            }
        }
    }
}

// 2D basis half
module _2d_basis_half() {
    difference() {
        union() {
            square([lengthUp / 2, height]);
            polygon([
                [0, 0], [0, height], [-(lengthDown - lengthUp) / 2, height]
            ]);
        }
        translate([offsetR, 0]) {
            square([lengthUp, 4]);
        }
    }
}

// bolt hole
module _bolt_hole() {
    cylinder(h = height * 2, d1 = boltD, d2 = boltD);
}

// bolt head hole
module _bolt_head_hole() {
    cylinder(h = boltHead, d1 = boltHeadD, d2 = boltHeadD);
}

// nut hole
module _nut_hole() {
    cylinder(h = nutHeight + boltHead, d1 = nutWidth, d2 = nutWidth, $fn=6);
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
