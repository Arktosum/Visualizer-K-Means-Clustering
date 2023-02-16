void setup(){

 size(500,500); 
}


class Point{
  float x,y,px,py;
  
  Point(float xin,float yin){
    x = xin;
    y = yin;
    px = xin;
    py = map(yin,0,height,height,0);
  }
}
ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Point> centroids = new ArrayList<Point>();
ArrayList<Point> c1 = new ArrayList<Point>();
ArrayList<Point> c2 = new ArrayList<Point>();
ArrayList<Point> c3 = new ArrayList<Point>();
boolean getData = true;
void draw(){
  background(0);
    for(Point pt : points){
      fill(255);
      ellipse(pt.px,pt.py,10,10);
    }
    
    
    for(Point pt : c1){
      fill(255,0,0);
      ellipse(pt.px,pt.py,10,10);
    }
    
    for(Point pt : c2){
      fill(0,255,0);
      ellipse(pt.px,pt.py,10,10);
    }
    for(Point pt : c3){
      fill(0,0,255);
      ellipse(pt.px,pt.py,10,10);
    }
    
    
    for(Point cent : centroids){
      fill(128,0,128);
      ellipse(cent.px,cent.py,10,10);
    }
    
    
}


void mousePressed(){
  if(getData){
    Point pt = new Point(mouseX,map(mouseY,height,0,0,height));
    points.add(pt);
  }
}

void keyPressed(){
  if (key == 'c'){ println("No more getting data!"); getData = false;}
  if (key == 'k'){ 
  println("Picking 3 random centroids!"); 
  INITIALIZE();
  } 
  if(key == 'x'){
   ITERATE();
  }
}

void INITIALIZE(){
  centroids = new ArrayList<Point>();
  boolean contains;
  while(centroids.size() < 3){
    int randInd = (int)random(parseFloat(points.size()));
    Point randPt = points.get(randInd);
    contains = false;
    for(Point cent : centroids){
      if(cent.x == randPt.x && cent.y == randPt.y){
        contains = true;
        break;
      }
    }
    if (!contains){
      println("added centroid :",centroids.size()+1);
      centroids.add(randPt);
    }
  }
}

float distance(Point p1,Point p2){
  float dist = pow((p1.x - p2.x),2) + pow((p1.y - p2.y),2);
  return pow(dist,0.5);
}
void ITERATE(){
  c1 = new ArrayList<Point>();
  c2 = new ArrayList<Point>();
  c3 = new ArrayList<Point>();
  for(Point pt : points){
    // Find distance between point and cluster
     float d1 = distance(pt,centroids.get(0));
     float d2 = distance(pt,centroids.get(1));
     float d3 = distance(pt,centroids.get(2));
     // Assign cluster
     if((d1 < d2) && (d1 < d3)){
       c1.add(pt);
     }
     else if((d2 < d1) && (d2 < d3)){
       c2.add(pt);
     }
     else if((d3 < d1) && (d3 < d2)){
       c3.add(pt);
     }
  }
  // Recalculate Centroid
  println(c1.size(),c2.size(),c3.size());
  centroids = new ArrayList<Point>();
  
  float sumX = 0.0;
  float sumY = 0.0;
 
  for(Point pt : c1){
    sumX += pt.x;
    sumY += pt.y;
  }
  sumX = sumX / c1.size();
  sumY = sumY / c1.size();
  
  Point newC1 = new Point(sumX,sumY);
  sumX = 0.0;
  sumY = 0.0;
  for(Point pt : c2){
    sumX += pt.x;
    sumY += pt.y;
  }
  sumX = sumX / c2.size();
  sumY = sumY / c2.size();
  Point newC2 = new Point(sumX,sumY);
  sumX = 0.0;
  sumY = 0.0;
  for(Point pt : c3){
    sumX += pt.x;
    sumY += pt.y;
  }
  sumX = sumX / c3.size();
  sumY = sumY / c3.size();
  Point newC3 = new Point(sumX,sumY);
  centroids.add(newC1);
  centroids.add(newC2);
  centroids.add(newC3);
  
}
