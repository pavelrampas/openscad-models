/*
 * Race track support
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

part = "column"; // column or base

// column parameters
height = 20;

topDiameter = 13.2;
topThickness = 0.86;
topCutSize = 1.9;

bottomDiameter = 18;
bottomHeight = 14;

holeHeight = 10;

// base parameters
baseHeight = 9;

baseTopDiameter = topDiameter;
baseTopThickness = topThickness;
baseTopCutThickness = topCutSize;

baseBottomDiameter = 36;
baseBottomHeight = 3;

// Code
//------------------------------------------------------------------------------

if (part == "column") {
    difference() {
        union() {
            cylinder(h = height, d = topDiameter);
            cylinder(h = bottomHeight, d = bottomDiameter);
        }
        cylinder(h = height, d = topDiameter - (2 * topThickness));
        cylinder(h = holeHeight, d = topDiameter);
        translate([-(topCutSize / 2), -(bottomDiameter / 2), bottomHeight + 1]) {
            cube([topCutSize, bottomDiameter, height]);
        }
    }
}

if (part == "base") {
    difference() {
        union() {
            cylinder(h = baseHeight, d = baseTopDiameter);
            cylinder(h = baseBottomHeight, d = baseBottomDiameter);
        }
        cylinder(h = baseHeight, d = topDiameter - (2 * topThickness));
        translate([
            -(baseTopCutThickness / 2),
            -(baseBottomDiameter / 2),
            baseBottomHeight + 1
        ]) {
            cube([baseTopCutThickness, baseBottomDiameter, baseHeight]);
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
