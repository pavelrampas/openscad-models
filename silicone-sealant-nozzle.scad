/*
 * Silicone Sealant Nozzle
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

/*
 * You need download threads.scad by Dan Kirshner.
 * https://dkprojects.net/openscad-threads/
 * https://dkprojects.net/openscad-threads/threads.scad
 */
use <threads.scad>

// Parameters
//------------------------------------------------------------------------------

$fn = $preview ? 15 : 90;

print = "nozzle"; // nozzle or extension

nozzleLength = 60;

extensionLength = 50;
extensionEnd = "thread"; // thread or tip
extensionEndTipSize = 2;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

// Code
//------------------------------------------------------------------------------

if (print == "nozzle") {
    _nozzle();
}
if (print == "extension") {
    _extension();
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

module _nozzle() {
    // thread
    difference() {
        cylinder(h=10, d=22);
        metric_thread(
            diameter=16.5,
            pitch=2.5,
            length=10,
            internal=true,
            square=true
        );
    }
    // nozzle
    translate([0, 0, 10]) {
        // nozzle body
        difference() {
            cylinder(h=nozzleLength, d1=18, d2=8);
            cylinder(h=nozzleLength, d1=14, d2=5);
        };
        // nozzle thread
        translate([0, 0, nozzleLength]) {
            _thread();
        }
    };
}

module _extension() {
    // thread
    difference() {
        cylinder(h=8, d=12);
        metric_thread(diameter=8.5, pitch=1.3, length=8, internal=true);
    }
    translate([0, 0, 8]) {
        difference() {
            cylinder(h=10, d1=12, d2=8);
            cylinder(h=10, d1=8, d2=5);
        };
    };
    // nozzle
    translate([0, 0, 18]) {
        // nozzle body
        difference() {
            cylinder(h=extensionLength, d1=8, d2=8);
            cylinder(h=extensionLength, d1=5, d2=5);
        };
        translate([0, 0, extensionLength]) {
            if (extensionEnd == "thread") {
                _thread();
            }
            if (extensionEnd == "tip") {
                difference() {
                    cylinder(h=10, d1=8, d2=extensionEndTipSize + 2);
                    cylinder(h=10, d1=5, d2=extensionEndTipSize);
                };
            }
        }
    };
}

module _thread() {
    difference() {
        metric_thread(diameter=8, pitch=1.25, length=8, internal=false);
        cylinder(h=8, d=5);
    };
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
