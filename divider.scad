/*
 * Divider
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

$fn = $preview ? 15 : 30;

x = 10;
y = 150;
z = 70;

jointsLength = 20; // joints
leftSide = "none"; // none, inner, outer
rightSide = "none"; // none, inner, outer

// Parameters that don't need to be changed
//------------------------------------------------------------------------------

// braces parameters
minMarginY = 15; // minimal indentation first and last brace from edge
braceY = 2; // brace size
braceZMove = 0.8; // base height
braceXMove = 0.86; // connection of brace and wall (0.86 for 0.4 nozzle)
braceSpaces = 40; // space between braces

// square textures parameters
squareA = 10; // square size
squareHeight = 0.5;
squareScale = 0.8; // square linear extrude scale
squareOffset = 0.2;
squareMinkowskiSphere = 0.5; // sphere radius
squareSpaces = 5; // space between squares
minMarginZ = 2; // minimal indentation textures from top and bottom edge
squareMarginY = 2; // space between braces and textures

// Code
//------------------------------------------------------------------------------

// number of braces
braces = floor(
    (y - (2 * minMarginY) + braceSpaces) / (braceSpaces + braceY)
);
// real indentation first and last brace from edge
braceMarginY = (y - (braces * (braceSpaces + braceY)) + braceSpaces) / 2;

// diagonal of the square
squareD = sqrt(
    pow(squareA + squareMinkowskiSphere * 2, 2)
    + pow(squareA + squareMinkowskiSphere * 2, 2)
);
// number of squares Y
squareLinesY = floor(
    (braceSpaces - (2 * squareMarginY) + squareSpaces) / (squareSpaces + squareD)
);
// number of squares Z
squareLinesZ = floor(
    (z - (2 * minMarginZ) + squareSpaces) / (squareSpaces + squareD)
);

// wall with braces
difference() {
    // wall
    cube([x, y, z]);

    // braces
    for (y = [0:braces - 1]) {
        positionX = ((y % 2) == 1) ? -braceXMove: braceXMove;
        translate([
            positionX,
            (y * (braceSpaces + braceY)) + braceMarginY,
            braceZMove
        ]) {
            cube([x, braceY, z]);
        }
    }

}

// joints
if (leftSide == "inner") {
    _joints_inner();
}

if (leftSide == "outer") {
    _joints_outer();
    translate([x - (x / 3), 0, 0]) {
        _joints_outer();
    }
}

if (rightSide == "inner") {
    translate([0, y, 0]){
        mirror([0, 1, 0]) {
            _joints_inner();
        }
    }
}

if (rightSide == "outer") {
    translate([0, y, 0]){
        mirror([0, 1, 0]) {
            _joints_outer();
            translate([x - (x / 3), 0, 0]) {
                _joints_outer();
            }
         }
    }
}

// textures
_squares_texture_front_side();
translate([x, y, 0]) {
    rotate([0, 0, 180]) {
        _squares_texture_front_side();
    }
}

// Functions
//------------------------------------------------------------------------------

// Modules
//------------------------------------------------------------------------------

// front side textures
module _squares_texture_front_side() {
    sizeY = (squareLinesY * (squareD + squareSpaces)) - squareSpaces;
    sizeZ = (squareLinesZ * (squareD + squareSpaces)) - squareSpaces;
    positionY = (braceSpaces - sizeY) / 2;
    positionZ = z - ((z - sizeZ) / 2);
    for (y = [1:braces - 1]) {
        translate([
            x,
            ((y * (braceSpaces + braceY)) + braceMarginY - braceSpaces)
                + positionY,
            positionZ
        ]) {
            rotate([0, 90, 0]) {
                _squares_texture(squareLinesZ, squareLinesY);
            }
        }
    }
}

// texture formed by squares
module _squares_texture(squareLinesY, squareLinesZ) {
    // lines y
    for (y = [0:squareLinesZ - 1]) {
        // lines x
        for (x = [0:squareLinesY - 1]) {
            translate([
                x * (squareSpaces + squareD) + (squareD / 2),
                y * (squareSpaces + squareD) + (squareD / 2),
                0
            ]) {
                _square();
            }
        }
    }

    // lines y second
    if (squareLinesZ >= 2) {
        for (y = [0:squareLinesZ - 2]) {
            // lines x seconf
            for (x = [0:squareLinesY - 2]) {
                translate([
                    x * (squareSpaces + squareD) + squareD + (squareSpaces / 2),
                    y * (squareSpaces + squareD) + squareD + (squareSpaces / 2),
                    0
                ]) {
                    _square();
                }
            }
        }
    }
}

// one square
module _square() {
    rotate([0,0,45]) {
        minkowski() {
            linear_extrude(
                height = squareHeight,
                scale=[squareScale, squareScale]
            ) {
                offset(squareOffset) {
                    square(squareA, center = true);
                }
            }
            sphere(squareMinkowskiSphere);
        }
    }
}

// joints inner part
module _joints_inner() {
    difference() {
        translate([(x / 3) + 0.05, -jointsLength + 0.2, 0]) {
            cube([(x / 3) - 0.1, jointsLength - 0.2, z]);
        }
        // braces
        translate([(x / 3) + braceXMove, -braceY, braceZMove]) {
            cube([(x / 3), braceY, z]);
        }
        translate([
            (x / 3) - braceXMove,
            -(jointsLength / 2) - braceY,
            braceZMove
        ]) {
            cube([(x / 3), braceY, z]);
        }
    }
}

// joints outer part
module _joints_outer() {
    difference() {
        translate([0, -jointsLength, 0]) {
            cube([(x / 3), jointsLength, z]);
        }
        // braces
        translate([braceXMove, -braceY, braceZMove]) {
            cube([(x / 3), braceY, z]);
        }
        translate([
            -braceXMove,
            -(jointsLength / 2) - braceY,
            braceZMove
        ]) {
            cube([(x / 3), braceY, z]);
        }
    }
}

// Changelog
//------------------------------------------------------------------------------

// [1.0.0]:
// Initial release.
