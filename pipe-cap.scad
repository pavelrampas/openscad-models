/*
 * Pipe Cap
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

outerPipeDiameter = 40;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

thickness = 3;
height = 37; // min 5
capHeight = 2.8;
capDiameter = outerPipeDiameter + 8;

// Code
//------------------------------------------------------------------------------

rotate_extrude() {
    // cap
    square([capDiameter / 2, capHeight]);

    // pipe
    translate([(outerPipeDiameter / 2) - thickness, 0, 0]) {
        square([thickness, height - 5]);
    }

    // pipe end
    translate([(outerPipeDiameter / 2) - thickness, 0, 0]) {
        polygon([
            [0, height - 5],
            [0, height],
            [thickness / 2, height] ,
            [thickness, height - 5]
        ]);
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
