/*
 * Vitavia Target Greenhouse Panes Holder 1302
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

sizeA = 9.8;
sizeB = 4.0;
sizeC = 9.8;
sizeD = 5.6;
sizeE = 7.8;
sizeF = 5.6;
sizeG = 7.8;

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

translate([(sizeB + sizeD) - (2 * thickness), sizeC - thickness, 0]) {
    cube([thickness, sizeE, height]);
}

translate([
    (sizeB + sizeD) - (2 * thickness),
    (sizeC + sizeE) - (thickness * 2),
    0
]) {
    cube([sizeF, thickness, height]);
}

translate([
    (sizeB + sizeD + sizeF) - (3 * thickness),
    (sizeC + (sizeE - sizeG)) - thickness,
    0
]) {
    cube([thickness, sizeG, height]);
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
