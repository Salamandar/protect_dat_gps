$fn = 100;

clearance = 0.5;
gps_length = 107 + clearance;
gps_thick  =  11 + clearance;
gps_width  =  27 + clearance;

module rounded(height, thick) {
    cylinder(d=thick, h= height);

    translate([0, -thick/2])
    cube([gps_width - gps_thick, thick, height]);

    translate([gps_width - gps_thick, 0])
    cylinder(d=thick, h= height);
}
module gps() {
    rounded(gps_length, gps_thick);
}

split_clearance = 0.2;
topbot_thick = 4;
ext_thick = gps_thick + 4;
mid_thick_int = gps_thick + 2 - split_clearance/2;
mid_thick_out = gps_thick + 2 + split_clearance/2;
split_pos_h = gps_length - 18;
split_height = 2;

module box_botsurface() { 
    translate([0, 0, -topbot_thick])
        rounded(topbot_thick, ext_thick);
}
module box_bot() {
    box_botsurface();
    
    rounded(split_pos_h - split_height/2, ext_thick);
    rounded(split_pos_h + split_height/2, mid_thick_int);
}


module box_topsurface() { 
    translate([0, 0, gps_length])
        rounded(topbot_thick, ext_thick);
}
module box_top() {
    box_topsurface();
    translate([0, 0, split_pos_h - split_height/2]) {
        difference() {
            rounded(gps_length - (split_pos_h - split_height/2), ext_thick);
            translate([0, 0, -0.01])
            rounded(split_height/2, mid_thick_out);
        }
    }
}
module box_top_real() { difference() { box_top(); gps(); } }
module box_bot_real() { difference() { box_bot(); gps(); } }

module fullBox() {
//         box_bot_real();
        box_top_real();
}

module displayBox() {
//     box_bot_real();
    rotate([180, 0, 0])
    translate([40, 0, -gps_length])
    box_top_real();
    
}

displayBox();