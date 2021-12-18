/*
 * Kovona Drumy Leg Cover
 *
 * Author: Pavel Rampas
 * Version: 1.0.0 (Changelog is at the bottom)
 * License: CC BY-SA 4.0 [https://creativecommons.org/licenses/by-sa/4.0/]
 * Link: https://github.com/pavelrampas/openscad-models
 *
 * OpenSCAD version: 2019.05
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

thickness = 1.2; // print wall thickness
height = 1.2; // print bottom part height

depth = 10;

length = 35; // drumy side length
width = 2.2; // drumy side width

// Code
//------------------------------------------------------------------------------

// drumy test
translate([thickness, thickness, height]) {
    %cube([length, width, 50]);
    %cube([width,length, 50]);
}

difference() {
    cube([length + thickness, length + thickness, depth]);

    // drumy
    translate([thickness, thickness, height]) {
        cube([length, width, 50]);
        cube([width, length, 50]);
    }

    // inner cube
    translate([width + (2 * thickness), width + (2 * thickness), height]) {
        cube([length + thickness, length + thickness, depth]);
    }

    // cut outer corner
    translate([0, 0, height]) {
        cube([10 + thickness, 10 + thickness, 15]);
    }

    // cut inner corner
    translate([length + 7, length + 7, 0]) {
        rotate(a = [0, 0, 45]) {
            cube([60, 60, 60], center = true);
        }
    }

    // hole
    translate([15, 15, 0]) {
        cylinder(h = height, r = 5, center = false);
    }

    // round outer corner
    difference() {
        cube([4, 4, height]);
        translate([4, 4, 0]) {
            cylinder(h = height, r = 4, center = false);
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
