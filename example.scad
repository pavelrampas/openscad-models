/*
 * Title
 *
 * Author: Name
 * Version: 1.0.1 (Changelog is at the bottom)
 * License: CC BY-SA 4.0 [https://creativecommons.org/licenses/by-sa/4.0/]
 * Link: https://github.com/
 *
 * OpenSCAD version: 2019.05
 *
 * Instructions:
 * Set up parameters, render and print.
 *
 * Height is layer.
 * Thickness is perimeter.
 */

use <file.scad>;

// Parameters
//------------------------------------------------------------------------------

$fn = $preview ? 15 : 90;

sphereRadius = 5;
cubeSize = 10;

// Code
//------------------------------------------------------------------------------

cube(cubeSize, true);
_my_module(sphereRadius);
echo(_my_function(10)); // 21

// Functions
//------------------------------------------------------------------------------

// my function description
function _my_function(x=3) = (2 * x) + 1;

// Modules
//------------------------------------------------------------------------------

// my module description
module _my_module(radius) {
    translate([0, 15, 0]) {
        sphere(radius);
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.1]:
// Fix bug.

// [1.0.0]:
// Initial release.
