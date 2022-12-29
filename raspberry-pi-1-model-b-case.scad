/*
 * Raspberry Pi 1 Model B Case
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

// case wall parameters
thickness = 1.67; // wall thickness
height = 1.6; // top and bottom height
space = 0.5; // space around rpi and ports
supportThickness = 0.86;
connectHeight = 3;

// rpi model
rpiLength = 85;
rpiWidth = 56;
rpiHeight = 1.6;

rpiHoleD = 2.8;
rpiHole1x = 11 + (rpiHoleD / 2);
rpiHole1y = 78.5 + (rpiHoleD / 2);
rpiHole2x = 36.5 + (rpiHoleD / 2);
rpiHole2y = 24.2 + (rpiHoleD / 2);

rpiSdWidth = 28.4;
rpiSdLength = 16.8;
rpiSdHeight = 3.5;
rpiSdx = 12.6;

rpiGpioWidth = 5;
rpiGpioLength = 32.8;
rpiGpioHeight = 8.6;
rpiGpioX = 1;
rpiGpioY = 1;

rpiRcaWidth = 10;
rpiRcaLength = 10;
rpiRcaHeight = 13.4;
rpiRcaD = 8.4;
rpiRcaX = 2.5;
rpiRcaY = 41.5;
rpiRcaZ = 5;

rpiJackWidth = 11.5;
rpiJackLength = 12;
rpiJackHeight = 10.2;
rpiJackD = 6.8;
rpiJackX = 0.5;
rpiJackY = 58.8;
rpiJackZ = 4.5;

rpiUsbWidth = 13;
rpiUsbLength = 17.5;
rpiUsbHeight = 15.2;
rpiUsbX = 18.5;
rpiUsbY = 74.5;

rpiRj45Width = 16;
rpiRj45Length = 21;
rpiRj45Height = 13.4;
rpiRj45X = 37.7;
rpiRj45Y = 65;

rpiHdmiWidth = 11.5;
rpiHdmiLength = 15;
rpiHdmiHeight = 5.8;
rpiHdmiX = 45.8;
rpiHdmiY = 37;

rpiPowerWidth = 7.5;
rpiPowerLength = 5.8;
rpiPowerHeight = 3;
rpiPowerX = 44.8;
rpiPowerY = -0.5;

// case size
length = rpiLength + (2 * space);
width = rpiWidth + (2 * space);
caseHeight = (2 * height) + space + rpiSdHeight + rpiHeight + rpiUsbHeight;

cutHeight = height + rpiSdHeight + rpiHeight + rpiHdmiHeight + space;

// Code
//------------------------------------------------------------------------------

// case bottom part
difference() {
    _case();
    // cut top
    translate([-thickness, -thickness, cutHeight]) {
        cube([width + (2 * thickness), length + (2 * thickness), caseHeight]);
    }
    // connecting part
    translate([-thickness / 2, -thickness / 2, cutHeight - connectHeight]) {
        cube([width + thickness, length + thickness, caseHeight]);
    }
    // connecting holes
    translate([0, 0, cutHeight - connectHeight]) {
        translate([-thickness, thickness * 2, 0]) {
            cube([thickness, 4, 1]);
        }
        translate([-thickness, length - thickness * 4, 0]) {
            cube([thickness, 4, 1]);
        }
        translate([width, thickness * 2, 0]) {
            cube([thickness, 4, 1]);
        }
        translate([width, length - thickness * 4, 0]) {
            cube([thickness, 4, 1]);
        }
    }
}

// case top part
translate([100, 0, 0]) {
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
        // rca and jack holes
        translate([
            -thickness,
            (rpiRcaY+(rpiRcaLength/2)+space) - ((rpiRcaD+(4*space))/2),
            cutHeight - connectHeight
        ]) {
            cube([thickness, rpiRcaD + (4 * space), connectHeight]);
        }
        translate([
            -thickness,
            (rpiJackY+(rpiJackLength/2)+space) - ((rpiJackD+(4*space))/2),
            cutHeight - connectHeight
        ]) {
            cube([thickness, rpiJackD + (4 * space), connectHeight]);
        }
        // vent
        translate([width / 2, length / 2, 0]) {
            cylinder($fn = 6, h = caseHeight, d = 5);
        }
        translate([width / 2, (length / 2), 0]) {
            for (i = [0 : 6 - 1]) {
                angle = (i * 360 / 6) + 30;
                translate(6 * [cos(angle), -sin(angle), 0]) {
                    cylinder($fn = 6, h = caseHeight, d = 5);
                }
            }
        }
    }
    // connecting holes
    translate([0, 0, cutHeight - connectHeight]) {
        translate([-(thickness / 2) - 0.5 + 0.1, thickness * 2, 0]) {
            cube([0.5, 3.6, 0.8]);
        }
        translate([
            -(thickness / 2) - 0.5 + 0.1, length - thickness * 4, 0
        ]) {
            cube([0.5, 3.6, 0.8]);
        }
        translate([
            width + ((thickness / 2) - 0.1), thickness * 2, 0
        ]) {
            cube([0.5, 3.6, 0.8]);
        }
        translate([
            width + ((thickness / 2) - 0.1), length - thickness * 4, 0
        ]) {
            cube([0.5, 3.6, 0.8]);
        }
    }
}

// rpi model
translate([space, space, rpiSdHeight + height]) {
    %_raspberry();
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
        // rpi holes
        translate([space, space, rpiSdHeight + height]) {
            // sd card
            translate([
                rpiSdx - space + 1, -(space + thickness + 1), -rpiSdHeight
            ]) {
                cube([
                    rpiSdWidth + (2 * space) - 4,
                    rpiSdLength + thickness + space + 1,
                    rpiSdHeight + space
                ]);
            }
            // rca
            translate([
                rpiRcaX - 10 - (space + thickness + 1),
                rpiRcaY + (rpiRcaLength / 2),
                rpiRcaZ + (rpiRcaD / 2)
            ]) {
                rotate([90, 0, 90]) {
                    cylinder(
                        h = 10 + thickness + space + 1,
                        d = rpiRcaD + (4 * space),
                        center = false
                    );
                }
            }
            // jack
            translate([
                rpiJackX - 3 - (space + thickness + 1),
                rpiJackY + (rpiJackLength / 2),
                rpiJackZ + (rpiJackD / 2)
            ]) {
                rotate([90, 0, 90]) {
                    cylinder(
                        h = 3 + thickness + space + 1,
                        d = rpiJackD + (4 * space),
                        center = false
                    );
                }
            }
            // usb
            translate([
                rpiUsbX - space,
                rpiUsbY + thickness + space + 1,
                rpiHeight - space
            ]) {
                cube([
                    rpiUsbWidth + (2 * space),
                    rpiUsbLength + thickness + space + 1,
                    rpiUsbHeight + (2 * space)
                ]);
            }
            // rj45
            translate([
                rpiRj45X - space,
                rpiRj45Y + thickness + space + 1,
                rpiHeight - space
            ]) {
                cube([
                    rpiRj45Width + (2 * space),
                    rpiRj45Length + thickness + space + 1,
                    rpiRj45Height + (2 * space)
                ]);
            }
            // hdmi
            translate([
                rpiHdmiX + thickness + space + 1,
                rpiHdmiY - space,
                rpiHeight - space
            ]) {
                cube([
                    rpiHdmiWidth + thickness + space + 1,
                    rpiHdmiLength + (2 * space),
                    rpiHdmiHeight + (2 * space)
                ]);
            }
            // power
            translate([
                rpiPowerX - space,
                rpiPowerY - (thickness + space + 1),
                rpiHeight - space
            ]) {
                cube([
                    rpiPowerWidth + (2 * space),
                    rpiPowerLength + thickness + space + 1,
                    rpiPowerHeight + (2 * space)
                ]);
            }
        }
    }
    // supports
    translate([rpiSdx, rpiHole2y + (rpiHoleD / 2), height]) {
        cube([rpiSdWidth, supportThickness, rpiSdHeight - space]);
    }
    translate([rpiHole1x - (rpiHoleD / 2), rpiHole1y, height]) {
        cube([5, supportThickness, rpiSdHeight - space]);
    }
    translate([rpiRj45X, rpiHole1y, height]) {
        cube([5, supportThickness, rpiSdHeight - space]);
    }
    translate([rpiSdx - 2, 0, 1 + height + rpiSdHeight + space + rpiHeight]) {
        rotate([0, 90, 0]) {
            cylinder(h = 2, d = 2, center = false);
        }
    }
    translate([
        rpiSdx + rpiSdWidth + 1,
        0,
        1 + height + rpiSdHeight + space + rpiHeight
    ]) {
        rotate([0, 90, 0]) {
            cylinder(h = 2, d = 2, center = false);
        }
    }
}

// rpi model
module _raspberry() {
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
        }
    }
    // sd card
    color("dimgray") {
        translate([rpiSdx, 0, -rpiSdHeight]) {
            cube([rpiSdWidth, rpiSdLength, rpiSdHeight]);
        }
    }
    // gpio
    color("dimgray") {
        translate([rpiGpioX, rpiGpioY, rpiHeight]) {
            cube([rpiGpioWidth, rpiGpioLength, rpiGpioHeight]);
        }
    }
    // rca
    color("yellow") {
        translate([rpiRcaX, rpiRcaY, rpiHeight]) {
            cube([rpiRcaWidth, rpiRcaLength, rpiRcaHeight]);
        }
        translate([
            rpiRcaX - 10,
            rpiRcaY + (rpiRcaLength / 2),
            rpiRcaZ + (rpiRcaD / 2)
        ]) {
            rotate([90, 0, 90]) {
                cylinder(h = 10, d = rpiRcaD, center = false);
            }
        }
    }
    // jack
    color("dimgray") {
        translate([rpiJackX, rpiJackY, rpiHeight]) {
            cube([rpiJackWidth, rpiJackLength, rpiJackHeight]);
        }
        translate([
            rpiJackX - 3,
            rpiJackY + (rpiJackLength / 2),
            rpiJackZ + (rpiJackD / 2)
        ]) {
            rotate([90, 0, 90]) {
                cylinder(h = 3, d = rpiJackD, center = false);
            }
        }
    }
    // usb
    color("lightgray") {
        translate([rpiUsbX, rpiUsbY, rpiHeight]) {
            cube([rpiUsbWidth, rpiUsbLength, rpiUsbHeight]);
        }
    }
    // rj45
    color("lightgray") {
        translate([rpiRj45X, rpiRj45Y, rpiHeight]) {
            cube([rpiRj45Width, rpiRj45Length, rpiRj45Height]);
        }
    }
    // hdmi
    color("lightgray") {
        translate([rpiHdmiX, rpiHdmiY, rpiHeight]) {
            cube([rpiHdmiWidth, rpiHdmiLength, rpiHdmiHeight]);
        }
    }
    // power
    color("lightgray") {
        translate([rpiPowerX, rpiPowerY, rpiHeight]) {
            cube([rpiPowerWidth, rpiPowerLength, rpiPowerHeight]);
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
