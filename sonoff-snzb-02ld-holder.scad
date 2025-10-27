/*
 * Sonoff SNZB-02LD holder
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

thickness = 2.49;

height = 3;

boltHeight = 3 ;
boldDiamater = 60;

probeD = 6.2;
probeLength = 32;

holderHeight = 5;
holderLength = 10;
holderWidth = 20;
holderHole = 3;

// Code
//------------------------------------------------------------------------------

difference() {
    union() {
        // Holder
        difference() {
            translate([
                -(holderWidth / 2),
                -((boldDiamater + (holderLength * 2)) / 2),
                (boltHeight + probeD + height) - holderHeight
            ]) {
                cube([
                    holderWidth,
                    boldDiamater + (holderLength * 2),
                    holderHeight
                ]);
            }

            _holderHole(((boldDiamater + (holderLength * 2)) / 2)
                - holderHole - thickness);
            _holderHole(-(((boldDiamater + (holderLength * 2)) / 2)
                - thickness));

            _base();
        }

        _base();
    }

    // Probe hole
    translate([-4, -(probeD / 2), boltHeight + probeD]) {
        rotate([0, 90, 0]) {
            #cube([probeD, probeD, probeLength]);
        }
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// Base
module _base() {
    rotate([0, 0, 90]) {
        difference() {
            // Base
            cylinder(
                h = boltHeight + probeD + height,
                d = boldDiamater + thickness,
                $fn = 6
            );

            // Bolt
            cylinder(h = boltHeight, d = boldDiamater, $fn = 6);
        }
    }
}

// Holder hole
module _holderHole(side) {
    translate([-((holderWidth - (2 * thickness)) / 2), side, 0]) {
        cube([
            holderWidth - (2 * thickness),
            holderHole,
            boltHeight + probeD + height
        ]);
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
