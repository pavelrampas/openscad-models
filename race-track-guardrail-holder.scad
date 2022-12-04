/*
 * Race track guardrail holder
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

height = 5;
endDiameter = 3.4;
width = 7;
length = 14.2;
thickness = 1.9;

guardrail_height = 28.5;
guardrail_thickness = 2.4;

// Code
//------------------------------------------------------------------------------

_half_part();
translate([0, length - thickness, 0]){
    mirror([0, 1, 0]) {
        _half_part();
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// half part of the model
module _half_part() {
    cylinder(h = height, d = endDiameter);
    translate([0, -(thickness / 2), 0]) {
        cube([width - (endDiameter / 2), thickness, height]);
    }
    translate([width - (endDiameter / 2) - thickness, -(thickness / 2), 0]) {
        cube([thickness * 2, length / 2, height]);
    }
    // column
    translate([
        (width + thickness) - (endDiameter / 2) - thickness,
        (length / 2) - (length / 4) - (thickness / 2),
        0
    ]) {
        cube([thickness, length / 4, guardrail_height + height + thickness]);
    }
    // hook
    translate([
        (width) - (endDiameter / 2) - guardrail_thickness,
        (length / 2) - (length / 4) - (thickness / 2),
        guardrail_height + height
    ]) {
        cube([guardrail_thickness, length / 4, thickness]);
    }
    translate([
        (width) - (endDiameter / 2) - thickness - guardrail_thickness,
        (length / 2) - (length / 4) - (thickness / 2),
        guardrail_height + height - thickness
    ]) {
        cube([thickness, length / 4, thickness * 2]);
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
