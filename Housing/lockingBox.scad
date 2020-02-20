// ToDo
// Cord inlet (knockouts?)

in = 25.4;
w = 6*in;
l = 10*in;
h = 4*in;

support = 1;

tabWidth = min(w, l, h)/4;


panelThickness = 0.375*in;
plasticThickness = panelThickness; //0.25*in;
screwRadius = 1.5;
channelDepth = 0.5*in;
lockRadius = 0.5*in;
separation = panelThickness*2;
hinge = false;
longHinge = true;
tabulate = false;
cordInlet = [0.75*in,0.35*in];
knockout = [0.1*in,0.12*in];// false;

//corner(panelThickness, plasticThickness, channelDepth, h, screwRadius, tabWidth, support);

//translate([-w/2,-l/2])trimedFootprint(panelThickness, plasticThickness, channelDepth, false, true);

//3D(w,l,h,panelThickness,plasticThickness,channelDepth,tabWidth,screwRadius,channelDepth,separation,lockRadius,hinge,longHinge,tabulate,cordInlet,knockout,support);

2D(w,l,h,panelThickness,plasticThickness,channelDepth,tabWidth,screwRadius,separation,lockRadius,hinge,longHinge,tabulate,cordInlet,knockout);

/**************************************
* Modules for assembly
**************************************/

module 3D(w,l,h,panelT,plasticT,channelD,tabW,screwR,depth,
        t=1,lock=false,hinge=false,longHinge=false,tabulate=false,inlet=false,KO=false,support=0) {
    
    linear_extrude(panelT)bottom(w,l,panelT,plasticT,tabW);
    
    translate([ (w/2+t),0,h/2+panelT+t])rotate([0,-90,180])
        linear_extrude(panelT)side(l,h,panelT,plasticT,tabW,tabulate, inlet, KO);
    translate([-(w/2+t),0,h/2+panelT+t])rotate([0,-90,  0])
        linear_extrude(panelT)side(l,h,panelT,plasticT,tabW,tabulate, inlet, KO);
    
    translate([0,-(l/2+t),h/2+panelT+t])rotate([90,0,  0])linear_extrude(panelT)
        end(w,h,panelT,plasticT,tabW,lock=lock);
    translate([0, (l/2+t),h/2+panelT+t])rotate([90,0,180])linear_extrude(panelT)
        end(w,h,panelT,plasticT,tabW,hinge||longHinge);
    
    translate([0,0,h+panelT+t*2])linear_extrude(panelT)
        top(w,l,panelT,plasticT,channelD,tabW,screwR,hinge,longHinge,tabulate);
    
    translate([-t*2-(w/2+panelT),-t*2-(l/2+panelT),-plasticT])rotate(  0)
        corner(panelT,plasticT,depth,h,screwR,tabW,support);
    translate([ t*2+(w/2+panelT),-t*2-(l/2+panelT),-plasticT])rotate( 90)
        corner(panelT,plasticT,depth,h,screwR,tabW,support);
    translate([-t*2-(w/2+panelT), t*2+(l/2+panelT),-plasticT])rotate(-90)
        corner(panelT,plasticT,depth,h,screwR,tabW,support);
    translate([ t*2+(w/2+panelT), t*2+(l/2+panelT),-plasticT])rotate(180)
        corner(panelT,plasticT,depth,h,screwR,tabW,support);
}

module 2D(w,l,h,panelT,plasticT,channelD,tabW,
        screwR=false,t=1,lock=false,hinge=false,longHinge=false,
        tabulate=false,inlet=false,KO=false) {
        
    bottom(w, l, panelT, plasticT, tabW);
        
    rotate(  0)translate([(w/2+panelT+plasticT)+t+(h/2+panelT),0])
        side(l, h, panelT, plasticT, tabW, tabulate, inlet, KO);
    rotate(180)translate([(w/2+panelT+plasticT)+t+(h/2+panelT),0])
        side(l, h, panelT, plasticT, tabW, tabulate, inlet, KO);
        
    rotate(180)translate([0,(l/2+panelT+plasticT)+t+(h/2+panelT)])
        end (w, h, panelT, plasticT, tabW, lock=lock);
    rotate(  0)translate([0,(l/2+panelT+plasticT)+t+(h/2+panelT)])
        end (w, h, panelT, plasticT, tabW, hinge||longHinge);
        
    translate([(w/2+panelT+plasticT)*2+t*2+(h+panelT)+((tabulate)?panelT:0),0])
        top(w, l, panelT, plasticT, channelD, tabW, screwR, hinge, longHinge, tabulate);
}


