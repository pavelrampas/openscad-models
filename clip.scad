/*
 * Clip
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

height = 15;
thickness = 2.49;
length = 30;

size = 8.5; // inner circle diameter
sizeSmall = 3; // space between top and bottom at the end

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

// Code
//------------------------------------------------------------------------------

sizeWithThickness = size + (thickness * 2);

linear_extrude(height) {
    // circle
    difference() {
        circle(d = sizeWithThickness);
        circle(d = size);
        translate([0, -sizeWithThickness / 2, 0]) {
            square(sizeWithThickness);
        }
    }

    // bottom
    translate([0, -sizeWithThickness / 2, 0]) {
        square([length + (thickness * 4), thickness]);
    }
    translate([
        length + (thickness * 4),
        -(sizeWithThickness / 2) + (thickness / 2),
        0
    ]) {
        circle(d = thickness);
    }

    // top
    hull() {
        translate([0, size / 2 + thickness / 2, 0]) {
            circle(d = thickness);
        }
        translate([length, -(size / 2) + sizeSmall + (thickness / 2), 0]) {
            circle(d = thickness);
        }
    }

    hull() {
        translate([length, -(size / 2) + sizeSmall + (thickness / 2), 0]) {
            circle(d = thickness);
        }
        translate([
            length + (thickness * 2),
            -(size / 2) + sizeSmall + thickness / 2,
            0
        ]) {
            circle(d = thickness);
        }
    }

    hull() {
        translate([
            length + (thickness * 2),
            -(size / 2) + sizeSmall + thickness / 2,
            0
        ]) {
            circle(d = thickness);
        }
        translate([
            length + (thickness * 4),
            -(size / 2) + sizeSmall + (thickness / 2) + thickness,
            0
        ]) {
            circle(d = thickness);
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
