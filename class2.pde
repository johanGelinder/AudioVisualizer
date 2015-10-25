class Particle2 extends Particle {  //the class Particle2 inherits the Particle class

  //constructor
  Particle2(PVector pos_) {
    super(pos_); // calling the super constructor
    pos = pos_;
    s = random(1, 2);  // setting s to a random number between 1 to 2
  }

  void update() { 


    collison(); // calling the collision function
    id += 0.007; // / increasing id for each frame
    n = (noise(id, pos.x/500, pos.y/600)-0.5) * 300; // adding noise and storing the values in n
    pos.x += cos(radians(n))*s; // Calculates the cosine of the angle n and adding it to pos.x every frame
    pos.y += sin(radians(n))*s; // Calculates the sine of the angle n and adding it to pos.y every frame
  }

  void display() { 

    stroke(87, 198, 221); // setting the colour to a light blue ( same as colour as the logo )
    strokeWeight(2); // setting the size of the particles
    point(pos.x, pos.y, pos.z); // drawing the point using pos.x, pos.y and pos.z
  }
}

