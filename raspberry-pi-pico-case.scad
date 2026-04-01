/*
 * Raspberry Pi Pico Case
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

buttonHole = true;
modelH = false; // pico with gpio header

// more space around pico
spaceXLeft = 0;
spaceXRight = 0;
spaceY = 0;
spaceZTop = 0;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

// case wall parameters
thickness = 1.67; // wall thickness
height = 1.6; // top and bottom height
space = 0.4; // space around rpi and ports
supportHeight = modelH ? 3 : 1; // space under pico
connectHeight = 2;
lockThickness = 0.86;

// pico model
rpiLength = 51;
rpiWidth = 21;
rpiHeight = 1.2;

rpiHoleD = 1.8;
rpiHole1x = 3.9 + (rpiHoleD / 2);
rpiHole1y = 1.1 + (rpiHoleD / 2);
rpiHole2x = (rpiWidth - 3.9) - (rpiHoleD / 2);
rpiHole2y = 1.1 + (rpiHoleD / 2);
rpiHole3x = 3.9 + (rpiHoleD / 2);
rpiHole3y = (rpiLength - 1.1) - (rpiHoleD / 2);
rpiHole4x = (rpiWidth - 3.9) - (rpiHoleD / 2);
rpiHole4y = (rpiLength - 1.1) - (rpiHoleD / 2);

rpiPowerWidth = 8;
rpiPowerLength = 5.8;
rpiPowerHeight = 3;
rpiPowerX = (rpiWidth / 2) - (rpiPowerWidth / 2);
rpiPowerY = -1.6;

rpiButtonWidth = 3.4;
rpiButtonLength = 4.2;
rpiButtonHeight = 2.6;
rpiButtonX = 12.8;
rpiButtonY = 10.2;

rpiDebugHeight = 4.2;
rpiDebugLength = 3.2;
rpiDebugWidth = 5.2;
rpiDebugX = 5.1;
rpiDebugY = 29.8;

rpiheaderHeight = 2.8;
rpiheaderWidth = 2.6;

// case size
length = rpiLength + (2 * space) + spaceY;
width = rpiWidth + (2 * space) + spaceXLeft + spaceXRight;
caseHeight = modelH
    ? (2 * height) + space + rpiHeight + supportHeight + rpiDebugHeight
        + spaceZTop
    : (2 * height) + space + rpiHeight + supportHeight + rpiPowerHeight
        + spaceZTop;

cutHeight = height + rpiHeight + space + connectHeight + supportHeight;

// Code
//------------------------------------------------------------------------------

// case bottom part
union() {
    difference() {
        _case();
        // cut top
        translate([-thickness, -thickness, cutHeight]) {
            cube([
                width + (2 * thickness),
                length + (2 * thickness),
                caseHeight
            ]);
        }
        // connecting part
        translate([-thickness / 2, -thickness / 2, cutHeight - connectHeight]) {
            cube([width + thickness, length + thickness, caseHeight]);
        }
    }
    // locks
    translate([width + thickness, (length / 2) - (9 / 2), caseHeight - 1]) {
        _lock();
    }
    translate([
        -((thickness * 2) - lockThickness),
        (length / 2) - (9 / 2),
        caseHeight - 1
    ]) {
        _lock();
    }
}

// case top part
translate([width + 20, 0, 0]) {
    difference() {
        _case();
        // cut bottom
        translate([-thickness, -thickness, -connectHeight]) {
            cube([
                width + (2 * thickness), length + (2 * thickness), cutHeight
            ]);
        }
        // connecting part
        difference() {
            translate([-thickness, -thickness, 0]) {
                cube([
                    width + (2 * thickness), length + (2 * thickness), cutHeight
                ]);
            }
            translate([(-thickness / 2) + 0.1, (-thickness / 2) + 0.1, 0]) {
                cube([
                    width + thickness - 0.2, length + thickness - 0.2, cutHeight
                ]);
            }
        }
    }
    // locks
    translate([
        -(thickness + (lockThickness / 2)),
        (length / 2) - (4 / 2),
        caseHeight - (0.8 + 1)
    ]) {
        cube([lockThickness / 2, 4, 0.6]);
    }
    translate([
        width + thickness,
        (length / 2) - (4 / 2),
        caseHeight - (0.8 + 1)
    ]) {
        cube([lockThickness / 2, 4, 0.6]);
    }
}

// pico model
translate([space + spaceXLeft, space, height + supportHeight]) {
    %_pico();
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// case
module _case() {
    difference() {
        // box
        linear_extrude(caseHeight) {
            offset(thickness) {
                square([width, length]);
            }
        }
        // inside box
        translate([0, 0, height]) {
            cube([width, length, caseHeight - ((2 * height))]);
        }
        translate([spaceXLeft, 0, 0]) {
            // rpi holes
            translate([space, space, height]) {
                // power
                translate([
                    rpiPowerX - space,
                    rpiPowerY - (thickness + space + 1),
                    (rpiHeight - space) + supportHeight
                ]) {
                    cube([
                        rpiPowerWidth + (2 * space),
                        rpiPowerLength + thickness + space + 1,
                        rpiPowerHeight + (2 * space)
                    ]);
                }
            }
            // gpio header
            if (modelH) {
                translate([space / 2, space / 2, 0]) {
                    cube([rpiheaderWidth + space, rpiLength + space, height]);
                }
                translate([
                    ((space / 2) + rpiWidth) - rpiheaderWidth,
                    space / 2,
                    0
                ]) {
                    cube([rpiheaderWidth + space, rpiLength + space, height]);
                }
            }
            // button
            if (buttonHole) {
                translate([
                    rpiButtonX + (rpiButtonWidth / 2),
                    rpiButtonY + (rpiButtonLength / 2),
                    caseHeight - height
                ]) {
                    cylinder(h = height, d = rpiButtonWidth);
                }
            }
        }
    }
    translate([spaceXLeft, 0, 0]) {
    // supports bottom
    optimA = 0.4;
    optimB = 0.1;
    translate([space + rpiHole1x, space + rpiHole1y, height]) {
        cylinder(h = supportHeight + optimA, d = rpiHoleD + 1, center = false);
        cylinder(
            h = rpiHeight + supportHeight + optimB,
            d = rpiHoleD - 0.25,
            center = false
        );
    }
    translate([space + rpiHole2x, space + rpiHole2y, height]) {
        cylinder(h = supportHeight + optimA, d = rpiHoleD + 1, center = false);
        cylinder(
            h = rpiHeight + supportHeight + optimB,
            d = rpiHoleD - 0.25,
            center = false
        );
    }
    translate([space + rpiHole3x, space + rpiHole3y, height]) {
        cylinder(h = supportHeight + optimA, d = rpiHoleD + 1, center = false);
        cylinder(
            h = rpiHeight + supportHeight + optimB,
            d = rpiHoleD - 0.25,
            center = false
        );
    }
    translate([space + rpiHole4x, space + rpiHole4y, height]) {
        cylinder(h = supportHeight + optimA, d = rpiHoleD + 1, center = false);
        cylinder(
            h = rpiHeight + supportHeight + optimB,
            d = rpiHoleD - 0.25,
            center = false
        );
    }
    // supports top
    supportsTopZ = height + supportHeight + rpiHeight + space;
    supportsTopHeight = (caseHeight - cutHeight) + space;
    translate([space + rpiHole1x, space + rpiHole1y, supportsTopZ]) {
        cylinder(h = supportsTopHeight, d = rpiHoleD + 1, center = false);
    }
    translate([space + rpiHole2x, space + rpiHole2y, supportsTopZ]) {
        cylinder(h = supportsTopHeight, d = rpiHoleD + 1, center = false);
    }
    translate([space + rpiHole3x, space + rpiHole3y, supportsTopZ]) {
        cylinder(h = supportsTopHeight, d = rpiHoleD + 1, center = false);
    }
    translate([space + rpiHole4x, space + rpiHole4y, supportsTopZ]) {
        cylinder(h = supportsTopHeight, d = rpiHoleD + 1, center = false);
    }
    }
}

// lock
module _lock() {
    difference() {
        rotate([0, 90, 0]) {
            linear_extrude(lockThickness) {
                offset(1) {
                    square([caseHeight - 2, 9]);
                }
            }
        }
        translate([0, 2, -1]) {
            cube([lockThickness, 5, 1]);
        }
    }
}

// pico model
module _pico() {
    // board
    color("green") {
        difference() {
            cube([rpiWidth, rpiLength, rpiHeight]);
            translate([rpiHole1x, rpiHole1y, 0]) {
                cylinder(h = rpiHeight, d = rpiHoleD, center = false);
            }
            translate([rpiHole2x, rpiHole2y, 0]) {
                cylinder(h = rpiHeight, d = rpiHoleD, center = false);
            }
            translate([rpiHole3x, rpiHole3y, 0]) {
                cylinder(h = rpiHeight, d = rpiHoleD, center = false);
            }
            translate([rpiHole4x, rpiHole4y, 0]) {
                cylinder(h = rpiHeight, d = rpiHoleD, center = false);
            }
        }
    }
    // power
    color("lightgray") {
        translate([rpiPowerX, rpiPowerY, rpiHeight]) {
            cube([rpiPowerWidth, rpiPowerLength, rpiPowerHeight]);
        }
    }
    // button
    color("lightgray") {
        translate([rpiButtonX, rpiButtonY, rpiHeight]) {
            cube([rpiButtonWidth, rpiButtonLength, rpiButtonHeight]);
        }
    }
    // debug
    color("lightgray") {
        translate([rpiDebugX, rpiDebugY, rpiHeight]) {
            cube([rpiDebugWidth, rpiDebugLength, rpiDebugHeight]);
        }
    }
    if (modelH) {
        color("lightgray") {
            translate([0, 0, -rpiheaderHeight]) {
                cube([rpiheaderWidth, rpiLength, rpiheaderHeight]);
            }
            translate([rpiWidth - rpiheaderWidth, 0, -rpiheaderHeight]) {
                cube([rpiheaderWidth, rpiLength, rpiheaderHeight]);
            }
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
