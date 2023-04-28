/*
 * Vitavia Target Greenhouse Panes Holder 1303
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

thickness = 0.88;
height = 30;

sizeA = 4;
sizeB = 3.5;
sizeC = 7.8;
sizeD = 5.6;
sizeE = 5.8;

// Code
//------------------------------------------------------------------------------

cube([thickness, sizeA, height]);

cube([sizeB, thickness, height]);

translate([sizeB - thickness, 0, 0]) {
    cube([thickness, sizeC, height]);
}

translate([sizeB - thickness, sizeC - thickness, 0]) {
    cube([sizeD, thickness, height]);
}

translate([(sizeB + sizeD) - (2 * thickness), sizeC - sizeE, 0]) {
    cube([thickness, sizeE, height]);
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
