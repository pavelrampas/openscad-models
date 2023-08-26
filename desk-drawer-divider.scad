/*
 * Desk Drawer Divider (King Büromöbel Systeme)
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

wallThickness = 10;

// Parameters that don't need to be changed
//------------------------------------------------------------------------------
thickness = 1.67;

height = 66.5;
length = 15;

bHolderX = 1.8;
bHolderY = 6.5;
bHolderZ = 2;
bHolderXMove = 1.5;

toothX = 5; // bottom X size
toothZ = 17; // tooth height

// Code
//------------------------------------------------------------------------------

width = (2 * thickness) + wallThickness;

difference() {
    union() {
        // main part
        translate([toothX, 0, 0]) {
            cube([length, width, height]);
        }

        // bottom holder
        translate([
            toothX + bHolderXMove,
            ( width / 2 ) - ( bHolderY/2 ),
            height
        ]) {
            cube([bHolderX, bHolderY, bHolderZ]);
        }

        // tooth
        cubePointsTooth = [
          [0, 0, 0],
          [toothX, 0, 0],
          [toothX, width, 0],
          [0, width, 0],
          [1, 0, toothZ],
          [toothX, 0, toothZ],
          [toothX, width, toothZ],
          [1, width, toothZ]
        ];
        cubeFacesTooth = [
          [0,1,2,3],
          [4,5,1,0],
          [7,6,5,4],
          [5,6,2,1],
          [6,7,3,2],
          [7,4,0,3]
        ];
        polyhedron( cubePointsTooth, cubeFacesTooth );

        // side holder
        sHolderX = -(7.5 - toothX);
        sHolderYA = width/2 - 1.5;
        sHolderYB = width/2 + 1.5;
        sHolderZ = toothZ - 4;
        cubePointsHolder = [
          [sHolderX, sHolderYA + 0.5, sHolderZ],
          [toothX, sHolderYA + 0.5, sHolderZ],
          [toothX, sHolderYB - 0.5, sHolderZ],
          [sHolderX, sHolderYB - 0.5, sHolderZ],
          [sHolderX, sHolderYA, toothZ],
          [toothX, sHolderYA, toothZ],
          [toothX, sHolderYB, toothZ],
          [sHolderX, sHolderYB, toothZ]
        ];
        cubeFacesHolder = [
          [0,1,2,3],
          [4,5,1,0],
          [7,6,5,4],
          [5,6,2,1],
          [6,7,3,2],
          [7,4,0,3]
        ];
        polyhedron( cubePointsHolder, cubeFacesHolder );
    }

    // hole for the wall
    translate([toothX + bHolderX + bHolderXMove, thickness, 0]) {
        cube([length, width - (2 * thickness), height]);
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