/**************************************
* Modules for 2D panels
**************************************/

module top(w, l, panelT, plasticT, channelD, tabW, screwR = false, hinge = false, longHinge = false, tabulate = false) {
    difference() {
        union() {
            //square([w+panelT*2,l+panelT*2], true);
            square([w+panelT*2+plasticT*2,l], true);
            square([w,l+plasticT*2+panelT*2], true);
            translate([-(w/2+panelT),-(l/2+panelT)])rotate(  0)
                trimedFootprint(panelT, plasticT, channelD, screwR);
            translate([ (w/2+panelT),-(l/2+panelT)])rotate( 90)
                trimedFootprint(panelT, plasticT, channelD, screwR);
            translate([-(w/2+panelT), (l/2+panelT)])rotate(-90)
                trimedFootprint(panelT, plasticT, channelD, screwR);
            translate([ (w/2+panelT), (l/2+panelT)])rotate(180)
                trimedFootprint(panelT, plasticT, channelD, screwR);
        }
        translate([0, (l+panelT)/2])tabs(w-2*panelT, panelT, tabW);
        translate([0,-(l+panelT)/2])tabs(w-2*panelT, panelT, tabW);
        if(tabulate) {
            translate([ (w+panelT)/2,0])rotate(90)tabs(l-2*panelT, panelT, tabW);
            translate([-(w+panelT)/2,0])rotate(90)tabs(l-2*panelT, panelT, tabW);
        }
        if(longHinge) {
            translate([0,(l+3*panelT)/2])tabs(w-2*panelT, panelT, tabW);
        } else if(hinge) {
            translate([0,(l+3*panelT)/2])square([numTabs(w-2*panelT, tabW)*tabW*2-tabW, plasticT], true);
        }
    }
}

module end(width, h, panelT, plasticT, tabW, hinge = false, lock = false, $fn=32) {
    w = width-2*panelT;
    union() {
        square([w,h], true);
        translate([0,-(h+panelT)/2])tabs(w, panelT+0.0001, tabW);   // Adding 0.0001 creates a single piece
        translate([0, (h+panelT)/2])tabs(w, panelT+0.0001, tabW);
        translate([-(w+panelT)/2,0])rotate(90)tabs(h, panelT, tabW);
        translate([ (w+panelT)/2,0])rotate(90)tabs(h, panelT, tabW);
        if(hinge) {
            translate([0,(h+3*panelT)/2])square([numTabs(w, tabW)*tabW*2-tabW, plasticT], true);
        } else if(lock) {
            difference() {
                union() {
                    translate([0,panelT+(h+lock)/2])circle(tabW/2);
                    translate([0,panelT+(h+lock/2)/2])square([tabW,lock/2], true);
                }
                translate([0,panelT+(h+lock)/2])circle(lock/2);
            }
        }
    }
    
}
module side(length, h, panelT, plasticT, tabW, tabulate = true, inlet = false, KO = false) {
    l = length-2*panelT;
    difference() {
        union() {
            square([h,l], true);
            translate([-(h+panelT)/2,0])rotate(90)tabs(l, panelT+0.0001, tabW);   // Adding 0.0001 creates a single piece
            if(tabulate) {
                translate([ (h+panelT)/2,0])rotate(90)tabs(l, panelT+0.0001, tabW);   // Adding 0.0001 creates a single piece
            }
        }
        if(inlet) 
            translate([-h/2,0])rotate(90)inlets(l-tabW, inlet, tabW, KO);
    }
}

