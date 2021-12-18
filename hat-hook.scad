/*
 * Hat Hook
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

// circle
circleR = 50; // radius
circleH = 40; // height

// hook
hookH = 2; // height
hookL = 70; //length
hookW = 15; // width

holeR = 4; // radius

// Code
//------------------------------------------------------------------------------

difference() {
    union() {
        cylinder(h = circleH, r = circleR, center = true);
        difference() {
            // hook
            translate([-(circleR + (hookL / 2)) , 0, -((circleH / 2))]) {
                cube([hookL, hookW, hookH], true);
            }
            // hook hole
            translate([
                -(circleR + (hookL - (hookW / 2))),
                0,
                -((circleH / 2))
            ]) {
                cylinder(h = hookH, r = holeR, center = true);
            }
        }
        // circle edge
        translate([0 , 0, -((circleH / 2))]) {
            cylinder(h = hookH, r = (circleR + hookH), center = true);
        }
    }

    // round hook at top
    difference() {
        translate([-(circleR + (hookL - (hookW / 4))), 0, -((circleH / 2))]) {
            cube([(hookW / 2), hookW, hookH], true);
        }
        translate([-(circleR + (hookL - (hookW / 2))), 0, -((circleH / 2))]) {
            cylinder(h = hookH, r = (hookW / 2), center = true);
        }
    }

    // circle
    cylinder(h = (circleH + hookH), r = (circleR - 2), center = true);
    // cut circle with cube
    translate([circleR / 2, 0, 0]) {
        cube([(circleR) * 2, (circleR + hookH) * 3, circleH * 2], true);
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
