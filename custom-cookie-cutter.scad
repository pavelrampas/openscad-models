/*
 * Custom cookie cutter
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

resizeX = 50; // 0 means no change size
resizeY = 50;

height = 18;
thickness = 0.86; // wall thickness

topHeight = 3;
topThickness = 3;

// Code
//------------------------------------------------------------------------------

difference() {
    union() {
       _shape(resizeX, resizeY, topHeight, topThickness);
       _shape(resizeX, resizeY, height, thickness);
    }
    _shape(resizeX, resizeY, height, 0);
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// basic shape
module _shape(x, y, z, offset) {
    linear_extrude(z) {
        offset(offset) {
            resize([x, y, 0]) {
                import("cookie.svg");
            }
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
