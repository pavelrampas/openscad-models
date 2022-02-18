/*
 * SD Card Holder
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

sdNumber = 12; // even number
sdWidth = 24.5;
sdThickness = 2.4;

thickness = 3; // space between cards
baseHeight = 0.4; // height under cards
height = 9; // height around cards

dispersion = 6;

// Code
//------------------------------------------------------------------------------

difference() {
    _base();

    for (i = [0:((sdNumber / 2) - 1)]) {
        // left line
        translate([i * ((sdThickness + thickness) * 2), 0, baseHeight]) {
            _sd_card();
        }

        // right line
        translate([
            (i * ((sdThickness + thickness) * 2)) + (sdThickness + thickness),
            dispersion,
            baseHeight
        ]) {
            _sd_card();
        }
    }

    // center space
    translate([0, dispersion + 2, baseHeight]) {
        cube([
            ((sdThickness + thickness) * sdNumber) - thickness,
            sdWidth - (dispersion + 4),
            baseHeight + height
        ]);
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

module _sd_card() {
    cube([sdThickness, sdWidth, height + 10]);
}

module _base() {
    linear_extrude(baseHeight + height) {
        offset(r = 3) {
            square([
                ((sdThickness + thickness) * sdNumber) - thickness,
                sdWidth + dispersion
            ]);
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
