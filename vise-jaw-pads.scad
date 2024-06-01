/*
 * Vise Jaw Pads
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

jawWidth = 101;
jawDepth = 12;
jawHeight = 22.2;

enableGroove = true;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

padDepth = 10;

grooveSize = 6;

holderThickness = 3;
holderHeight = 3;

// Code
//------------------------------------------------------------------------------

heightTotal = jawHeight + (2 * holderThickness);

difference() {
    // pad
    translate([0, jawDepth - holderHeight, -holderThickness]) {
        cube([
            jawWidth,
            padDepth + holderHeight,
            heightTotal
        ]);
    }

    // jaw
    #cube([jawWidth, jawDepth, jawHeight]);

    // grooves
    if(enableGroove) {
        translate([
            jawWidth / 2,
            padDepth + jawDepth,
            jawHeight / 2
        ]) {
            rotate([45, 0, 0]) {
                cube([jawWidth, grooveSize, grooveSize], true);
            }
        }

        translate([
            jawWidth / 2,
            padDepth + jawDepth,
            jawHeight / 2
        ]) {
            rotate([0, 0, 45]) {
                cube([grooveSize, grooveSize, heightTotal], true);
            }
        }

        translate([
            jawWidth - (grooveSize + 5),
            padDepth + jawDepth,
            jawHeight / 2
        ]) {
            rotate([0, 0, 45]) {
                cube([grooveSize, grooveSize, heightTotal], true);
            }
        }

        translate([
            grooveSize + 5,
            padDepth + jawDepth,
            jawHeight / 2
        ]) {
            rotate([0, 0, 45]) {
                cube([grooveSize, grooveSize, heightTotal], true);
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
