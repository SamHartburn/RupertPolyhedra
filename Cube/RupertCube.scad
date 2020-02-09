/*
RupertCube

For a polyhedron to be classed as Rupert, it must be possible to cut a hole in it that is large enough for an identical polyhedron to pass through. It sounds impossible, but many polyhedra havethis property, including the cube.

This file constructs a cube with a hole in it that a cube of the same size will fit through.

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

d = 50; //Side length of cube
d2=d*1.01; //Side length of hole. This can be up to 1.0606... times the side length of the cube. The bigger it is, the thinner the remaining section of cube will be.

difference() {
    cube([d,d,d], center=true);

    rotate([atan(1/4),0,45]) {
        cube([d2,d2*10,d2],center=true);
    }
}
