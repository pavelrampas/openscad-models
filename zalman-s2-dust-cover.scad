/*
 * Zalman S2 Dust Cover
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

height = 1;
cornerR = 8;
width = 144;
length = 264;

teethNumber = 10;
teethLength = 20;
teethHeight = 0.4;

// Code
//------------------------------------------------------------------------------

// first
_half_part(true);

//second
translate([width + 50, 0, 0]) {
    _half_part(false);
}

// Functions
//------------------------------------------------------------------------------

function _isOdd(x) = (x % 2) == 1;

// Modules
//------------------------------------------------------------------------------

module _half_part(teethLeft) {
    difference() {
        hull() {
            cylinder(h = height, r1 = cornerR, r2 = cornerR);
            translate([width - (2 * cornerR), 0, 0]) {
                cylinder(h = height, r1 = cornerR, r2 = cornerR);
            }
            translate([-cornerR, (length / 2) - (1 + cornerR), 0]) {
                cube([width, 1, height]);
            }
        }
        for(i = [0 : teethNumber - 1]) {
            translate([
                (i * width / teethNumber ) + (-cornerR),
                (length / 2) - (cornerR + teethLength),
                1 - teethHeight
            ]) {
                if (_isOdd(i) == teethLeft) {
                    cube([width / teethNumber, teethLength, teethHeight]);
                }
            }
        }
    }
    for(i = [0 : teethNumber - 1]) {
        translate([
            (i * width / teethNumber ) + (-cornerR),
            (length / 2) - cornerR,
            0
        ]) {
            if (_isOdd(i) != teethLeft) {
                cube([width / teethNumber, teethLength, teethHeight]);
            }
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
