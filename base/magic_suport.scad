module prism(l, a, p){
    points = [[0,0,0],[0,0,a],[l,0,a],[l, 0, 0],[l, p, a],[0,p,a]];
    faces = [[0,1,2,3],[1,5,4,2],[5,4,3,0],[0,1,5],[2,3,4]];
    polyhedron(points = points, faces = faces);
}

module meia_caixa(l, p, a, z){
    translate([0,2.5,z]) color("Cyan") cube([l, p, a/2]);
}

module peca_superior(l, p, a_major, a_minor,){
    points =    [[0,0,0],
                [0,p,0],
                [l,p,0],
                [l,0,0],
                [0,0,a_minor],
                [0,p,a_major],
                [l,p,a_major],
                [l,0,a_minor]];
    faces = [[0,3,2,1],
            [0,4,7,3],
            [4,5,6,7],
            [5,1,2,6],
            [4,0,1,5],
            [2,3,7,6]];
    difference(){
        translate([0,2.5,1.4]) polyhedron(points = points, faces = faces);
        color("Green") extrude_teclado();
        linear_extrude(height = .1, center = false, convexity = 10);
        color("Pink") rotate([90,0,0]) translate([44.3/2 - .2,1.7,-14.9]) square(size=[1.2,.6], center=false);
        linear_extrude(height = .1, center = false, convexity = 10);
        color("Pink") rotate([90,0,0]) translate([44.3/2 +19.5 - .2,1.7,-14.9]) square(size=[1.2,.6], center=false);
    }
}

module apoio(a, l, p){
    points = [[0,0,0],[0,p,a],[l,p,a],[l,0,0],[l,p,0],[0,p,0]];
    faces = [[0,1,2,3],[1,5,4,2],[0,3,4,5],[1,0,5],[3,2,4]];
    color("Blue") polyhedron(points = points, faces = faces);
}

module extrude_teclado(){
    linear_extrude(height = 3.5, center = false, convexity = 10, twist = 0)
    translate([1.4,3,1.8]) square([41.5, 11.5]);
}

module extrude_pockets(){
    difference(){
        linear_extrude(height = 3.5, center = false, convexity = 10, $fn = 100)
        translate([4*(44.3/5),8.5,0]) circle(5);
    }
    difference(){
        linear_extrude(height = 3.5, center = false, convexity = 10)
        translate([2.5,4.5,0]) square([25, 8]);
    }
}

module pockets(){
    color("Red") difference(){
        meia_caixa(44.3, 12.5, 1.4, 1.4/2);
        extrude_pockets();
    }
}

module suporte_teclado(){
        meia_caixa(44.3, 12.5, 1.4, 0);
        pockets();
        peca_superior(44.3,12.5,1.2,0.3);
        apoio(1.7, 44.3, 2.5);   
}


module suporte_trackpad(){
//    meia_caixa(44.3, 12.5, 1.4, 0);
//    pockets();
//    peca_superior(44.3,12.5,1.2,0.3);
//    apoio(1.7, 44.3, 2.5);
}

suporte_teclado();