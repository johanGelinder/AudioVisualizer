class Pad extends Particle { // the class Pad inherits the Particle class

  //constructor
  Pad(PVector pos_) {

    super( pos_ ); // calling the super constructor
    pos = pos_;
  }

  void update() { 

    collison(); // calling the collision function
    id += 0.007; // increasing id for each frame
    n = (noise(id, pos.x/500, pos.y/600)-0.5) *- 600; // adding noise and storing the values in n
    pos.x += cos(radians(n)); // Calculates the cosine of the angle n and adding it to pos.x every frame
    pos.y += sin(radians(n)); // Calculates the sine of the angle n and adding it to pos.y every frame
  }

  void display() { 

    stroke(255, 0, 0); // setting the colour to red 
    strokeWeight(4); // setting the size of the particle slightly bigger
    point(pos.x, pos.y, pos.z); // drawing the point using pos.x, pos.y and pos.z
  }
}

