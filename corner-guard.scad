/*
 * Corner Guard
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

x = 20;
y = 20;
z = 20;
thickness = 10;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

// Code
//------------------------------------------------------------------------------

difference() {
    hull() {
        sphere(thickness / 2);
        translate([0, 0, z]) {
            sphere(thickness / 2);
        }
        translate([x, 0, 0]) {
            sphere(thickness / 2);
        }
        translate([0, y, 0]) {
            sphere(thickness / 2);
        }
    }

    cube([x + thickness, y + thickness, z + thickness]);
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
