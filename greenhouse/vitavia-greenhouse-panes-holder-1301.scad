/*
 * Vitavia Target Greenhouse Panes Holder 1301
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

sizeA = 4.0;
sizeB = 3.5;
sizeC = 6;
sizeDX = 3.5;
sizeDY = 3;
sizeE = 9;
sizeF = 5.6;
sizeG = 7.8;

// Code
//------------------------------------------------------------------------------

cube([thickness, sizeA, height]);

cube([sizeB, thickness, height]);

translate([sizeB - thickness, 0, 0]) {
    cube([thickness, sizeC, height]);
}

compensation = 0.2;
cubePoints = [
  [sizeB - thickness, sizeC, 0],
  [sizeB, sizeC - compensation, 0],
  [(sizeB + sizeDX) - thickness, sizeC + sizeDY, 0],
  [(sizeB + sizeDX) - (2 * thickness), sizeC + sizeDY + compensation, 0],
  [sizeB - thickness, sizeC, height],
  [sizeB, sizeC - compensation, height],
  [(sizeB + sizeDX) - thickness, sizeC + sizeDY, height],
  [(sizeB + sizeDX) - (2 * thickness), sizeC + sizeDY + compensation, height]
];
cubeFaces = [
  [0,1,2,3],
  [4,5,1,0],
  [7,6,5,4],
  [5,6,2,1],
  [6,7,3,2],
  [7,4,0,3]
];
polyhedron( cubePoints, cubeFaces );

translate([(sizeB + sizeDX) - (2 * thickness), sizeC + sizeDY, 0]) {
    cube([thickness, sizeE, height]);
}

translate([
    (sizeB + sizeDX) - (2 * thickness),
    (sizeC + sizeE) - thickness + sizeDY,
    0
]) {
    cube([sizeF, thickness, height]);
}

translate([
    (sizeB + sizeDX + sizeF) - (3 * thickness),
    (sizeC + (sizeE - sizeG)) + sizeDY,
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
