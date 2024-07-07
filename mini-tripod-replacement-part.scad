/*
 * Mini Tripod Replacement Part
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

boltDiamater = 3.1;
boltHeadDiamater = 5.6;
nut = 5.6;

stopper = 5;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

baseDiamater = 20;
baseHeight = 6;
baseLegHookHeight = 11;

legDiamater = 11;
legThickness = 1.7;
legHeight = 6;

legHookX = 8;
legHookY = 3;
legHookZ = 5;

// Code
//------------------------------------------------------------------------------

difference() {
    cylinder(h = baseHeight, d = baseDiamater);

    // hole
    translate([0, 0, 1.2]) {
        cylinder(h = baseHeight, d = baseDiamater - 8);
    }
    // bolt hole
    cylinder(h = baseHeight, d = 4);
}

// base hooks
_baseHook();
rotate([0, 0, 120]) {
    _baseHook();
}
rotate([0, 0, 240]) {
    _baseHook();
}

// leg cap
translate([0, 40, 0]) {
    // cap
    difference() {
        cylinder(h = legHeight, d = legDiamater + (2 * legThickness));

        // hole
        translate([0, 0, -1]) {
            cylinder(h = legHeight, d = legDiamater);
        }
    }

    // hook
    difference() {
        union() {
            translate([-(legHookX / 2), -(legHookY / 2), legHeight]) {
                cube([legHookX, legHookY, legHookZ]);
            }
            translate([
                -(legDiamater + (2 * legThickness)) / 2,
                -(legHookY / 2),
                legHeight
            ]) {
                cube([legDiamater / 2, legHookY, stopper]);
            }
            translate([0, legHookY / 2, legHeight + legHookZ]) {
                rotate([90, 0, 0]) {
                    cylinder(h = legHookY, d = legHookX);
                }
            }
        }

        // bolt hole
        translate([0, legHookY / 2, legHeight + legHookZ]) {
            rotate([90, 0, 0]) {
                cylinder(h = legHookY, d = boltDiamater);
            }
        }
    }
}


// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

module _baseHook() {
    translate([9, 0, 3.3]) {
        difference() {
            // hook
            cylinder(h = baseLegHookHeight, d = legHookY * 3);

            // hole
            translate([0, 0, baseLegHookHeight - (legHookX / 2)]) {
                cube([legHookX + 2, legHookY, legHookX], center = true);
            }

            // bolt hole
            rotate([90, 0, 0]) {
                translate([
                    0,
                    baseLegHookHeight - (legHookX / 2),
                    -(legHookY * 3) / 2
                ]) {
                    cylinder(h = legHookY * 3, d = boltDiamater);
                }
            }

            // nut hole
            translate([
                0,
                ((legHookY * 3) / 2) - 0.5,
                baseLegHookHeight - (legHookX / 2)
            ]) {
                cube([legHookY * 3, 1, nut], center = true);
            }

            // bolt head hole
            rotate([90, 0, 0]) {
                translate([
                    0,
                    baseLegHookHeight - (legHookX / 2),
                    ((legHookY * 3) / 2) - 1
                ]) {
                    cylinder(h = 1, d = boltHeadDiamater);
                }
            }
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