module bottom(w, l, panelT, plasticT, tabW) {
    difference() {
        union() {
            square([w+panelT*2,l+panelT*2], true);
            square([w+panelT*2+plasticT*2,l-plasticT*2], true);
            square([w-plasticT*2,l+plasticT*2+panelT*2], true);
        }
        translate([0, (l+panelT)/2])tabs(w-2*panelT, panelT, tabW);
        translate([0,-(l+panelT)/2])tabs(w-2*panelT, panelT, tabW);
        translate([ (w+panelT)/2,0])rotate(90)tabs(l-2*panelT, panelT, tabW);
        translate([-(w+panelT)/2,0])rotate(90)tabs(l-2*panelT, panelT, tabW);
    }
}


/**************************************
* Modules for 3D and 2D construction
**************************************/

module tabs(l, w, tabW) {
    for(i=[0:numTabs(l, tabW)-1]) {
        x= (tabW*2*i)     // Translate each inlet to its position
           +(1-numTabs(l, tabW))*tabW;  // Center entire row
        translate([x,0])square([tabW,w],true);
    }
}

function numTabs(l, tabW) = round(l/tabW/2);

module inlets(l, size, tabW, KO, $fn = 32) {
    for(i=[0:numTabs(l, tabW)-1]) {
        x= (tabW*2*i)     // Translate each inlet to its position
           +(1-numTabs(l, tabW))*tabW;  // Center entire row
        r=min(size[0]/2,size[1]);
        translate([x,(r-size[1])])difference() {
            singleInlet(size, r);
            if(KO) {
                singleInlet(size-[KO[0]*2,KO[0]], r-KO[0]);
                translate([0,-KO[1]/2])square([size[0]+0.001,KO[1]],true);   // Adding 0.001 creates a single piece
                translate([0,-size[1]/2])square([KO[1],size[1]+0.002],true);   // Adding 0.001 creates a single piece
            }
        }
    }
}
module singleInlet(size, r) {
    translate([size[0]/2-r,0])intersection() {circle(r); rotate(-90)square(r);}
    translate([r-size[0]/2,0])intersection() {circle(r); rotate(180)square(r);}
    translate([0,-r/2])square([size[0]-(r*2)+0.001,r],true);   // Adding 0.001 creates a single hole
    translate([0,(size[1]-r)/2])square([size[0],size[1]-r+0.002],true);   // Adding 0.002 creates a single hole
}


/**************************************
* Modules for the 3D corner
**************************************/

module corner(panelT, plasticT, channelD, h, screwR, tabW=false, support=0) {
    translate([0,0,plasticT+panelT])difference() {
        linear_extrude(h)trimedFootprint(panelT, plasticT, channelD, screwR);
        if(tabW) {
            translate([plasticT,panelT/2,h/2])rotate([0,-90,180])linear_extrude(panelT)tabs(h, panelT, tabW);
            translate([panelT/2,plasticT,h/2])rotate([0,-90,-90])linear_extrude(panelT)tabs(h, panelT, tabW);
        }
    }
    translate([0,0,plasticT])
        linear_extrude(panelT)trimedFootprint(panelT, plasticT, channelD, false, true, support);
    linear_extrude(plasticT)footprint(panelT, plasticT, channelD, true);
}

module trimedFootprint(panelT, plasticT, channelD, screwR = false, base = false, support=0) {
    difference() {
        footprint(panelT, plasticT, channelD);
        translate([panelT+plasticT,0])square([channelD+1,panelT]);
        translate([0,panelT+plasticT])square([panelT,channelD+1]);
        if(base){
            translate([panelT+plasticT,-plasticT])square([channelD-support,panelT+plasticT]);
            translate([-plasticT,panelT+plasticT])square([panelT+plasticT,channelD-support]);
            square(panelT+plasticT+channelD-support);
        }
        if(screwR) {
            translate([panelT/2,panelT/2])circle(screwR, $fn=16);
        }
    }
}

module footprint(panelT, plasticT, channelD, base = false, $fn=32) {
    corner = panelT+channelD;
    if(base) {
        offset(r = plasticT)square(corner);
    } else {
        points = [[0,0], [corner,0], [corner,panelT], [panelT,panelT], [panelT, corner], [0,corner]];
        offset(r = plasticT)polygon(points);
    }
}