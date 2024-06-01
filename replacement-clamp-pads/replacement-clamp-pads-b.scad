/*
 * Replacement Clamp Pads Part B
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

clampHeadWidth = 27.4; // small 27.4, large 32
clampHeadDepth = 19.2; // small 19.2, large 22.4
clampHeadHeight = 5; // small 5, large 6

holeSize = 8; // small 8, large 12

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

thickness = 1.67; // wall thickness
height = 3;

// Code
//------------------------------------------------------------------------------

difference() {
    cube([
        clampHeadDepth + (2 * thickness),
        clampHeadWidth + (2 * thickness),
        clampHeadHeight + height + 2
    ]);
    // clamp head
    translate([thickness, thickness, height]) {
        cube([clampHeadDepth, clampHeadWidth, clampHeadHeight]);
    }
    // hole
    translate([(thickness + clampHeadDepth / 2) - (holeSize / 2), 0, height]) {
        cube([holeSize, clampHeadWidth + thickness, clampHeadHeight + 2]);
    }
    translate([thickness + 3, 0, height]) {
        cube([clampHeadDepth - 6, thickness, clampHeadHeight + 2]);
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
