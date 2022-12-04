/*
 * Race track connecting part
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

height = 5;
endDiameter = 3.4;
width = 7;
length = 14.2;
thickness = 1.9;

// Code
//------------------------------------------------------------------------------

_half_part();
translate([0, length - thickness, 0]){
    mirror([0, 1, 0]) {
        _half_part();
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// half part of the model
module _half_part() {
    cylinder(h = height, d = endDiameter);
    translate([0, -(thickness / 2), 0]) {
        cube([width - (endDiameter / 2), thickness, height]);
    }
    translate([width - (endDiameter / 2) - thickness, -(thickness / 2), 0]) {
        cube([thickness, length / 2, height]);
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
