$fn = 120;

main_bolt_radius = 9.48 / 2;
main_hole_radius = main_bolt_radius + 2;
secondary_bolt_radius = 4.26 / 2;
secondary_hole_radius = secondary_bolt_radius + 1;

preferred_height = 15;
preferred_base_radius = 45 / 2;
preferred_tab_reach = 35;
preferred_tab_width = 20;
preferred_tab_thickness = 3;
preferred_top_ridge_width = 2;

module main_component() {
    cylinder(h=preferred_height, r1=preferred_base_radius, r2=main_hole_radius+preferred_top_ridge_width);
}
module rounded_edges () {
    cylinder(h=preferred_tab_thickness, r=preferred_tab_width/2);
}
module holes() {
    translate([0,0,-1]) {
        cylinder(h=preferred_height + 2, r=main_hole_radius);
        translate ([0,preferred_tab_reach,0]) {
            cylinder (h=preferred_tab_thickness+2, r=secondary_hole_radius);
        }
        translate ([0,preferred_tab_reach * -1,0]) {
            cylinder (h=preferred_tab_thickness+2, r=secondary_hole_radius);
        }
    }
}

module tab () {
    translate ([0,0,preferred_tab_thickness/2]) {
        cube([preferred_tab_width, preferred_tab_reach * 2, preferred_tab_thickness], center=true);
    }
    translate([0,preferred_tab_reach,0]) {
        rounded_edges();
    }
    translate([0,(preferred_tab_reach) * -1,0]) {
        rounded_edges();
    }
}

difference() {
    union() {
        main_component();
        tab();
    }
    holes();
}

