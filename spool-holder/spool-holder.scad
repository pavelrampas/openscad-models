/*
 * Prusament Spool Holder (parametric)
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

length = 100; // length between bearings center
height = 3;
margin = 2;

spool = 199; // spool diameter

bearingOuter = 22; // bearing outer diameter
bearingInner = 8.1; // bearing inner diameter
bearingWidth = 7;

bearingPad = 0.4; // space between bearing and holder

boltD = 3.2; // bolt diameter
boltHead = 3.5; // bolt head height
boltHeadD = 5.7; // bolt head diameter

nutHeight = 3;
nutWidth = 6.5;

enableFeet = true; // true or false

// Code
//------------------------------------------------------------------------------

// spool test
translate([
    length / 2,
    _pythagorasB(((bearingOuter / 2) + (spool / 2)), length / 2),
    height + bearingPad
]) {
    %cylinder(h = 2, d1 = spool, d2 = spool);
}
// bearings test
translate([0, 0, height + bearingPad]) {
    %cylinder(h = bearingWidth, d1 = bearingOuter, d2 = bearingOuter);
}
translate([length, 0, height + bearingPad]) {
    %cylinder(h = bearingWidth, d1 = bearingOuter, d2 = bearingOuter);
}

bearingR = (bearingOuter + (margin * 2)) / 2;
h = _pythagorasB(bearingR + (spool / 2), length / 2);
angleSin = h / (bearingR + (spool / 2));

// model
difference() {
    _3d_basis();

    // bolt holes
    _bolt_hole();
    translate([length, 0, 0]) {
        _bolt_hole();
    }

    // bolt head hole
    cylinder(
        h = boltHead,
        d1 = boltHeadD,
        d2 = boltHeadD
    );

    // nut hole
    translate([length, 0, 0]) {
        cylinder(
            h = nutHeight,
            d1 = nutWidth,
            d2 = nutWidth,
            $fn=6
        );
    }
}

// Functions
//------------------------------------------------------------------------------

function _pythagorasB(c, a) = sqrt(pow(c, 2) - pow(a, 2));

// Modules
//------------------------------------------------------------------------------

// 2d basis
module _2d_basis() {
    difference() {
        union() {
            // ends bearing circle
            circle(r = bearingR);
            translate([length, 0, 0]) {
                circle(r = bearingR);
            }
            // middle
            translate([0, -bearingR, 0]) {
                square([length, (angleSin * bearingR) + bearingR]);
            }
        }
        // spool circle
        translate([length / 2, h, 0]) {
            circle(d = spool, $fn=900);
        }
        // middle holes
        offset(r = 1) {
            intersection() {
                difference() {
                    translate([bearingR, -bearingR, 0]) {
                        square([length - bearingR * 2, bearingR * 2]);
                    }
                    translate([length / 2, h - 3.5, 0]) {
                        circle(d = spool, $fn=900);
                    }
                    translate([(length / 2) - 2.5, -bearingR, 0]) {
                        square([5, bearingR * 2]);
                    }
                }
                translate([length / 2, (spool / 2) - (bearingR - 3.5), 0]) {
                    circle(d = spool, $fn=900);
                }
            }
        }
        // rails holes
        offset(r = 1) {
            translate([bearingR, -bearingR, 0]) {
                _rail_hole();
            }
            translate([length - bearingR, -bearingR, 0]) {
                _rail_hole();
            }
        }
    }
}

// 3d basis
module _3d_basis() {
    // basis
    linear_extrude(height = height) {
        _2d_basis();
    }

    // bearing pad
    _bearing_pad();
    translate([length, 0, 0]) {
        _bearing_pad();
    }

    // bearing middle
    _bearing_middle();
    translate([length, 0, 0]) {
        _bearing_middle();
    }

    // feet
    if (enableFeet) {
        hull(){
            translate([0 + bearingR + 9, 1.5 - bearingR, 0]) {
                cylinder(height + (bearingWidth / 2) - 0.5, 1.5, 1.5);
            }
            translate([length - bearingR - 9, 1.5 - bearingR, 0]) {
                cylinder(height + (bearingWidth / 2) - 0.5, 1.5, 1.5);
            }
        }
    }
}

module _bearing_middle() {
    cylinder(
        h = (bearingWidth - 1) / 2 + bearingPad + height,
        d1 = bearingInner,
        d2 = bearingInner
    );
}

module _bearing_pad() {
    cylinder(
        h = height + bearingPad,
        d1 = bearingInner + 2,
        d2 = bearingInner + 2
    );
}

module _rail_hole() {
    polygon([[-0.5, 0], [0.5, 0], [2, 2.5], [-2, 2.5]]);
}

module _bolt_hole() {
    cylinder(
        h = bearingWidth + height,
        d1 = boltD,
        d2 = boltD
    );
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
