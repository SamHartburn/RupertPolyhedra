/*
RupertOctahedron

For a polyhedron to be classed as Rupert, it must be possible to cut a hole in it that is large enough for an identical polyhedron to pass through. It sounds impossible, but many polyhedra havethis property, including the octahedron.

This file constructs a octahedron with a hole in it, and a second octahedron of the same size that passes through the hole.

Copyright (C) 2020 Sam Hartburn
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
author: Sam Hartburn
email: sam@samhartburn.co.uk
website: www.samhartburn.co.uk
*/

/*
To animate the octahedron passing through the hole, select View->Animate to show the animation settings. Set show_outer and show_unmodified to 1, and show_inner to 0. Enter values in FPS and Steps. I suggest FPS = 30 and Steps = 150.
*/

show_outer=1;
show_inner=0;
show_unmodified=0;

edge_length=50;

//This is what is left of the octahedron after the hole is made
if (show_outer==1) {
    color("DeepSkyBlue") {
        difference() {  
            //This is the octahedron with the hole in it
            octahedron(edge_length);

            //This is the tunnel
            //Made using a projection of the rotated octahedron
            translate([0,0,-edge_length]) {
                linear_extrude(edge_length*2) {
                    projection() {
                        octa2(edge_length*1.01);
                    }
                }
            }
        }
    }
}

//This is piece that is cut out when the hole is made
if (show_inner==1) {
    color("DeepSkyBlue") {
        intersection() {  
            //This is the octahedron with the hole in it
            octahedron(edge_length);

            //This is the tunnel
            //Made using a projection of the rotated octahedron
            translate([0,0,-edge_length]) {
                linear_extrude(edge_length*2) {
                    projection() {
                        octa2(edge_length);
                    }
                }
            }
        }
    }
}

//This is the octahedron rotated to pass through the tunnel
if (show_unmodified==1) {
    color("OrangeRed") {
        translate([0,0,-edge_length*2*$t]) {
            translate([0,0,edge_length*1]) {
                octa2(edge_length);
            }
        }
    }
}

//Function to construct an octahedron
module octahedron(edge) {
    
    coord=edge/sqrt(2);  
       
    points=[[coord,0,0], [-coord,0,0], [0,coord,0], [0,-coord,0], [0,0,coord], [0,0,-coord]];
    
    faces=[[0,4,2],[3,4,0],[1,4,3],[2,4,1],[3,5,1],[1,5,2],[2,5,0],[0,5,3]];
    
    polyhedron(points,faces);
}

//Function to construct a octahedron with the required rotation to pass though the hole
module octa2(edge) {
    
    rotate([0,acos(1/sqrt(3))-acos(sqrt(2/3)),0]) {
        rotate([45,0,0]) {
            octahedron(edge);
        }
    }
    
}