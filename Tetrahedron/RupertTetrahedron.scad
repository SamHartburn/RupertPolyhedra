/*
RupertTetrhedron

For a polyhedron to be classed as Rupert, it must be possible to cut a hole in it that is large enough for an identical polyhedron to pass through. It sounds impossible, but many polyhedra havethis property, including the tetrahedron.

This file constructs a tetrahedron with a hole in it, and a second tetrahedron of the same size that passes through the hole.

It is not suitable for 3D-printing because some parts are far too thin.

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
To animate the tetrahedron passing through the hole, select View->Animate to show the animation settings. Enter values in FPS and Steps. I suggest FPS = 30 and Steps = 100.
*/

//Optimal settings for the viewport
$vpt = [-0.25,0.7,4.24];
$vpr = [113.3,0.0,234.3];
$vpd = 36.54;

edge_length=10;

color("DeepSkyBlue") {
    difference() {  
        //This is the tetrahedron with the hole in it
        rotate([90-acos(1/3),0,180]) {
            tetrahedron(edge_length);
        }

        //This is the tunnel
        //Made using a projection of the rotated tetrahedron
        
        translate([0,-25,0]) {
            rotate([-90,0,0]) {
                linear_extrude(30) {
                    projection() {
                        translate([0,0,25]) {
                            rotate([90,0,0]) {
                                #tetra2(edge_length);
                            }
                        }
                    }
                }
            }
        }
    }
}

//This is the tetrahedron rotated to pass through the tunnel
color("OrangeRed") {
    translate([0,-20*$t,0]) {
        translate([0,7,0]) {
            tetra2(edge_length);
        }
    }
}

//Function to construct a tetrahedron
module tetrahedron(edge) {
    
    face_height=sqrt(3)*edge/2;
    solid_height=sqrt(2/3)*edge;
    
    //Coordinates for centre placement
    /*y_base = -edge/(2*sqrt(3));
    y_top = edge/sqrt(3);
    y_apex = 0;
 
    z_base = -edge*1/4;
    z_top = solid_height+z_base;*/

    //Coordinates for placement on x-axis
    y_base = 0;
    y_top = sqrt(3)*edge/2;
    y_apex = edge/(2*sqrt(3));
      
    z_base = 0;
    z_top = solid_height;
    
    points=[[-edge/2,y_base,z_base],[edge/2,y_base,z_base],[0,y_top,z_base],[0,y_apex,z_top]];
    
    faces=[[0,1,2],[1,2,3],[0,2,3],[0,3,1]];
    
    polyhedron(points,faces);
}

//Function to construct a tetrahedron with the required rotation to pass though the hole
module tetra2(edge) {
    translate([0,0,edge*0.001]) {
        rotate([0,0,60-asin(1/3*sqrt(6))]) {
            tetrahedron(edge);
        }
    }
}
