/*
 * Replacement Clamp Pads Part A
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

clampCircleDiameter = 20.7; // small 20.7, large 19.2
clampCircleHeight = 1; // small 1, large 2

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

thickness = 1.67; // wall thickness
topHeight = 3;

ringHeight = 1;
ringThickness = 0.8;

// Code
//------------------------------------------------------------------------------

difference() {
    cylinder(
        h = 1 + clampCircleHeight + ringHeight + topHeight,
        d = clampCircleDiameter + (2 * thickness)
    );
    // clamp circle
    cylinder(h = 1 + clampCircleHeight + ringHeight, d = clampCircleDiameter);
}

difference() {
    cylinder(h = ringHeight, d = clampCircleDiameter + (2 * thickness));
    cylinder(h = ringHeight, d = clampCircleDiameter - ringThickness);
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
