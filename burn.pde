// A list of vehicles
ArrayList<Vehicle> vehicles;

void setup() {
  size(800, 800);
  smooth();

  // We are now making random vehicles and storing them in an ArrayList
  vehicles = new ArrayList<Vehicle>();

  background(0);

   for (int i = 0; i < 256; i++) {
      float angle = map(i, 0, 256, 0, TWO_PI);
      vehicles.add(new Vehicle((cos(angle)*(width/5))+width/2, (sin(angle)*(width/5))+height/2));
    }
}

void draw() {
  fill(0, 20);
  rect(0, 0, width, height);

  if (vehicles.size() < 5000) {
    for (int i = 0; i < 50; i++) {
      float angle = map(i, 0, 50, 0, TWO_PI);
      vehicles.add(new Vehicle((cos(angle)*(width/5))+width/2, (sin(angle)*(width/5))+height/2));
    }
  }

  for (Vehicle v : vehicles) {
    // Path following and separation are worked on in this function
    v.separate(vehicles);
    // Call the generic run method (update, borders, display, etc.)
    v.update();

    for (Vehicle vv : vehicles) {
      if (dist(v.xpos(), v.ypos(), vv.xpos(), vv.ypos()) < width/20) {
        stroke(255, map(dist(v.xpos(), v.ypos(), vv.xpos(), vv.ypos()), 0, width/20, 5, 0));
        line(v.xpos(), v.ypos(), vv.xpos(), vv.ypos());
      }
    }
  }

  for (int i = 0; i < vehicles.size(); i++) {
    Vehicle v = vehicles.get(i);
    if (v.isAlive == false) {
      vehicles.remove(i);
    }
  }
}
