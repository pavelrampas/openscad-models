/*
 * Sonoff SNZB-02WD holder
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

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

thickness = 1.67;
height = 22 + 0.5;
width = 58.5 + 0.5;
length = 63;

holderLength = 20;
holderHoleSmall = 4;
holderHoleLarge = 8;

frontHole = width - 18;

backHoleD = 45;

// Code
//------------------------------------------------------------------------------

// Box
difference() {
    // Box
    linear_extrude(length + holderLength) {
        offset(r = thickness) {
            square([height, width]);
        }
    }

    // Sonoff
    translate([0, 0, thickness]) {
        cube([height, width, length + holderLength]);
        #cube([height, width, length]);
    }

    // Hole front
    translate([10, (width - frontHole) / 2, 0]) {
        linear_extrude(length + holderLength) {
            offset(r = thickness) {
                square([height, frontHole]);
            }
        }
    }

    // Hole back
    translate([-thickness, width / 2, length / 2]) {
        rotate([0, 90, 0]) {
            cylinder(h = height, d = backHoleD);
        }
    }

    // Hole holder
    translate([-thickness, 0, length + thickness + (holderHoleLarge / 2) + 2]) {
        translate([0, width / 2, 0]) {
            rotate([0, 90, 0]) {
                cylinder(h = thickness * 2, d = holderHoleLarge);
            }
        }
        translate([0, width / 2, 6]) {
            rotate([0, 90, 0]) {
                cylinder(h = thickness * 2, d = holderHoleSmall);
            }
        }
        translate([0, (width / 2) - 2, 0]) {
            cube([thickness * 2, holderHoleSmall, 6]);
        }
    }
    translate([0, width + thickness, length]) {
        rotate([90, 0, 0]) {
            linear_extrude(width + (2 * thickness)) {
                polygon([
                    [height + thickness, 0],
                    [height + thickness, holderLength],
                    [0, holderLength]
                ]);
            }
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
