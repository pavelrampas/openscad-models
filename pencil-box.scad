/*
 * Pencil Box
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

number = 12; // number of pencils
length = 180; // pencil length
diamater = 8; // pencil diamater

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

layerHeight = 0.2;
baseHeight = 3 * layerHeight;
thickness = 1.67; // wall thickness for 0.4 nozzle
spaceHeight = 1.8; // bottom space height
space = 0.1; // space between pencils
lockD = 2; // lock diameter

coverLockD = 1.6; // lock diameter

// Code
//------------------------------------------------------------------------------

width = (thickness * 2) + ((diamater + space) * number) + space;
widthInner = ((diamater + space) * number) + space;

// case
difference() {
    // base cube
    cube([length + (2 * thickness), width, baseHeight + spaceHeight + diamater]);

    // inner cube
    translate([
        thickness,
        thickness,
        baseHeight + spaceHeight + (diamater / 2)
    ]) {
        cube([length, widthInner, baseHeight + spaceHeight + diamater]);
    }

    // bottom space cube
    translate([thickness + length - 18, thickness, baseHeight + layerHeight]) {
        cube([18, widthInner, baseHeight + spaceHeight + diamater]);
    }

    // pencils
    for (i = [0 : number - 1]) {
        translate([0, i * (diamater + space), 0]) {
            #_pencil();
        }
    }
}

// lock
translate([10, 0, 0]) {
    cylinder(
        h = (baseHeight + spaceHeight + diamater) / 2,
        d1 = lockD,
        d2 = lockD
    );
}
translate([10, width, 0]) {
    cylinder(
        h = (baseHeight + spaceHeight + diamater) / 2,
        d1 = lockD,
        d2 = lockD
    );
}

// cover
translate([0, width + 20, 0]) {
    difference() {
        cube([
            length + (3 * thickness),
            width + (2 * thickness) + 2,
            baseHeight + spaceHeight + diamater + 3
        ]);

        translate([0, thickness, 1]) {
            cube([
                length + (2 * thickness),
                width + 2,
                baseHeight + spaceHeight + diamater + 1
            ]);
        }

        translate([0, thickness + 1 + 4, 0]) {
            cube([
                length + (2 * thickness),
                width - 8,
                baseHeight + spaceHeight + diamater
            ]);
        }
    }

    // lock
    translate([7, thickness, 0]) {
        cylinder(
            h = (baseHeight + spaceHeight + diamater) / 2,
            d1 = coverLockD,
            d2 = coverLockD
        );
    }
    translate([7, width + (2 * thickness) + 0.5, 0]) {
        cylinder(
            h = (baseHeight + spaceHeight + diamater) / 2,
            d1 = coverLockD,
            d2 = coverLockD
        );
    }

    translate([length - 10, thickness, 0]) {
        cylinder(
            h = (baseHeight + spaceHeight + diamater) / 2,
            d1 = lockD,
            d2 = lockD
        );
    }
    translate([length - 10, width + (2 * thickness) + 0.5, 0]) {
        cylinder(
            h = (baseHeight + spaceHeight + diamater) / 2,
            d1 = lockD,
            d2 = lockD
        );
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

module _pencil() {
    translate([
        thickness,
        thickness + (diamater / 2) + space,
        (diamater / 2) + baseHeight + spaceHeight
    ]) {
        rotate([90, 0, 90]) {
            cylinder($fn = 6, h = length, d1 = diamater, d2 = diamater);
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
